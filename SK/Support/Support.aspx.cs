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

public partial class SK_Support_Support : System.Web.UI.Page
{
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {


            getSupportData();
        }
    }
    public void getSupportData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con1.Close();
            dbc.con1.Open();
            string queryEmp = "SELECT intId, varPersonneId, intPersonelRole,DATE_FORMAT( varDate,'%d-%m-%Y') as varDate, varName, varUsername, varMobile, varEmail, varSubject, varDescription, varStatus, varRemark, intIsActive, ex1, ex2, ex3, ex4, ex5 FROM tblsksupport";

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(queryEmp + "    order by tblsksupport.intId desc", dbc.con1);
            MySql.Data.MySqlClient.MySqlDataAdapter adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adpp.Fill(dt);



            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con1.Close();


        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con1.Close();
            dbc.con.Close();
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

        this.getSupportData();
    }

    public void clear()
    {
       
        txtsemail.Text = "";
        txtsmobile.Text = "";
        txtDescription.Text = "";
        txtName.Text = "";
        txtsubject.Text = "";
        txtuser.Text = "";
      
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
            int insert_ok = dbc.insert_tblsksupport("",0,txtName.Text.Replace("'", "\\'"),txtuser.Text.Replace("'", "\\'"),txtsmobile.Text.Replace("'", "\\'"),txtsemail.Text.Replace("'", "\\'"), txtsubject.Text.Replace("'", "\\'"),txtDescription.Text.Replace("'", "\\'"),"Pending","",1);
            if (insert_ok == 1)
            {
                sendmail(txtName.Text.Replace("'", "\\'"), txtName.Text.Replace("'", "\\'"), txtuser.Text.Replace("'", "\\'"), txtsubject.Text);
                MessageDisplay(Resources.Messages.Added, "alert alert-success");


                clear();
            }
            else
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");

            getSupportData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    private string PopulateBody(string Name, string EmailId, string userid, string sub)
    {
        try
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/Support.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{Name}", Name);
            body = body.Replace("{EmailId}", EmailId);
            body = body.Replace("{userid}", userid);
            body = body.Replace("{sub}", sub);
            return body;
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            return "";

        }
    }
    protected void sendmail(string name, string sub, string userid, string email)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <support@societykatta.com>"), new MailAddress(email)))
            {
                mm.Subject = " Your SocietyKatta Support Details";

                mm.Body = PopulateBody(name, email, userid, sub);

                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient(); //for server

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
        catch (Exception ex)
        {
            string exp = ex.Message;
            //ScriptManager.RegisterStartupScript(
            //             this,
            //             this.GetType(),
            //             "MessageBox",
            //              "alert('Email Not Sent....');", true);

        }
    }

}