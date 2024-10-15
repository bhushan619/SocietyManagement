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

public partial class SK_Employee_MyProfile : System.Web.UI.Page
{

    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    static string oldUsername = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getCountryData();
            getPersonalDetails();
        }
        if (this.IsPostBack)
        {
            TabName.Value = Request.Form[TabName.UniqueID];
        }
    }
  
    public void getPersonalDetails()
    {
        try
        {
          
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intEmpCode, intDeptId, intRole, intEmpType, varEmpName, varMaritalStatus, varFatherHusband, DATE_FORMAT( varDateOfJoin,'%d-%m-%Y') AS varDateOfJoin,  DATE_FORMAT( varDOB,'%d-%m-%Y') AS  varDOB,  varGender, varMbPrimary, varMbOther, varEmailOther, varPANNo, varPFNo, varESINo, intCountry, intState, intCity, varPin, varAddress, varPermanentAddress, varPrimaryEmail, varUsername, varPassword, varMobile, varImage, intIsActive, intCreatedBy, varCreatedDate, ex1, ex2, ex3 FROM tblskpersonnel WHERE intEmpCode ='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'", dbc.con1);
            // cmd.ExecuteNonQuery();

           
            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblpFullName.Text = dbc.dr["varEmpName"].ToString();
                lblPName.Text = dbc.dr["varEmpName"].ToString();
            
                lblpGender.Text = dbc.dr["varGender"].ToString();
                lblpAddress.Text = dbc.dr["varAddress"].ToString();
               
                lblpPrimaryMobile.Text = dbc.dr["varMbPrimary"].ToString();
                lblpOtherMobile.Text = dbc.dr["varMbOther"].ToString();
                lblpPrimaryEmail.Text = dbc.dr["varPrimaryEmail"].ToString();
                lblpOtheremail.Text = dbc.dr["varEmailOther"].ToString();

                lblpUsername.Text = dbc.dr["varUsername"].ToString();
                oldUsername = dbc.dr["varUsername"].ToString();              
              
                txtUsername.Text = dbc.dr["varUsername"].ToString();
                txtowner.Text = dbc.dr["varEmpName"].ToString();
               
                txtmobile.Text = dbc.dr["varMbPrimary"].ToString();
                txtEmail.Text = dbc.dr["varPrimaryEmail"].ToString();
                txtAltMobileNos.Text = dbc.dr["varMbOther"].ToString();
                txtAltEmailIds.Text = dbc.dr["varEmailOther"].ToString();
                txtaddress.Text = dbc.dr["varAddress"].ToString();

                txtowner.Text = dbc.dr["varEmpName"].ToString();
             
                txtFatherHusband.Text = dbc.dr["varFatherHusband"].ToString();
              
                txtDOB.Text = dbc.dr["varDOB"].ToString();
                ddlCountry.SelectedIndex = Convert.ToInt32(dbc.dr["intCountry"].ToString());
                ddlState.DataSource = dbc.GetstateMasterDataFromCountryId(Convert.ToInt32(dbc.dr["intCountry"].ToString()));

                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "StateId"; ddlState.DataBind();
                ddlState.SelectedValue = dbc.dr["intState"].ToString();
                ddlCity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(dbc.dr["intState"].ToString()));

                ddlCity.DataTextField = "CityName";
                ddlCity.DataValueField = "CityId"; ddlCity.DataBind();

                ddlCity.SelectedValue = dbc.dr["intCity"].ToString();
                txtPANNo.Text = dbc.dr["varPANNo"].ToString();
                txtPFNo.Text = dbc.dr["varPFNo"].ToString();
                txtESINo.Text = dbc.dr["varESINo"].ToString();

                txtPinZip.Text = dbc.dr["varPin"].ToString();

                txtPermanentAddress.Text = dbc.dr["varPermanentAddress"].ToString();


                if (dbc.dr["varMaritalStatus"].ToString() == "Married")
                {
                    rgbMarried.Checked = true;
                }
                else if (dbc.dr["varMaritalStatus"].ToString() == "Unmarried")
                {
                    rgbUnmarried.Checked = true;
                }
                if (dbc.dr["varGender"].ToString() == "Male")
                {
                    rgbMale.Checked = true;
                }
                else if (dbc.dr["varGender"].ToString() == "Female")
                {
                    rgbFemale.Checked = true;
                }

                ImgProfile.ImageUrl = "~/SK/Media/ProfilePhoto/" + dbc.dr["varImage"].ToString();
                imguploadpic.ImageUrl = "~/SK/Media/ProfilePhoto/" + dbc.dr["varImage"].ToString();
            }
            dbc.con1.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con1.Close();
            MessageDisplay(ex.Message, "alert alert-success");

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (oldUsername.Equals(txtUsername.Text))
            {
                int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
                string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
                string fileName = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;

                if (contentLength != 0)
                {
                    string myStr = imguploadpic.ImageUrl;
                    string[] ssize = myStr.Split('/');
                    fupProPic.PostedFile.SaveAs(Server.MapPath("~/SK/Media/ProfilePhoto/") + fileName);

                    int Update_ok = dbc.update_tblskpersonnelByHerself(rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), txtowner.Text.Replace("'", "\\'"), rgbMarried.Checked ? "Married" : "Unmarried", txtFatherHusband.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), rgbMale.Checked ? "Male" : "Female", txtmobile.Text.Replace("'", "\\'"), txtAltMobileNos.Text.Replace("'", "\\'"), txtAltEmailIds.Text.Replace("'", "\\'"), txtPANNo.Text.Replace("'", "\\'"), txtPFNo.Text.Replace("'", "\\'"), txtESINo.Text.Replace("'", "\\'"), Convert.ToInt32(ddlCountry.SelectedValue), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue), txtPinZip.Text.Replace("'", "\\'"), txtaddress.Text.Replace("'", "\\'"), txtPermanentAddress.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), fileName);

                    if (Update_ok == 1)
                    {
                        MessageDisplay(Resources.Messages.Updated, "alert alert-success");

                    }
                    else
                    {
                        MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                    }
                }
                else
                {
                    string[] imgname = imguploadpic.ImageUrl.Split('/');

                    int Update_ok = dbc.update_tblskpersonnelByHerself(rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), txtowner.Text.Replace("'", "\\'"), rgbMarried.Checked ? "Married" : "Unmarried", txtFatherHusband.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), rgbMale.Checked ? "Male" : "Female", txtmobile.Text.Replace("'", "\\'"), txtAltMobileNos.Text.Replace("'", "\\'"), txtAltEmailIds.Text.Replace("'", "\\'"), txtPANNo.Text.Replace("'", "\\'"), txtPFNo.Text.Replace("'", "\\'"), txtESINo.Text.Replace("'", "\\'"), Convert.ToInt32(ddlCountry.SelectedValue), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue), txtPinZip.Text.Replace("'", "\\'"), txtaddress.Text.Replace("'", "\\'"), txtPermanentAddress.Text.Replace("'", "\\'"),txtEmail.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), imgname[4]);

                    if (Update_ok == 1)
                    {
                        MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                    }
                    else
                    {
                        MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                    }
                }

                getPersonalDetails();
            }
            else if (dbc.check_UsernameExists(txtUsername.Text))
            {
                Response.Write("<script>alert('Username already Exists..!! Please enter another one..');</script>");
                txtUsername.Text = oldUsername;
            }
            else
            {
                int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
                string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
                string fileName = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;

                if (contentLength != 0)
                {
                    string myStr = imguploadpic.ImageUrl;
                    string[] ssize = myStr.Split('/');
                    fupProPic.PostedFile.SaveAs(Server.MapPath("~/SK/Media/ProfilePhoto/") + fileName);
                    int Update_ok = dbc.update_tblskpersonnelByHerself(rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), txtowner.Text.Replace("'", "\\'"), rgbMarried.Checked ? "Married" : "Unmarried", txtFatherHusband.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), rgbMale.Checked ? "Male" : "Female", txtmobile.Text.Replace("'", "\\'"), txtAltMobileNos.Text.Replace("'", "\\'"), txtAltEmailIds.Text.Replace("'", "\\'"), txtPANNo.Text.Replace("'", "\\'"), txtPFNo.Text.Replace("'", "\\'"), txtESINo.Text.Replace("'", "\\'"), Convert.ToInt32(ddlCountry.SelectedValue), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue), txtPinZip.Text.Replace("'", "\\'"), txtaddress.Text.Replace("'", "\\'"), txtPermanentAddress.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), fileName);

                    if (Update_ok == 1)
                    {
                        MessageDisplay(Resources.Messages.Updated, "alert alert-success");

                    }
                    else
                    {
                        MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                    }
                }
                else
                {
                    string[] imgname = imguploadpic.ImageUrl.Split('/');
                    int Update_ok = dbc.update_tblskpersonnelByHerself(rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), txtowner.Text.Replace("'", "\\'"), rgbMarried.Checked ? "Married" : "Unmarried", txtFatherHusband.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), rgbMale.Checked ? "Male" : "Female", txtmobile.Text.Replace("'", "\\'"), txtAltMobileNos.Text.Replace("'", "\\'"), txtAltEmailIds.Text.Replace("'", "\\'"), txtPANNo.Text.Replace("'", "\\'"), txtPFNo.Text.Replace("'", "\\'"), txtESINo.Text.Replace("'", "\\'"), Convert.ToInt32(ddlCountry.SelectedValue), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue), txtPinZip.Text.Replace("'", "\\'"), txtaddress.Text.Replace("'", "\\'"), txtPermanentAddress.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), imgname[4]);

                    if (Update_ok == 1)
                    {
                        MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                    }
                    else
                    {
                        MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                    }
                }

                getPersonalDetails();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            // MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }

    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
    void MessageDisplay1(string message, string cssClass)
    {
        lblMessage1.Text = message;
        divMessage1.Attributes.Add("class", cssClass);
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
    protected void btnpasschange_Click(object sender, EventArgs e)
    {
        try
        {

            getNewpass();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    public void getNewpass()
    {
        try
        {
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intEmpCode, intDeptId, intRole, intEmpType, varEmpName, varMaritalStatus, varFatherHusband, varDateOfJoin, varDOB, varGender, varMbPrimary, varMbOther, varEmailOther, varPANNo, varPFNo, varESINo, intCountry, intState, intCity, varPin, varAddress, varPermanentAddress, varPrimaryEmail, varUsername, varPassword, varMobile, varImage, intIsActive, intCreatedBy, varCreatedDate, ex1, ex2, ex3 FROM tblskpersonnel WHERE intEmpCode ='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'", dbc.con);
            // cmd.ExecuteNonQuery();

            dbc.dr1 = cmd.ExecuteReader();
            if (dbc.dr1.Read())
            {
                if (txtOld.Text == dbc.dr1["varPassword"].ToString())
                {
                    string e_name = dbc.dr1["varEmpName"].ToString();
                    string e_empid = dbc.dr1["intEmpCode"].ToString();
                    string e_email = dbc.dr1["varPrimaryEmail"].ToString();
                    dbc.dr1.Close();
                    dbc.con.Close();
                    if (txtNewCon.Text == txtNew.Text)
                    {
                        dbc.con.Open();
                        cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblskpersonnel SET varPassword='" + txtNewCon.Text.Replace("'", "\\'") +"' where   intEmpCode='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'", dbc.con);
                        cmd.ExecuteNonQuery();
                        dbc.con.Close();

                        sendmail(e_name, txtNewCon.Text.Replace("'", "\\'"), e_empid, e_email);

                        // dbc.insert_tblamnotifications("Message", Session["memberid"].ToString(), lblMemberName.Text.Replace("'", "\\'"), "Member", Session["memberid"].ToString(), "Member", "You recently changed your Password if not please contact support", "", "", "Unread", "");
                        //Response.Write("<script>alert('Your Password Changed');window.location='ChangePassword.aspx';</script>");
                        MessageDisplay1(Resources.ErrorMessages.passChange, "alert alert-success");
                    }
                    else
                    {
                        MessageDisplay1(Resources.ErrorMessages.Incorrect, "alert alert-danger");
                    }
                }
                else
                {
                    MessageDisplay1(Resources.ErrorMessages.Incorrect, "alert alert-danger");
                }
            }
            else
            {
                MessageDisplay1(Resources.ErrorMessages.Incorrect, "alert alert-danger");
            }

            dbc.dr1.Close();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            dbc.dr1.Close();
            dbc.con.Close();
            string exp = ex.Message;

        }
    }
    private string PopulateBody(string Name, string EmailId, string memid, string pass)
    {
        string body = string.Empty;
        using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/ChangePassword.html")))
        {
            body = reader.ReadToEnd();
        }
        body = body.Replace("{Name}", Name);
        body = body.Replace("{EmailId}", EmailId);
        body = body.Replace("{memid}", memid);
        body = body.Replace("{pass}", pass);
        return body;
    }
    protected void sendmail(string name, string pass, string memid, string email)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <support@societykatta.com>"), new MailAddress(email)))
            {
                mm.Subject = " Your SocietyKatta Change Password Details";

                mm.Body = PopulateBody(name, email, memid, pass);

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
            MessageDisplay1(Resources.ErrorMessages.EmailNotSend, "alert alert-danger");

        }
    }
}