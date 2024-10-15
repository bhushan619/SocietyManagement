using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_Contact : BaseClass
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
      
        try
        {

            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            System.Net.Mail.SmtpClient SmtpServer = new System.Net.Mail.SmtpClient("relay-hosting.secureserver.net");

            mail.From = new System.Net.Mail.MailAddress("contact@anuvaasoft.com");
            mail.To.Add("contact@anuvaasoft.com");

            mail.Subject = "Enquiry / Contact";

            // done HTML formatting in the next line to display my logo 

            mail.Body = "Enquiry at Anuvaa Softech PVT LTD \n \n Name :" + name.Text + "\n E-Mail : " + email.Text + "\n Subject : " + subject.Text + "\n Message : " + message.Text;

            SmtpServer.Port = 25;
            SmtpServer.UseDefaultCredentials = false;
            SmtpServer.Credentials = new System.Net.NetworkCredential("contact@anuvaasoft.com", "Jalgaon@anuvaa");
            SmtpServer.EnableSsl = false;

            SmtpServer.Send(mail);
            ClientScript.RegisterStartupScript(this.GetType(),
                    "popup",
                    "alert('Message sent successfully.');window.location='Contact.aspx';",
                    true);
            // Response.Redirect(""); Response.Write("come 1");
        }
        catch (Exception ass)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                     "popup",
                     "alert('" + ass.Message + "');window.location='Contact.aspx';",
                     true);
        }
    }
}