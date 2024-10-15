using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using System.Data;
using System.Configuration;
using System.Collections; 
using System.Web.Security; 
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Configuration;
using MySql.Data.MySqlClient;

public partial class Society_Property_Dashbord : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string EditPersonalId = string.Empty;
    static int newCountStart = 0;
    static int newCountEnd = 0;
    static int EditfamilyintId = 0;
    static string EditTypeId = string.Empty;
    static string EditPropertyFlatintId = string.Empty;
    static string EditVehicalTypeId = string.Empty;
    static string Propertyid = string.Empty;
    string gen = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Request.Cookies["CookieSocietyId"]) == null)
        {
            Response.Redirect("~/Home/Login.aspx", false);
        }
        else if (Request.Cookies["CookiePropertyId"] == null)
        {
            Response.Redirect("~/Home/Login.aspx", false);
        }
        else if (!IsPostBack)
        {

            getAlbum();
            newCountStart = 0;
            newCountEnd = 0;
            getPollQueData();

            getPremisesData();
            getPropertyData();
            getClassifiedData();
            getEventEnnouncementData();

            string query = "  SELECT DISTINCT    CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name, tblinvoice.varInvoiceId AS InvoiceNo,   ";
            query += "    DATE_FORMAT(tblinvoice.varDateTime,'%d-%m-%Y')  AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,   ";
            query += "       tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`,tblinvoiceforpersonnels.varPersonnelId  ";
            query += "  FROM    tblinvoice INNER JOIN  ";
            query += "    tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  ";
            query += "       tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN  ";
            query += "      tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN  ";
            query += "   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblinvoiceforpersonnels.varPersonnelId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "' order by tblinvoice.intid desc  ";

            SqlDataSourceInvoice.SelectCommand = query;

            string querynoticeborde = "  SELECT tblsocietynoticeboard.intId, tblsocietynoticeboard.varSocietyId, tblsocietynoticeboard.varPersonalId, tblsocietynoticeboard.intRole, tblsocietynoticeboard.varSubject, tblsocietynoticeboard.varDescription, tblsocietynoticeboard.varCreatedDate, tblsocietynoticeboard.varCreatedBy, tblsocietynoticeboard.varStatus, tblsocietynoticeboard.intIsActive, ";
            querynoticeborde += "   CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')', tblproperty.varName) AS Property FROM tblsocietynoticeboard INNER JOIN tblproperty ON tblsocietynoticeboard.varPersonalId = tblproperty.varPropertyId INNER JOIN  tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId  where tblsocietynoticeboard.intIsActive=1 and tblsocietynoticeboard.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by  tblsocietynoticeboard.intId desc limit 10";
            SqlNoticeboard.SelectCommand = querynoticeborde;         
        }


    }
    public void getEventEnnouncementData()
    {
        try
        {
            DataTable dt = new DataTable();

            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            string query = "SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole, ";
            query += "  tbleventannouncement.varSubject, tbleventannouncement.varDescription,DATE_FORMAT(tbleventannouncement.varStartDate,'%d-%m-%Y') as varStartDate, ";
            query += " DATE_FORMAT(tbleventannouncement.varEndDate,'%d-%m-%Y') as varEndDate , tbleventannouncement.varStartTime, tbleventannouncement.varEndTime, tbleventannouncement.varLocation, ";
            query += " tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, tbleventannouncement.varContactName, tbleventannouncement.varMobile, ";
            query += " tbleventannouncement.varEmail, tbleventannouncement.varEventImage, tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy, ";
            query += " tbleventannouncement.intIsActive, countrymaster.CountryName, statemaster.StateName, citymaster.CityName,";
            query += " CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name";
            query += " FROM tbleventannouncement INNER JOIN";
            query += " countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN";
            query += " statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN";
            query += " citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN";
            query += " tblproperty ON tbleventannouncement.varPersonalId = tblproperty.varPropertyId INNER JOIN";
            query += " tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId  ";
            cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " WHERE tbleventannouncement.intIsActive =1 and tbleventannouncement.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  order by tbleventannouncement.intId desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            dbc.con.Close();
            query = string.Empty;
            query += "SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole, ";
            query += " tbleventannouncement.varSubject, tbleventannouncement.varDescription, DATE_FORMAT(tbleventannouncement.varStartDate, ";
            query += " '%d-%m-%Y') AS varStartDate, DATE_FORMAT(tbleventannouncement.varEndDate, '%d-%m-%Y') AS varEndDate, tbleventannouncement.varStartTime, ";
            query += " tbleventannouncement.varEndTime, tbleventannouncement.varLocation, tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, ";
            query += " tbleventannouncement.varContactName, tbleventannouncement.varMobile, tbleventannouncement.varEmail, tbleventannouncement.varEventImage, ";
            query += " tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy, tbleventannouncement.intIsActive, countrymaster.CountryName, ";
            query += " statemaster.StateName, citymaster.CityName, concat(rolesmasterculturemap.RoleName,'-' ,tblsocietypersonnel.varEmpName) as Name";
            query += " FROM tbleventannouncement INNER JOIN";
            query += " countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN";
            query += " statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN";
            query += " citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN";

            query += " tblsocietypersonnel ON tbleventannouncement.varPersonalId = tblsocietypersonnel.intEmpCode INNER JOIN";
            query += " rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId";

            cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " WHERE tbleventannouncement.intIsActive =1 and tbleventannouncement.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  order by tbleventannouncement.intId desc", dbc.con);
            adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }   
    public void getClassifiedData()
    {
        try
        {
            DataTable dt = new DataTable();

            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varSubject, varDescription, varLocation, intCountry, intState, intCity, varPin, varContactName, varMobile, varEmail, varClassifiedImage, varCreatedDate, varCreatedBy, intIsActive FROM tblclassified WHERE intIsActive =1 and varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by  intId desc limit 4", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstTypeClassified.DataSource = dt;
            lstTypeClassified.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    public void getPropertyData()
    {
        try
        {
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varPropertyId, varSocietyId, intRoleId, intWingId, intPremisesUnitId, intPremisesTypeId, varPropertyCode, varName,varExtensionNo, varAlternateAddress, varPhoneNo, varMobile, varEmail, varUsername, varPassword, varCreatedDate, varCreatedBy,varAlternateMobile,varAlternateEmail, intIsActive FROM tblproperty WHERE varPropertyId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "'", dbc.con1);

            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                ddlWing.SelectedValue = dbc.dr["intWingId"].ToString();
                getPrimisesUnit(dbc.dr["intPremisesUnitId"].ToString());

                ddlPremisesType.SelectedValue = dbc.dr["intPremisesTypeId"].ToString();


                ddlPremises.SelectedValue = dbc.dr["intPremisesUnitId"].ToString();
                txtflatno.Text = dbc.dr["varPropertyCode"].ToString();
                txtPropertyExtensionNumber.Text = dbc.dr["varExtensionNo"].ToString();

                EditTypeId = dbc.dr["varUsername"].ToString();
                txtowner.Text = dbc.dr["varName"].ToString();
                txtphone.Text = dbc.dr["varPhoneNo"].ToString();
                txtmobile.Text = dbc.dr["varMobile"].ToString();
                txtEmail.Text = dbc.dr["varEmail"].ToString();
                txtAltMobileNos.Text = dbc.dr["varAlternateMobile"].ToString();
                txtAltEmailIds.Text = dbc.dr["varAlternateEmail"].ToString();


                ddlWing.Enabled = false;
                ddlPremises.Enabled = false;
                ddlPremisesType.Enabled = false;
                txtflatno.Enabled = false;
                txtPropertyExtensionNumber.Enabled = false;

            }
            dbc.con1.Close();
        }
        catch (Exception ex)
        {
            dbc.con1.Close();
            string exp = ex.Message;
        }
    }

    public void getPremisesData()
    {
        try
        {
            ddlWing.DataSource = dbc.GetSocietyWingMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlWing.DataTextField = "varWingName";
            ddlWing.DataValueField = "intId";
            ddlWing.DataBind();
            ddlWing.Items.Insert(0, new ListItem(":: Select Premises ::", ""));

            ddlPremises.DataSource = dbc.GetUnitTypeMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlPremises.DataTextField = "varUnitTypeName";
            ddlPremises.DataValueField = "intId";
            ddlPremises.DataBind();
            ddlPremises.Items.Insert(0, new ListItem(":: Select Premises ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }


    }
    protected void ddlPremises_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            getPrimisesUnit(ddlPremises.SelectedValue);
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getPrimisesUnit(string premises)
    {
        try
        {
            ddlPremisesType.DataSource = dbc.GetFlatPremisesTypeMasterDataDropdown(Convert.ToInt32(premises), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlPremisesType.DataTextField = "varFlatPremisesName";
            ddlPremisesType.DataValueField = "intId";
            ddlPremisesType.DataBind();
            ddlPremisesType.Items.Insert(0, new ListItem(":: Select Premises Type ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;

        }

    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);

    }
    public void getAlbum()
    {
        try
        {

            sqlGallery.SelectCommand = "SELECT  intId, varSocietyId, varPersonalId, intRole, varSubject, varDescription, varGallaryImage, varCreatedDate, varCreatedBy, intIsActive FROM tblsocietygallary where varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and intRole=" + dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Admin") + " order by intid desc limit 6";
            LstGallary.DataBind();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
   
   

    protected void lstInvoices_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            string[] cmdArgs = e.CommandArgument.ToString().Split(':');
            Cache["InvoiceId"] = cmdArgs[0].ToString();
            Cache["PersonnelId"] = cmdArgs[1].ToString();
            if (e.CommandName == "view")
            {
                Response.Redirect("~/Society/Property/ViewInvoices.aspx", false);
            }
            else
            {
                dbc.con.Close();
                dbc.con.Open();
                MySqlCommand da = new MySqlCommand("SELECT tblproperty.varName AS name, CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) AS address, tblinvoice.varDateTime AS dat, tblinvoiceforpersonnels.varOutstanding, tblinvoice.varTotal, tblinvoice.varInvoiceId, tblinvoiceforpersonnels.varPersonnelId,tblproperty.varMobile, tblproperty.varEmail, tblinvoiceforpersonnels.varPaymentStatus FROM tblproperty INNER JOIN tblinvoiceforpersonnels ON tblproperty.varPropertyId = tblinvoiceforpersonnels.varPersonnelId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId INNER JOIN tblinvoice ON tblinvoiceforpersonnels.varInvoiceId = tblinvoice.varInvoiceId WHERE  (tblproperty.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') AND  (tblinvoice.varInvoiceId = '" + Cache["InvoiceId"].ToString() + "') AND(tblinvoiceforpersonnels.varPersonnelId = '" + Cache["PersonnelId"].ToString() + "')", dbc.con);
                dbc.dr1 = da.ExecuteReader();
                if (dbc.dr1.Read())
                {
                    Response.Redirect("~/Society/Payprocess/Default.aspx?amount=" + dbc.dr1["varTotal"].ToString() + "&firstname=" + dbc.dr1["name"].ToString() + "&email=" + dbc.dr1["varEmail"].ToString() + "&phone=" + dbc.dr1["varMobile"].ToString() + "&productinfo=SKSPPAYMENT&udf1=" + cmdArgs[0].ToString() + "&udf2=" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "&udf3=" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "&surl=http://societykatta.com/Society/Property/ViewInvoices.aspx&furl=http://societykatta.com/Society/Property/Invoices.aspx", false);
                    dbc.con.Close(); dbc.dr1.Dispose();
                }
                dbc.con.Close();
                dbc.dr1.Dispose();
            }
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            dbc.dr1.Dispose();
            string exp = ex.Message;
        }
        
    }
    
    public void getPollQueData()
    {
        try
        {
            newCountStart = newCountStart + 1;
            newCountEnd = newCountEnd + 1;
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varQuestion, varOptionalText, varOption1, varOption2, varOption3, varOption4, varAnswer, varContactName, varMobile, varEmail, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5 FROM tblpoll WHERE intIsActive=1 and varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by intId desc limit " + newCountStart + "," + newCountEnd + "", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            lstPoll.DataSource = dt;
            lstPoll.DataBind();
            dbc.con.Close();

            dbc.con.Open();
            cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intPollId, varSocietyId, varPersonalId, varAnswer, varAnswerDate, varAnswerTime, varRemark FROM tblpollanswer WHERE  intPollId=" + dt.Rows[0][0].ToString() + " and varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and varPersonalId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "'", dbc.con);
            dbc.dr2 = cmd.ExecuteReader();
            if (dbc.dr2.Read())
            {
                dt.Rows.Clear();
                dbc.con.Close();
                getPollQueData();
            }
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void btnPollAnswer_Click(object sender, System.EventArgs e)
    {
        try
        {
            string answer = string.Empty;
            RadioButton op1 = new System.Web.UI.WebControls.RadioButton();
            RadioButton op2 = new System.Web.UI.WebControls.RadioButton();
            RadioButton op3 = new System.Web.UI.WebControls.RadioButton();
            RadioButton op4 = new System.Web.UI.WebControls.RadioButton();
            Label ridPoll = new System.Web.UI.WebControls.Label();
            foreach (ListViewDataItem item in lstPoll.Items)
            {
                op1 = (RadioButton)item.FindControl("op1");
                op2 = (RadioButton)item.FindControl("op2");
                op3 = (RadioButton)item.FindControl("op3");
                op4 = (RadioButton)item.FindControl("op4");
                ridPoll = (Label)item.FindControl("idPoll");

                answer = op1.Checked ? op1.Text : op2.Checked ? op2.Text : op3.Checked ? op3.Text : op4.Checked ? op4.Text : "";
            }

            if (answer == "")
            {
                Response.Write("<script>alert('Please Select Answer..!!')</script>");
            }
            else
            {
                int insert_ok = dbc.insert_tblpollanswer(Convert.ToInt32(ridPoll.Text), rex.DecryptString(Request.Cookies["CookiePropertyId"].Value), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), answer, DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), DateTime.UtcNow.AddMinutes(330).ToString("hh:mm:ss"), "");
                if (insert_ok == 1)
                {
                    Response.Write("<script>alert('Poll answer submitted successfully..!!')</script>");
                }
            }
            newCountStart = -1;
            newCountEnd = 0;
            getPollQueData();
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

            int Update_ok = dbc.update_tblproperty(rex.DecryptString(Request.Cookies["CookiePropertyId"].Value), txtowner.Text.Replace("'", "\\'"), "Male", txtPropertyExtensionNumber.Text.Replace("'", "\\'"), txtphone.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), txtAltMobileNos.Text.Replace("'", "\\'"), txtAltEmailIds.Text.Replace("'", "\\'"),1);

            if (Update_ok == 1)
            {
                MessageDisplay(Resources.Messages.Updated, "alert alert-success");
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }

            btnUpdate.Visible = false;
            myproerty.Visible = true;

        }
        catch (Exception ex)
        {
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }
}