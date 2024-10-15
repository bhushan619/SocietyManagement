using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Collections.Generic;
using System.IO;
using System.Globalization;
using System.Net.Mail;
using System.Net;

public partial class SK_Employee_AddEmployee : System.Web.UI.Page
{
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    static string Employeid = string.Empty;
    static string EditEmpId = string.Empty;
    static int EditId = 0;
    string gen = string.Empty;
    string Maritalstatus = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getDepartmentData();
            getCountryData();
            getListViewMasterData();

        }
    }
    public void getDepartmentData()
    {
        try
        {
            ddlDepartment.DataSource = dbc.GetDepartmentMasterDataDropdownForAddEmployee();
            ddlDepartment.DataTextField = "varDepartmentName";
            ddlDepartment.DataValueField = "intId";
            ddlDepartment.DataBind();
            ddlDepartment.Items.Insert(0, new ListItem(":: Select Department ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void clear()
    {
        ddlRole.SelectedIndex = 0;
        ddlEmpType.SelectedIndex = 0;
        ddlDepartment.SelectedIndex = 0;
        ddlRole.Items.Clear();
        ddlRole.Items.Add(":: Select Role ::");
        ddlRole.Items[0].Value = "";

        ddlCountry.SelectedIndex = 0;

        ddlState.Items.Clear();
        ddlState.Items.Insert(0, new ListItem(":: Select State ::", ""));

        ddlCity.Items.Clear();
        ddlCity.Items.Insert(0, new ListItem(":: Select City ::", ""));

        txtAddress.Text = "";
        txtDateofJoin.Text = "";
        txtDOB.Text = "";
        txtEmpName.Text = "";
        txtESINo.Text = "";
        txtFatherHusband.Text = "";
        txtOtherContact.Text = "";
        txtOtherEmail.Text = "";      
        txtPANNo.Text = "";
        txtPassword.Text = "";     
        txtPermanentAddress.Text = "";
        txtPFNo.Text = "";
        txtPinZip.Text = "";       
        txtPrimaryContact.Text = "";
        txtUsername.Text = "";

        ImgProfile.ImageUrl = "~/SK/Media/ProfilePhoto/NoProfile.png";
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlRole.Items.Clear();
            ddlRole.Items.Add(":: Select Role ::");
            ddlRole.Items[0].Value = "";
           
                ddlRole.DataSource = dbc.GetRoleListByDeptId(Convert.ToInt32(ddlDepartment.SelectedValue));
                ddlRole.DataTextField = "RoleName";
                ddlRole.DataValueField = "RoleId";
                ddlRole.DataBind();

              
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
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
            string fileName = EditEmpId + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;

            if (contentLength != 0)
            {
                string myStr = ImgProfile.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/SK/Media/ProfilePhoto/") + fileName);
                int Update_ok = dbc.update_tblskpersonnel(Convert.ToInt32(EditId), Convert.ToInt32(ddlDepartment.SelectedValue), Convert.ToInt32(ddlRole.SelectedValue), Convert.ToInt32(ddlEmpType.SelectedValue), txtEmpName.Text.Replace("'", "\\'"),  rgbMarried.Checked ? "Married" : "Unmarried", txtFatherHusband.Text.Replace("'", "\\'"),  Convert.ToDateTime(DateTime.ParseExact(txtDateofJoin.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), rgbMale.Checked ? "Male" : "Female", txtPrimaryContact.Text.Replace("'", "\\'"), txtOtherContact.Text.Replace("'", "\\'"), txtOtherEmail.Text.Replace("'", "\\'"), txtPANNo.Text.Replace("'", "\\'"), txtPFNo.Text.Replace("'", "\\'"), txtESINo.Text.Replace("'", "\\'"), Convert.ToInt32(ddlCountry.SelectedValue), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue), txtPinZip.Text.Replace("'", "\\'"), txtAddress.Text.Replace("'", "\\'"), txtPermanentAddress.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), fileName, chkIsActive.Checked ? 1 : 0);

                if (Update_ok == 1)
                {
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
                int Update_ok = dbc.update_tblskpersonnel(Convert.ToInt32(EditId), Convert.ToInt32(ddlDepartment.SelectedValue), Convert.ToInt32(ddlRole.SelectedValue), Convert.ToInt32(ddlEmpType.SelectedValue), txtEmpName.Text.Replace("'", "\\'"),  rgbMarried.Checked ? "Married" : "Unmarried", txtFatherHusband.Text.Replace("'", "\\'"),  Convert.ToDateTime(DateTime.ParseExact(txtDateofJoin.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), rgbMale.Checked ? "Male" : "Female", txtPrimaryContact.Text.Replace("'", "\\'"), txtOtherContact.Text.Replace("'", "\\'"), txtOtherEmail.Text.Replace("'", "\\'"), txtPANNo.Text.Replace("'", "\\'"), txtPFNo.Text.Replace("'", "\\'"), txtESINo.Text.Replace("'", "\\'"), Convert.ToInt32(ddlCountry.SelectedValue), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue), txtPinZip.Text.Replace("'", "\\'"), txtAddress.Text.Replace("'", "\\'"), txtPermanentAddress.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), imgname[4], chkIsActive.Checked ? 1 : 0);

                if (Update_ok == 1)
                {
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
            EditId = 0;

            txtPassword.Visible = true;           

            getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Employeid = string.Concat("SKSE", dbc.CreateRandomMemberId(7));

        int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
        string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
        string fileName = Employeid + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;
        if (dbc.check_already_EmployeeId(Employeid) == 1)
        {
            Employeid = string.Concat("SKSE", dbc.CreateRandomMemberId(7));
        }
        else
        {
            if (contentLength != 0)
            {
                string myStr = ImgProfile.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/SK/Media/ProfilePhoto/") + fileName);
                
                    int insert_ok = dbc.insert_tblskpersonnel( Employeid, Convert.ToInt32(ddlDepartment.SelectedValue), Convert.ToInt32(ddlRole.SelectedValue), Convert.ToInt32(ddlEmpType.SelectedValue), txtEmpName.Text.Replace("'", "\\'"),  rgbMarried.Checked ? "Married" : "Unmarried", txtFatherHusband.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtDateofJoin.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), rgbMale.Checked ? "Male" : "Female", txtPrimaryContact.Text.Replace("'", "\\'"), txtOtherContact.Text.Replace("'", "\\'"), txtOtherEmail.Text.Replace("'", "\\'"), txtPANNo.Text.Replace("'", "\\'"), txtPFNo.Text.Replace("'", "\\'"), txtESINo.Text.Replace("'", "\\'"), Convert.ToInt32(ddlCountry.SelectedValue), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue), txtPinZip.Text.Replace("'", "\\'"), txtAddress.Text.Replace("'", "\\'"), txtPermanentAddress.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), txtPassword.Text.Replace("'", "\\'"), txtPrimaryContact.Text.Replace("'", "\\'"),  fileName, chkIsActive.Checked ? 1 : 0,  rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) , DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"));
                    if (insert_ok == 1)
                    {
                        sendmail(txtEmpName.Text.Replace("'", "\\'"), txtPassword.Text.Replace("'", "\\'"), Employeid, txtUsername.Text);
                        MessageDisplay(Resources.Messages.Added, "alert alert-success");

                        clear();
                    }
                    else
                    {
                        MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
                    }
                
            }
            else
            {

                  int insert_ok = dbc.insert_tblskpersonnel(Employeid, Convert.ToInt32(ddlDepartment.SelectedValue), Convert.ToInt32(ddlRole.SelectedValue), Convert.ToInt32(ddlEmpType.SelectedValue), txtEmpName.Text.Replace("'", "\\'"), rgbMarried.Checked ? "Married" : "Unmarried", txtFatherHusband.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtDateofJoin.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), rgbMale.Checked ? "Male" : "Female", txtPrimaryContact.Text.Replace("'", "\\'"), txtOtherContact.Text.Replace("'", "\\'"), txtOtherEmail.Text.Replace("'", "\\'"), txtPANNo.Text.Replace("'", "\\'"), txtPFNo.Text.Replace("'", "\\'"), txtESINo.Text.Replace("'", "\\'"), Convert.ToInt32(ddlCountry.SelectedValue), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue), txtPinZip.Text.Replace("'", "\\'"), txtAddress.Text.Replace("'", "\\'"), txtPermanentAddress.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), txtPassword.Text.Replace("'", "\\'"), txtPrimaryContact.Text.Replace("'", "\\'"), "NoProfile.png", chkIsActive.Checked ? 1 : 0, "1", DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"));
                 
                    if (insert_ok == 1)
                    {
                        sendmail(txtEmpName.Text.Replace("'", "\\'"), txtPassword.Text.Replace("'", "\\'"), Employeid, txtUsername.Text);
                        MessageDisplay(Resources.Messages.Added, "alert alert-success");

                        clear();
                    }
                    else
                    {
                        MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
                    }
               
            }
        }
        clear();
        getListViewMasterData();
    }
  
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intEmpCode, intDeptId, intRole, intEmpType, varEmpName, varMaritalStatus, varFatherHusband, varDateOfJoin, varDOB, varGender, varMbPrimary, varMbOther, varEmailOther, varPANNo, varPFNo, varESINo, intCountry, intState, intCity, varPin, varAddress, varPermanentAddress, varPrimaryEmail, varUsername, varPassword, varMobile, varImage, intIsActive, intCreatedBy, varCreatedDate, ex1, ex2, ex3 FROM tblskpersonnel   where intEmpCode !='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "' order by intId desc", dbc.con);// where intEmpCode !='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
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
                dbc.con1.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intEmpCode, intDeptId, intRole, intEmpType, varEmpName, varMaritalStatus, varFatherHusband, DATE_FORMAT( varDateOfJoin,'%d-%m-%Y') AS varDateOfJoin,  DATE_FORMAT( varDOB,'%d-%m-%Y') AS  varDOB, varGender, varMbPrimary, varMbOther, varEmailOther, varPANNo, varPFNo, varESINo, intCountry, intState, intCity, varPin, varAddress, varPermanentAddress, varPrimaryEmail, varUsername, varPassword, varMobile, varImage, intIsActive, intCreatedBy, varCreatedDate, ex1, ex2, ex3 FROM tblskpersonnel WHERE intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con1);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditId = Convert.ToInt32(dbc.dr["intId"].ToString());
                    EditEmpId = (dbc.dr["intEmpCode"].ToString());
                    txtEmpName.Text = dbc.dr["varEmpName"].ToString();
                 
                    txtFatherHusband.Text = dbc.dr["varFatherHusband"].ToString();
                 
                    txtDateofJoin.Text = Convert.ToDateTime(dbc.dr["varDateOfJoin"].ToString()).ToString("dd-MM-yyyy");
                    txtDOB.Text = Convert.ToDateTime(dbc.dr["varDOB"].ToString()).ToString("dd-MM-yyyy");

                    if (dbc.dr["varGender"].ToString() == "Male")
                    {
                        rgbMale.Checked = true;
                    }
                    else if (dbc.dr["varGender"].ToString() == "Female")
                    {
                        rgbFemale.Checked = true;
                    }

                    if (dbc.dr["varMaritalStatus"].ToString() == "Married")
                    {
                        rgbMarried.Checked = true;
                    }
                    else if (dbc.dr["varMaritalStatus"].ToString() == "Unmarried")
                    {
                        rgbUnmarried.Checked = true;
                    }
                    ddlCountry.SelectedIndex = Convert.ToInt32(dbc.dr["intCountry"].ToString());
                    ddlState.DataSource = dbc.GetstateMasterDataFromCountryId(Convert.ToInt32(dbc.dr["intCountry"].ToString()));

                    ddlState.DataTextField = "StateName";
                    ddlState.DataValueField = "StateId"; ddlState.DataBind();
                    ddlState.SelectedValue = dbc.dr["intState"].ToString();
                    ddlCity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(dbc.dr["intState"].ToString()));

                    ddlCity.DataTextField = "CityName";
                    ddlCity.DataValueField = "CityId"; ddlCity.DataBind();

                    ddlCity.SelectedValue = dbc.dr["intCity"].ToString();

                    ddlEmpType.SelectedValue = dbc.dr["intEmpType"].ToString();

                    ddlDepartment.SelectedValue = dbc.dr["intDeptId"].ToString();

                    ddlRole.Items.Clear();
                    ddlRole.Items.Add(":: Select Role ::");
                    ddlRole.Items[0].Value = "";
                   
                    ddlRole.DataSource = dbc.GetRoleListByDeptId(Convert.ToInt32(dbc.dr["intDeptId"].ToString()));
                    ddlRole.DataTextField = "RoleName";
                    ddlRole.DataValueField = "RoleId";
                    ddlRole.DataBind();

                    ddlRole.SelectedValue = dbc.dr["intRole"].ToString();

                    txtPrimaryContact.Text = dbc.dr["varMbPrimary"].ToString();
                    txtOtherContact.Text = dbc.dr["varMbOther"].ToString();
                    txtOtherEmail.Text = dbc.dr["varEmailOther"].ToString();
                    txtPANNo.Text = dbc.dr["varPANNo"].ToString();
                    txtPFNo.Text = dbc.dr["varPFNo"].ToString();
                    txtESINo.Text = dbc.dr["varESINo"].ToString();

                    txtPinZip.Text = dbc.dr["varPin"].ToString();
                    txtAddress.Text = dbc.dr["varAddress"].ToString();
                    txtPermanentAddress.Text = dbc.dr["varPermanentAddress"].ToString();
                    txtUsername.Text = dbc.dr["varPrimaryEmail"].ToString();

                    txtPassword.Visible = false;

                  
                    ImgProfile.ImageUrl = "~/SK/Media/ProfilePhoto/" + dbc.dr["varImage"].ToString();
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
            else if (e.CommandName == "Delets")
            {
                dbc.con.Close();
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("UPDATE  tblskpersonnel SET intIsActive =0  WHERE intId = " + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con);
                int i = cmd1.ExecuteNonQuery();
                dbc.con.Close();

                if (i == 1)
                {
                    MessageDisplay(Resources.Messages.Deleted, "alert alert-success");

                }
                else
                {
                    MessageDisplay(Resources.Messages.NotDeleted, "alert alert-danger");
                }
                getListViewMasterData();
            }
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }

    private string PopulateBody(string Name, string EmailId, string personalid, string pass)
    {
        try
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/LoginDetails.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{Name}", Name);
            body = body.Replace("{EmailId}", EmailId);
            body = body.Replace("{id}", personalid);
            body = body.Replace("{pass}", pass);
            return body;
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            return "";

        }
    }
    protected void sendmail(string name, string pass, string personalid, string email)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta.com <support@societykatta.com>"), new MailAddress(email)))
            {

                mm.Subject = " Your SocietyKatta Login Details";

                mm.Body = PopulateBody(name, email, personalid, pass);

                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                //for server

                smtp.Host = "relay-hosting.secureserver.net";
                smtp.EnableSsl = false;

                //for local 

                //smtp.Host = "smtp.rediffmailpro.com";
                //smtp.EnableSsl = true;


                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                NetworkCredential NetworkCred = new NetworkCredential("support@societykatta.com", "support@2016");
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = NetworkCred;
                //for server
                smtp.Port = 25;
                //for local
                //smtp.Port = 587;
                smtp.Send(mm);

            }
        }
        catch (Exception rx)
        {
            string exp = rx.Message;
            //ScriptManager.RegisterStartupScript(
            //             this,
            //             this.GetType(),
            //             "MessageBox",
            //              "alert('Email Not Sent....');", true);

        }
    }
}