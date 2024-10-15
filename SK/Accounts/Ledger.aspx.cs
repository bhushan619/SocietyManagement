using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Society_Admin_Accounts_Ledger : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSourceEntries.SelectCommand = "SELECT tblaccountbook.intId,DATE_FORMAT(tblaccountbook.varDate,'%d-%m-%Y') as varDate, tblaccountbook.varAccountNo, tblaccountbook.varVoucher, tblaccountbook.varReason, tblaccountbook.varPreviousBalance, tblaccountbook.varEntryType, tblaccountbook.varAmount, tblaccountbook.varBalance, tblaccountbook.varEntryBy, tblaccountdetails.varAccountName FROM tblaccountbook INNER JOIN tblaccountdetails ON tblaccountbook.varAccountNo = tblaccountdetails.varAccountNo  ORDER BY tblaccountbook.varDate DESC, tblaccountbook.intId DESC";
    }
    protected void lstEntries_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            SqlDataSourceEntries.SelectCommand = "SELECT tblaccountbook.intId, DATE_FORMAT(tblaccountbook.varDate,'%d-%m-%Y') as varDate, tblaccountbook.varAccountNo, tblaccountbook.varVoucher, tblaccountbook.varReason, tblaccountbook.varPreviousBalance, tblaccountbook.varEntryType, tblaccountbook.varAmount, tblaccountbook.varBalance, tblaccountbook.varEntryBy, tblaccountdetails.varAccountName FROM tblaccountbook INNER JOIN tblaccountdetails ON tblaccountbook.varAccountNo = tblaccountdetails.varAccountNo ORDER BY tblaccountbook.varDate DESC, tblaccountbook.intId DESC";

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}