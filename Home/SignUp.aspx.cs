using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using System.IO;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;

public partial class Home_SignUp : BaseClass
{
    DatabaseConnectionServices dbc = new DatabaseConnectionServices();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string verifyCode = dbc.CreateRandomPassword(5);
            if (dbc.check_AlreadyCustomer(txtEmail.Text))
            {
                MessageDisplay(Resources.ErrorMessages.AlreadyExist, "btn-danger text-center");
            }
            else
            {
                if (txtConfirmPassword.Text.Equals(txtPassword.Text))
                {

                    dbc.con.Open();
                    dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblcustomer( varName, varMobile, varEmail, varEmailVerify ,varPassword, varStatus, imgImage ) VALUES ( '" + txtName.Text.Replace("'", "\\'") +"', '" + txtMobile.Text.Replace("'", "\\'") +"','" + txtEmail.Text.Replace("'", "\\'") +"','" + verifyCode + "', '" + txtPassword.Text.Replace("'", "\\'") +"' , '0', 'Noprofile.png')", dbc.con);
                    dbc.cmd.ExecuteNonQuery();
                    dbc.con.Close();

                    sendmail(verifyCode);

                    MessageDisplay(Resources.ErrorMessages.signup, "btn-success text-center");

                    clear();
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "btn-danger text-center");
                }
            }
        }
        catch (Exception ex)
        {
        }
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
    public void clear()
    {
        txtName.Text = "";
        txtEmail.Text = "";
        txtMobile.Text = "";
        txtPassword.Text = "";
        txtConfirmPassword.Text = "";
    }

    private string PopulateBody(string name, string EmailId, string VerifyLink)
    {
        string body = string.Empty;
        using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/SignUp.html")))
        {
            body = reader.ReadToEnd();
        }
        body = body.Replace("{name}", name);
        body = body.Replace("{EmailId}", EmailId);
        body = body.Replace("{VerifyLink}", VerifyLink);
        return body;
    }
    protected void sendmail(string verify)
    {
        try
        {
            string mess = string.Empty;
            string email = string.Empty;
          
                mess = "http://societykatta.com/Home/Login.aspx?vid=";
                email = txtEmail.Text;

                using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <support@societykatta.com>"), new MailAddress(email)))
                {
                    mm.Subject = "SocietyKatta : Verification Email";

                    mm.Body = PopulateBody(txtName.Text.Replace("'", "\\'"), email, mess + verify);

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
            Response.Write("<script>alert('Please Try Again');window.location='SignUp.aspx';</script>");
        }
    }
}