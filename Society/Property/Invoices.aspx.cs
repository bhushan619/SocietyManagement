using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.IO;
using MySql.Data.MySqlClient;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;

public partial class Society_Property_Invoices : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["CookieSocietyId"] == null)
        {
            Response.Redirect("~/Home/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            string query = "SELECT DISTINCT   CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name, tblinvoice.varInvoiceId AS InvoiceNo, ";
            query += "     DATE_FORMAT(tblinvoice.varDateTime,'%d-%m-%Y')  AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  ";
            query += "      tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`,tblinvoiceforpersonnels.varPersonnelId ";
            query += " FROM            tblinvoice INNER JOIN ";
            query += "             tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN ";
            query += "            tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN ";
            query += "          tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN ";
            query += "          tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblinvoiceforpersonnels.varPersonnelId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "' order by tblinvoice.intid desc ";



            SqlDataSource1.SelectCommand = query;
        }
    }

    protected void lstInvoices_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            string[] cmdArgs = e.CommandArgument.ToString().Split(':');
            Cache["InvoiceId"] = cmdArgs[0].ToString();
            Cache["PersonnelId"] = cmdArgs[1].ToString();
            if (e.CommandName == "view")
            {
                Response.Redirect("~/Society/Property/ViewInvoices.aspx", false);
            }
            else
            {
                dbc.con.Close();
                dbc.con.Open();
                MySqlCommand da = new MySqlCommand("SELECT tblproperty.varName AS name, CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) AS address, tblinvoice.varDateTime AS dat, tblinvoiceforpersonnels.varOutstanding, tblinvoice.varTotal, tblinvoice.varInvoiceId, tblinvoiceforpersonnels.varPersonnelId,tblproperty.varMobile, tblproperty.varEmail, tblinvoiceforpersonnels.varPaymentStatus FROM tblproperty INNER JOIN tblinvoiceforpersonnels ON tblproperty.varPropertyId = tblinvoiceforpersonnels.varPersonnelId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId INNER JOIN tblinvoice ON tblinvoiceforpersonnels.varInvoiceId = tblinvoice.varInvoiceId WHERE  (tblproperty.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') AND  (tblinvoice.varInvoiceId = '" + Cache["InvoiceId"].ToString() + "') AND(tblinvoiceforpersonnels.varPersonnelId = '" + Cache["PersonnelId"].ToString() + "')", dbc.con);
                dbc.dr1 = da.ExecuteReader();
                if (dbc.dr1.Read())
                {
                    Response.Redirect("~/Society/Payprocess/Default.aspx?amount=" + dbc.dr1["varTotal"].ToString() + "&firstname=" + dbc.dr1["name"].ToString() + "&email=" + dbc.dr1["varEmail"].ToString() + "&phone=" + dbc.dr1["varMobile"].ToString() + "&productinfo=SKSPPAYMENT&udf1=" + cmdArgs[0].ToString() + "&udf2=" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "&udf3=" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "&surl=http://societykatta.com/Society/Property/ViewInvoices.aspx&furl=http://societykatta.com/Society/Property/Invoices.aspx", false);
                    dbc.con.Close(); dbc.dr1.Dispose();
                }
                dbc.con.Close();
                dbc.dr1.Dispose();
            }
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            dbc.dr1.Dispose();
            string exp = ex.Message;
        }
        
    }
}