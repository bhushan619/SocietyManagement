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

public partial class Society_Common_SKHelp : System.Web.UI.Page
{

    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {


        }
    }

    public void clear()
    {

        txtDescription.Text = "";
        txtEmail.Text = "";
        txtmobile.Text = "";
        txtname.Text = "";
        txtSubject.Text = "";
      
    }

    void MessageDisplay(string message, string cssClass)
    {
        try
        {
            lblMessage.Text = message;
            divMessage.Attributes.Add("class", cssClass);
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int insert_ok = dbc.insert_tblskhelp(txtname.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), txtSubject.Text.Replace("'", "\\'"), txtDescription.Text);
            if (insert_ok == 1)
            {
                sendmail(txtname.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), txtSubject.Text.Replace("'", "\\'"), txtDescription.Text);
                MessageDisplay(Resources.Messages.Added, "alert alert-success");


                clear();
            }
            else
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");

          
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    private string PopulateBody(string name, string mobile, string email, string societynm, string comm)
    {
        try
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/help.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{name}", name);
            body = body.Replace("{mobile}", mobile);
            body = body.Replace("{email}", email);
            body = body.Replace("{societynm}", societynm);
            body = body.Replace("{comm}", comm);
            return body;
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            return "";

        }
    }
    protected void sendmail(string name, string mb, string email, string societynm, string comm)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("Ask Help <contact@societykatta.com>"), new MailAddress("contact@societykatta.com")))
            {
                mm.Subject = "Ask Help Details for Societykatta.com";
                mm.Body = " \n \n Name :" +txtname.Text + "\n E-Mail : " +txtEmail.Text + "\n Mobile : " + txtmobile.Text + "\n Subject : " + txtSubject.Text + "\n Description : " + txtDescription.Text;

                mm.Body = PopulateBody(name, mb, email, societynm, comm);

                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                //for server

                smtp.Host = "relay-hosting.secureserver.net";
                smtp.EnableSsl = false;

                //for local 

                //smtp.Host = "smtp.rediffmailpro.com";
                //smtp.EnableSsl = true;

                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                NetworkCredential NetworkCred = new NetworkCredential("contact@societykatta.com", "contact@2016");
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = NetworkCred;
                //for server
                smtp.Port = 25;
                //for local
                //smtp.Port = 587;

                smtp.Send(mm);

                ScriptManager.RegisterStartupScript(
                             this,
                             this.GetType(),
                             "MessageBox",
                              "alert('Enquiry Send Successfully....!!!');", true);
                clear();

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