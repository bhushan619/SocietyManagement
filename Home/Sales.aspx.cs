using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using System.IO;

public partial class Home_Sales : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        sendmail(txtName.Text.Replace("'", "\\'"),txtmobile.Text.Replace("'", "\\'"), txtemail.Text.Replace("'", "\\'"), txtservice.Text.Replace("'", "\\'"),txtcomment.Text);
    }
    private string PopulateBody(string name, string mobile,string email, string societynm, string comm)
    {
        try
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/sales.html")))
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
    protected void sendmail(string name, string mb, string email, string societynm,string comm)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("Sales Enquiry <sales@societykatta.com>"), new MailAddress("sales@societykatta.com")))
            {
                mm.Subject = " Sales Enquiry Details for Societykatta.com";

                mm.Body = PopulateBody(name,mb, email, societynm, comm);

                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                //for server

                smtp.Host = "relay-hosting.secureserver.net";
                smtp.EnableSsl = false;

                //for local 

                //smtp.Host = "smtp.rediffmailpro.com";
                //smtp.EnableSsl = true;

                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                NetworkCredential NetworkCred = new NetworkCredential("sales@societykatta.com", "sales@2016");
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
    public void clear()
    {
        txtemail.Text = "";
        txtcomment.Text = "";
        txtmobile.Text = "";
        txtName.Text = "";
        txtservice.Text = "";
    }
}