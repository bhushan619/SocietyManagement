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
using System.Net.Mail;
using System.Net;
using System.IO; 

public partial class Home_RetrievePassword : BaseClass
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }
    protected void btnRetrieve_Click(object sender, EventArgs e)
    {
        if (txtUsername.Text == "")
        {
            MessageDisplay(Resources.GlobalResource.EmptyField, "btn-danger text-center");
        }
        else if (txtEmail.Text == "")
        {
            MessageDisplay(Resources.GlobalResource.EmptyField, "btn-danger text-center");
        }

        else if (rex.IsValidEmail(txtEmail.Text))
        {
            Retrivepassword();
        }
        else
        {
            Retrivepassword();
        }

    }
    public void Retrivepassword()
    {
        try
        {
            string email = txtEmail.Text;
            string usename = txtUsername.Text;
            MySql.Data.MySqlClient.MySqlCommand cmde = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intSocietyId, intEmpCode, intDeptId, intRole, intEmpType, varEmpName, varEmpPoliceVerify, varMaritalStatus, varFatherHusband, varSpouseName, varDateOfJoin, varDOB, varGender, varMbPrimary, varMbOther, varEmailOther, varPANNo, varPFNo, varESINo, intCountry, intState, intCity, varPin, varAddress, varPermanentAddress, varPrimaryEmail, varUsername, varPassword, varMobile, varFBLink, varGoogleLink, varTwitterLink, varImage, intIsActive, intCreatedBy, varCreatedDate, varProviderName, varContactPerson, varContactPersonMbNo, varContactPersonAddress FROM tblsocietypersonnel WHERE varUsername='" + usename + "' and intIsActive=1", dbc.con);
            dbc.con.Open();
            dbc.dr = cmde.ExecuteReader();
            if (dbc.dr.Read())
            {
                if (dbc.dr["varPrimaryEmail"].ToString() == email)
                {
                    string name = dbc.dr["varEmpName"].ToString();
                    string pass = dbc.dr["varPassword"].ToString();
                    string id = dbc.dr["intEmpCode"].ToString();

                    sendmail(name, pass, id, dbc.dr["varPrimaryEmail"].ToString());
                    ScriptManager.RegisterStartupScript(
                  this,
                  this.GetType(),
                  "MessageBox",
                  "alert('Please Check Email..');window.location='Login.aspx';", true);

                    dbc.con.Close();
                    dbc.dr.Close();
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "btn-danger text-center");
                }

            }
            else
            {
                dbc.con.Close();
                MySql.Data.MySqlClient.MySqlCommand cmdej = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varPropertyId, varSocietyId, intRoleId, intWingId, intPremisesUnitId, intPremisesTypeId, varPropertyCode, varName, varGender, varExtensionNo, varAlternateAddress, varPhoneNo, varMobile, varAlternateMobile, varEmail, varAlternateEmail, varUsername, varPassword, varCreatedDate, varCreatedBy, intIsActive, varImage, varFBLink, varGoogleLink, varTwitterLink FROM tblproperty WHERE  varUsername = '" + usename + "' and intIsActive=1", dbc.con);
                dbc.con.Open();
                dbc.dr = cmdej.ExecuteReader();
                if (dbc.dr.Read())
                {
                    if (dbc.dr["varEmail"].ToString() == email)
                    {
                        string name = dbc.dr["varName"].ToString();
                        string pass = dbc.dr["varPassword"].ToString();
                        string id = dbc.dr["varPropertyId"].ToString();

                        sendmail(name, pass, id, dbc.dr["varEmail"].ToString());
                        ScriptManager.RegisterStartupScript(
                      this,
                      this.GetType(),
                      "MessageBox",
                      "alert('Please Check Email..');window.location='Login.aspx';", true);
                    }
                    else
                    {
                        MessageDisplay(Resources.ErrorMessages.IncorrectValues, "btn-danger text-center");
                    }
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "btn-danger text-center");
                }
            }

        }
        catch (Exception ex)
        {
            dbc.con.Close();
            Response.Write("<script>alert('" + ex.Message + "')</script>");
        }
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
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
                mm.Subject = " Your SocietyKatta  Password Details";

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
            MessageDisplay(rx.Message, "btn-danger text-center");

        }
    }
}