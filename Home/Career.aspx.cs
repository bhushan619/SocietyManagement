using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

public partial class Home_Career : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int contentLength = UploadedFile.PostedFile.ContentLength;//You may need it for validation
            string contentType = UploadedFile.PostedFile.ContentType;//You may need it for validation
            string fileName = UploadedFile.PostedFile.FileName;

            string ffileExt = System.IO.Path.GetExtension(UploadedFile.FileName);
            if (contentLength == 0)
            {
                MailMessage mail = new MailMessage();
               // SmtpClient SmtpServer = new SmtpClient("relay-hosting.secureserver.net");
                SmtpClient SmtpServer = new SmtpClient();
                //for server

                //SmtpServer.Host = "relay-hosting.secureserver.net";
                //SmtpServer.EnableSsl = false;

                //for local 

                SmtpServer.Host = "smtp.rediffmailpro.com";
                SmtpServer.EnableSsl = true;

                mail.From = new MailAddress("careers@societykatta.com");
                mail.To.Add("careers@societykatta.com");
                mail.Subject = "Job Application / Enquiry / Contact";

                mail.Body = "Job Application at Societykatta.com \n \n Name : " + txtname.Text + "\n E-Mail : " + txtemail.Text + "Application For The Post : " + txtsub.Text + "\n Few Words About Candidate : " + txtmsg.Text;

                //System.Net.Mail.Attachment attachment;
                //attachment = new System.Net.Mail.Attachment("your attachment file");
                //mail.Attachments.Add(attachment);

                //for server
                //  SmtpServer.Port = 25;
                //for local
                SmtpServer.Port = 587;
                SmtpServer.UseDefaultCredentials = false;
                SmtpServer.Credentials = new System.Net.NetworkCredential("careers@societykatta.com", "carrers@2016");
                SmtpServer.EnableSsl = false;

                SmtpServer.Send(mail);
                ScriptManager.RegisterStartupScript(
                     this,
                     this.GetType(),
                     "MessageBox",
                     "alert('Message sent successfully');", true);
                txtemail.Text = "";
                txtmsg.Text = "";
                txtname.Text = "";
                txtsub.Text = "";

            }
            else
            {
                if ((ffileExt == ".doc") || (ffileExt == ".docx") || (ffileExt == ".pdf") || (ffileExt == ".DOC") || (ffileExt == ".DOCX") || (ffileExt == ".PDF"))
                {
                    fileName = UploadedFile.FileName.ToString();

                    UploadedFile.SaveAs(Server.MapPath("~/Services/Career/") + fileName);
                    MailMessage mail = new MailMessage();
                    SmtpClient SmtpServer = new SmtpClient();
                    //for server

                    //SmtpServer.Host = "relay-hosting.secureserver.net";
                    //SmtpServer.EnableSsl = false;

                    //for local 

                    SmtpServer.Host = "smtp.rediffmailpro.com";
                    SmtpServer.EnableSsl = true;

                    mail.From = new MailAddress("careers@societykatta.com");
                    mail.To.Add("careers@societykatta.com");
                    mail.Subject = "Job Application - Enquiry - Contact";

                    mail.Body = "Job Application at Societykatta.com \n \n Name :" + txtname.Text + "\n E-Mail : " + txtemail.Text + "\n Application For The Post:" + txtsub.Text + "\n Few Words About Him : " + txtmsg.Text;

                    System.Net.Mail.Attachment attachment;
                    attachment = new System.Net.Mail.Attachment(Server.MapPath("~/Services/Career/" + fileName));
                    mail.Attachments.Add(attachment);

                            //for server
                  //  SmtpServer.Port = 25;
                            //for local
                    SmtpServer.Port = 587;
                    SmtpServer.UseDefaultCredentials = false;
                    SmtpServer.Credentials = new System.Net.NetworkCredential("careers@societykatta.com", "careers@2016");
                    SmtpServer.EnableSsl = true;

                    SmtpServer.Send(mail);
                    ScriptManager.RegisterStartupScript(
                         this,
                         this.GetType(),
                         "MessageBox",
                         "alert('Message sent successfully');", true);
                    txtemail.Text = "";
                    txtmsg.Text = "";
                    txtname.Text = "";
                    txtsub.Text = "";

                }
                else
                {
                    ScriptManager.RegisterStartupScript(
                  this,
                  this.GetType(),
                  "MessageBox",
                  "alert('Please select proper file as .doc,.docx or .pdf');", true);

                }
            }

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(
                   this,
                   this.GetType(),
                   "MessageBox",
                   "alert('" + ex.Message + "');", true);
        }
    }
}