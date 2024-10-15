<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Uri previousUri = Request.UrlReferrer; 
        try
        {
            
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            System.Net.Mail.SmtpClient SmtpServer = new System.Net.Mail.SmtpClient("relay-hosting.secureserver.net");
           
            mail.From = new System.Net.Mail.MailAddress("contact@anuvaasoft.com");
            mail.To.Add("contact@anuvaasoft.com");
             
            mail.Subject = "Enquiry / Contact";
          
             // done HTML formatting in the next line to display my logo 

            mail.Body = "Enquiry at Anuvaa Softech PVT LTD \n \n Name :" + Request["nm"].ToString() + "\n E-Mail : " + Request["eml"].ToString() + "\n Message : " + Request["adr"].ToString();
            
            SmtpServer.Port = 25;
            SmtpServer.UseDefaultCredentials = false;
            SmtpServer.Credentials = new System.Net.NetworkCredential("contact@anuvaasoft.com", "Jalgaon@anuvaa");
            SmtpServer.EnableSsl = false;
            
            SmtpServer.Send(mail);
            ClientScript.RegisterStartupScript(this.GetType(),
                    "popup",
                    "alert('Message sent successfully.');window.location='" + previousUri.ToString() + "';",
                    true);  
           // Response.Redirect(""); Response.Write("come 1");
        }
        catch (Exception ass)
        {
            ClientScript.RegisterStartupScript(this.GetType(),
                     "popup",
                     "alert('" + ass.Message + "');window.location='" + previousUri.ToString() + "';",
                     true);      
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
