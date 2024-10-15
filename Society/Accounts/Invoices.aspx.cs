using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Society_Accounts_Invoices : System.Web.UI.Page
{
    RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.Cookies["CookieSocietyId"] == null)
        {
            Response.Redirect("~/Home/Login.aspx", false);
        }
        if (!IsPostBack)
        {
            string query = "SELECT DISTINCT  CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name, tblinvoice.varInvoiceId AS InvoiceNo,  ";
            query += "  DATE_FORMAT(tblinvoice.varDateTime,'%d-%m-%Y') AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding, ";
            query += "   tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`,tblinvoiceforpersonnels.varPersonnelId FROM           tblinvoice INNER JOIN ";
            query += "  tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN ";
            query += "   tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN ";
            query += "   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN";
            query += "  tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId ='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'";
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
            Response.Redirect("~/Society/Accounts/ViewInvoices.aspx", false);
        }


        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}
