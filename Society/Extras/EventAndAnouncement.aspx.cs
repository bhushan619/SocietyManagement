using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;
using System.Data;
using System.Globalization;

public partial class Society_Extras_EventAndAnouncement : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string Employeid = string.Empty;
    static int EditTypeId = 0;
    static string EditPersonalId = string.Empty;
    DateTime datestart, dateend;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getListViewMasterData();
            getCountryData();
        }
    }
    public void getCountryData()
    {
        try
        {
            ddlCountry.DataSource = dbc.GetCountryMasterData();
            ddlCountry.DataTextField = "CountryName";
            ddlCountry.DataValueField = "CountryId";
            ddlCountry.DataBind();
            ddlCountry.Items.Insert(0, new ListItem(":: Select Country ::", ""));

            //ddlEventType.DataSource = dbc.GetEventTypeMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            //ddlEventType.DataTextField = "varEventTypeName";
            //ddlEventType.DataValueField = "intId";
            //ddlEventType.DataBind();
            //ddlEventType.Items.Insert(0, new ListItem(":: Select Event Type ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlState.DataSource = dbc.GetstateMasterDataFromCountryId(Convert.ToInt32(ddlCountry.SelectedValue));
            ddlState.DataTextField = "StateName";
            ddlState.DataValueField = "StateId";
            ddlState.DataBind();
            ddlState.Items.Insert(0, new ListItem(":: Select State ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }

    }
    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlCity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(ddlState.SelectedValue));
            ddlCity.DataTextField = "CityName";
            ddlCity.DataValueField = "CityId";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem(":: Select City ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
            string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
            string fileName = EditPersonalId + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;

            if (contentLength != 0)
            {
                string myStr = ImgProfile.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/Society/Media/Event/") + fileName);

                int Update_ok = dbc.update_tbleventannouncement(Convert.ToInt32(EditTypeId), txtTitle.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), Convert.ToDateTime(DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), txtStartTime.Text.Replace("'", "\\'"), txtEndTime.Text.Replace("'", "\\'"), txtEventLocation.Text.Replace("'", "\\'"), txtEventCapacity.Text.Replace("'", "\\'"), Convert.ToInt32(ddlCountry.SelectedValue), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue), txtPinZip.Text.Replace("'", "\\'"), txtEContactName.Text.Replace("'", "\\'"), txtEMobile.Text.Replace("'", "\\'"), txtEEmail.Text.Replace("'", "\\'"), fileName, chkIsActive.Checked ? 1 : 0);

                if (Update_ok == 1)
                {
                  //  dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", EditPersonalId, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[0], dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[1], "New Event & Ennouncement Uploaded by ", "", "", "Unread", "");
                    MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                    clear();
                }
                else
                {
                    MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                }
            }
            else
            {
                string[] imgname = ImgProfile.ImageUrl.Split('/');
                int Update_ok = dbc.update_tbleventannouncement(Convert.ToInt32(EditTypeId), txtTitle.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), Convert.ToDateTime(DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), txtStartTime.Text.Replace("'", "\\'"), txtEndTime.Text.Replace("'", "\\'"), txtEventLocation.Text.Replace("'", "\\'"), txtEventCapacity.Text.Replace("'", "\\'"), Convert.ToInt32(ddlCountry.SelectedValue), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue), txtPinZip.Text.Replace("'", "\\'"), txtEContactName.Text.Replace("'", "\\'"), txtEMobile.Text.Replace("'", "\\'"), txtEEmail.Text.Replace("'", "\\'"), imgname[4], chkIsActive.Checked ? 1 : 0);

                if (Update_ok == 1)
                {
                  //  dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", EditPersonalId, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[0], dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[1], "New Event & Ennouncement Uploaded by ", "", "", "Unread", "");
                   
                    MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                    clear();
                }
                else
                {
                    MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                }
            }
                btnSubmit.Visible = true;
            btnUpdate.Visible = false;

            EditTypeId = 0;
            getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {

            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edits")
            {

                btnUpdate.Visible = true;
                btnSubmit.Visible = false;
                dbc.con1.Close();
                dbc.con1.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, intEventType, varSubject, varDescription, varStartDate, varEndDate, varStartTime, varEndTime, varLocation,                    varEventCapacity, intCountry, intState, intCity, varPin, varContactName, varMobile, varEmail,                    varEventImage, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5 FROM tbleventannouncement WHERE intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con1);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId = Convert.ToInt32(dbc.dr["intId"].ToString());
                    EditPersonalId = (dbc.dr["varPersonalId"].ToString());
                    txtTitle.Text = dbc.dr["varSubject"].ToString();
                    txtDescription.Text = dbc.dr["varDescription"].ToString();
                    txtStartDate.Text = Convert.ToDateTime(dbc.dr["varStartDate"].ToString()).ToString("dd-MM-yyyy");
                    txtEndDate.Text = Convert.ToDateTime(dbc.dr["varEndDate"].ToString()).ToString("dd-MM-yyyy");
                    txtStartTime.Text = dbc.dr["varStartTime"].ToString();
                    txtEndTime.Text = dbc.dr["varEndTime"].ToString();
                    txtEventLocation.Text = dbc.dr["varLocation"].ToString();

                    txtEventCapacity.Text = dbc.dr["varEventCapacity"].ToString();
                    txtPinZip.Text = dbc.dr["varPin"].ToString();
                    txtEContactName.Text = dbc.dr["varContactName"].ToString();
                    txtEMobile.Text = dbc.dr["varMobile"].ToString(); 
                             txtEEmail.Text = dbc.dr["varEmail"].ToString();

                    ddlCountry.SelectedIndex = Convert.ToInt32(dbc.dr["intCountry"].ToString());
                    ddlState.DataSource = dbc.GetstateMasterDataFromCountryId(Convert.ToInt32(dbc.dr["intCountry"].ToString()));

                    ddlState.DataTextField = "StateName";
                    ddlState.DataValueField = "StateId"; ddlState.DataBind();
                    ddlState.SelectedValue = dbc.dr["intState"].ToString();
                    ddlCity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(dbc.dr["intState"].ToString()));

                    ddlCity.DataTextField = "CityName";
                    ddlCity.DataValueField = "CityId"; ddlCity.DataBind();

                    ddlCity.SelectedValue = dbc.dr["intCity"].ToString();
                    ImgProfile.ImageUrl = "~/Society/Media/Event/" + dbc.dr["varEventImage"].ToString();
                    
                  //  ddlEventType.SelectedValue = (dbc.dr["intEventType"].ToString());

                    if (Convert.ToInt32(dbc.dr["intIsActive"].ToString()) == 1)
                    {
                        chkIsActive.Checked = true;
                    }
                    else
                    {
                        chkIsActive.Checked = false;
                    }

                }
                dbc.con1.Close();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            datestart = DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);
            dateend = DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);
            if (datestart < dateend)
            {
                string personel = string.Empty;
                string notificationby = string.Empty;
                if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
                {
                    personel = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);
                    notificationby = dbc.get_PropertyOwnerName(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["CookiePropertyId"].Value));
                }
                else
                {
                    personel = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value);
                    notificationby = dbc.get_EmployeeName(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value));
                }
                int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
                string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
                string fileName = personel + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;
                if (contentLength != 0)
                {
                    string myStr = ImgProfile.ImageUrl;
                    string[] ssize = myStr.Split('/');
                    fupProPic.PostedFile.SaveAs(Server.MapPath("~/Society/Media/Event/") + fileName);
                }
                else
                {
                    fileName = "NoProfile.png";
                }
                int insert_ok = dbc.insert_tbleventannouncement(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), personel, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), "0", txtTitle.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), Convert.ToDateTime(DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), txtStartTime.Text.Replace("'", "\\'"), txtEndTime.Text.Replace("'", "\\'"), txtEventLocation.Text.Replace("'", "\\'"), txtEventCapacity.Text.Replace("'", "\\'"), ddlCountry.SelectedValue, ddlState.SelectedValue, ddlCity.SelectedValue, txtPinZip.Text.Replace("'", "\\'"), txtEContactName.Text.Replace("'", "\\'"), txtEMobile.Text.Replace("'", "\\'"), txtEEmail.Text.Replace("'", "\\'"), fileName, DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), personel, Convert.ToInt32(chkIsActive.Checked ? 1 : 0));
                if (insert_ok == 1)
                {
                    dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", personel, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[0], dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[1], "New Event & Ennouncement Uploaded by " + notificationby, "", "", "Unread", "");
                    MessageDisplay(Resources.Messages.Added, "alert alert-success");
                    clear();
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
                }
                clear();
                getListViewMasterData();
            }
            else if (datestart.ToString("dd-MM-yyyy").Equals(dateend.ToString("dd-MM-yyyy")))
            {
                string personel = string.Empty;
                string notificationby = string.Empty;
                if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
                {
                    personel = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);
                    notificationby = dbc.get_PropertyOwnerName(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["CookiePropertyId"].Value));
                }
                else
                {
                    personel = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value);
                    notificationby = dbc.get_EmployeeName(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value));
                }
                int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
                string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
                string fileName = personel + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;
                if (contentLength != 0)
                {
                    string myStr = ImgProfile.ImageUrl;
                    string[] ssize = myStr.Split('/');
                    fupProPic.PostedFile.SaveAs(Server.MapPath("~/Society/Media/Event/") + fileName);
                }
                else
                {
                    fileName = "NoProfile.png";
                }
                int insert_ok = dbc.insert_tbleventannouncement(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), personel, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), "0", txtTitle.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), Convert.ToDateTime(DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), txtStartTime.Text.Replace("'", "\\'"), txtEndTime.Text.Replace("'", "\\'"), txtEventLocation.Text.Replace("'", "\\'"), txtEventCapacity.Text.Replace("'", "\\'"), ddlCountry.SelectedValue, ddlState.SelectedValue, ddlCity.SelectedValue, txtPinZip.Text.Replace("'", "\\'"), txtEContactName.Text.Replace("'", "\\'"), txtEMobile.Text.Replace("'", "\\'"), txtEEmail.Text.Replace("'", "\\'"), fileName, DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), personel, Convert.ToInt32(chkIsActive.Checked ? 1 : 0));
                if (insert_ok == 1)
                {
                    dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", personel, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[0], dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[1], "New Event & Ennouncement Uploaded by " + notificationby, "", "", "Unread", "");
                    MessageDisplay(Resources.Messages.Added, "alert alert-success");
                    clear();
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
                }
                clear();
                getListViewMasterData();
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.CurrectDate, "alert alert-danger");
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                EditPersonalId = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, intEventType, varSubject, varDescription, DATE_FORMAT(varStartDate,'%d-%m-%Y') as varStartDate, DATE_FORMAT(varEndDate,'%d-%m-%Y') as varEndDate, varStartTime, varEndTime, varLocation, varEventCapacity, intCountry, intState, intCity, varPin, varContactName, varMobile, varEmail, varEventImage, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5 FROM tbleventannouncement WHERE varPersonalId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "'", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adp.Fill(dt);

                lstType.DataSource = dt;
                lstType.DataBind();
                dbc.con.Close();
            }
            else
            {
                EditPersonalId = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value);
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, intEventType, varSubject, varDescription, DATE_FORMAT(varStartDate,'%d-%m-%Y') as varStartDate, DATE_FORMAT(varEndDate,'%d-%m-%Y') as varEndDate, varStartTime, varEndTime, varLocation, varEventCapacity, intCountry, intState, intCity, varPin, varContactName, varMobile, varEmail, varEventImage, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5 FROM tbleventannouncement WHERE varPersonalId='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adp.Fill(dt);

                lstType.DataSource = dt;
                lstType.DataBind();
                dbc.con.Close();

            }
        }
        catch (Exception ex)
        {
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }

    public void clear()
    {
        //ddlEventType.SelectedIndex = 0;
        ddlCountry.SelectedIndex = 0;

        ddlState.Items.Clear();
        ddlState.Items.Insert(0, new ListItem(":: Select State ::", ""));

        ddlCity.Items.Clear();
        ddlCity.Items.Insert(0, new ListItem(":: Select City ::", "")); 

        txtDescription.Text = "";
        txtEContactName.Text = "";
        txtEEmail.Text = "";
        txtEMobile.Text = "";
        txtEndDate.Text = "";
        txtEndTime.Text = "";
        txtEventCapacity.Text = "";
        txtEventLocation.Text = "";
        txtPinZip.Text = "";
        txtStartDate.Text = "";
        txtStartTime.Text = "";
        txtTitle.Text = "";
        chkIsActive.Checked = false;
        ImgProfile.ImageUrl = "~/Society/Media/Event/NoProfile.png";
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
}