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
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;
using System.Net.Mail;
using System.Net;

public partial class Home_Enquiry : BaseClass
{
    DatabaseConnection dbcd = new DatabaseConnection();
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (fileuploadadhar.HasFile == false)
            {
                MessageDisplay(Resources.Messages.FileUpload, "alert alert-danger");
            }
            else if (fileuploadPAN.HasFile == false)
            {
                MessageDisplay(Resources.Messages.FileUpload, "alert alert-danger");
            }
            else
            {
                string filenameadhar = Path.GetFileName(fileuploadadhar.PostedFile.FileName);
                string filenamepan = Path.GetFileName(fileuploadPAN.PostedFile.FileName);

                int insert_ok = dbc.insert_tblenquiry(txtName.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtemail.Text.Replace("'", "\\'"), txtservice.Text.Replace("'", "\\'"), txtcomment.Text.Replace("'", "\\'"), filenameadhar, filenamepan);
                if (insert_ok == 1)
                {
                    sendmail(txtName.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtemail.Text.Replace("'", "\\'"), txtservice.Text.Replace("'", "\\'"), txtcomment.Text.Replace("'", "\\'"), filenameadhar, filenamepan);
                    fileuploadPAN.SaveAs(Server.MapPath("~/Services/Enquirydoc/" + filenamepan));
                    fileuploadadhar.SaveAs(Server.MapPath("~/Services/Enquirydoc/" + filenameadhar));
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
                }
                clear();
            }

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            MessageDisplay(ex.Message, "alert alert-danger");
            dbc.con.Close();
        }
    }
    private string PopulateBody(string Name, string mobile, string email, string service, string comment, string filenameadhar, string filenamepan)
    {
        try
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/enquiry.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{Name}", Name);
            body = body.Replace("{mobile}", mobile);
            body = body.Replace("{email}", email);
            body = body.Replace("{service}", service);

            body = body.Replace("{comment}", comment);
            body = body.Replace("{filenameadhar}", "http://www.societykatta.com/Services/Enquirydoc/"+filenameadhar);
            body = body.Replace("{filenamepan}", "http://www.societykatta.com/Services/Enquirydoc/"+filenamepan);
            return body;
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            MessageDisplay(ex.Message, "alert alert-danger");
            return "";

        }
    }
    protected void sendmail(string Name, string mobile, string email, string service, string comment, string filenameadhar, string filenamepan)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("Business Enquiry <business@societykatta.com>"), new MailAddress("business@societykatta.com")))
            {
                mm.Subject = "Business Enquiry Details for SocietyKatta.com";

                mm.Body = PopulateBody(Name, mobile, email, service, comment, filenameadhar, filenamepan);

                mm.IsBodyHtml = true;


                SmtpClient smtp = new SmtpClient();
                //smtp.Host = "smtp.rediffmailpro.com";
                smtp.Host = "relay-hosting.secureserver.net";
                smtp.EnableSsl = false;

                //SmtpClient smtp = new SmtpClient();
                //smtp.Host = "smtp.gmail.com";
                //smtp.EnableSsl = true;

                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                NetworkCredential NetworkCred = new NetworkCredential("business@societykatta.com", "business@16");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 25;

                //smtp.UseDefaultCredentials = true;
                //smtp.Credentials = NetworkCred;
                //smtp.Port = 587;

                smtp.Send(mm);
                MessageDisplay(Resources.Messages.EnquirySuccess, "alert alert-success");
            }
        }
        catch (Exception rx)
        {
            string exp = rx.Message;
            MessageDisplay(rx.Message, "alert alert-danger");

        }
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
    public void clear()
    {
        txtcomment.Text = "";
        txtemail.Text = "";
        txtmobile.Text = "";
        txtName.Text = "";
        txtservice.Text = "";
    }
  
}