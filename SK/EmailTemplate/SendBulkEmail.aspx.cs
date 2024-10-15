using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.Configuration;
using System.Net.Mail;
using System.Net;
using System.IO;
using System.Text;
using System.Data.Common;
using System.Data.OleDb;

//using Ionic.Zip;
//using ClosedXML.Excel;

public partial class SK_EmailTemplate_SendBulkEmail : System.Web.UI.Page
{
    DatabaseConnectionServices dbc = new DatabaseConnectionServices();
    DataTable dt = new DataTable();
    DataTable dt1 = new DataTable();
    OleDbConnection connection;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lnkinkbutton_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            string FolderPath = ConfigurationManager.AppSettings["FolderPath"];

            string FilePath = Server.MapPath(FolderPath + FileName);
            FileUpload1.SaveAs(FilePath);
            Import_To_Grid(FilePath, Extension, "Yes");
        }
    }
    private void Import_To_Grid(string FilePath, string Extension, string isHDR)
    {
        try
        {
            string conStr = "";
            switch (Extension)
            {
                case ".xls": //Excel 97-03
                    conStr = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07
                    conStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties=\"Excel 12.0;HDR=YES;IMEX=1;\"";
                    //   conStr = ConfigurationManager.ConnectionStrings["Excel07ConString"].ConnectionString;
                    break;
            }
            conStr = String.Format(conStr, FilePath, isHDR);
            OleDbConnection connExcel = new OleDbConnection(conStr);
            OleDbCommand cmdExcel = new OleDbCommand();
            OleDbDataAdapter oda = new OleDbDataAdapter();
            DataTable dt = new DataTable();
            cmdExcel.Connection = connExcel;

            //Get the name of First Sheet
            connExcel.Close();
            connExcel.Open();
            DataTable dtExcelSchema;
            dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
            connExcel.Close();

            //Read Data from First Sheet
            connExcel.Open();
            cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
            oda.SelectCommand = cmdExcel;
            oda.Fill(dt);
            connExcel.Close();

            //Bind Data to GridView
            GridView1.Caption = Path.GetFileName(FilePath);
            GridView1.DataSource = dt;
            GridView1.DataBind();

            //Add to database
            foreach (DataRow row in dt.Rows)
            {

                if (row["EmailId"].ToString() == "")
                {

                }
                else
                {
                    sendmail(row["EmailId"].ToString());
                }
            }

           // Response.Write("<script>alert('Email Send Successfully')</script>");
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
    public string PopulateBody( string EmailId)
    {
        string body = string.Empty;
        using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/Vendoremail.html")))
        {
            body = reader.ReadToEnd();
        }
      
        body = body.Replace("{EmailId}", EmailId);
       
        return body;
    }
    public void sendmail( string email)
    {
        try
        {
            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <societykatta@gmail.com>"), new MailAddress(email)))
            {
                mm.Subject = " Promote with societykatta.com";

                mm.Body = PopulateBody(email);

                //mm.IsBodyHtml = true;
                //SmtpClient smtp = new SmtpClient();
                //smtp.Host = "relay-hosting.secureserver.net";// "smtp.gmail.com"; // 

                //smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                //NetworkCredential NetworkCred = new NetworkCredential("support@societykatta.com", "society@jalgaon16");
                //smtp.UseDefaultCredentials = false;
                //smtp.EnableSsl = false;
                //smtp.Credentials = NetworkCred;
                //smtp.Port = 25;
                //smtp.Send(mm);

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
                Response.Write("ok");
            }
          
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    public void btnmail_Click(object sender, EventArgs e)
    {
        try
        {
            sendmail(txtemail.Text);
            txtemail.Text = "";
          
        }
        catch(Exception ex)
        {
            string s = ex.Message;
            Response.Write("<script>alert('Please try again')</script>");
        }
    }
}