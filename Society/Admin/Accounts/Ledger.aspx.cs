using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Society_Admin_Accounts_Ledger : System.Web.UI.Page
{
    RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSourceEntries.SelectCommand = "SELECT tblaccountbook.intId, tblaccountbook.varSocietyId,DATE_FORMAT(tblaccountbook.varDate,'%d-%m-%Y') as varDate, tblaccountbook.varAccountNo, tblaccountbook.varVoucher, tblaccountbook.varReason, tblaccountbook.varPreviousBalance, tblaccountbook.varEntryType, tblaccountbook.varAmount, tblaccountbook.varBalance, tblaccountbook.varEntryBy, tblaccountdetails.varAccountName, CONCAT(tblsocietypersonnel.varEmpName, '-', rolesmasterculturemap.RoleName) AS Name FROM tblaccountbook INNER JOIN tblaccountdetails ON tblaccountbook.varAccountNo = tblaccountdetails.varAccountNo INNER JOIN tblsocietypersonnel ON tblaccountbook.varEntryBy = tblsocietypersonnel.intEmpCode INNER JOIN rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE (tblaccountbook.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') ORDER BY tblaccountbook.varDate DESC, tblaccountbook.intId DESC";
    }
    protected void lstEntries_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            SqlDataSourceEntries.SelectCommand = "SELECT tblaccountbook.intId, tblaccountbook.varSocietyId,DATE_FORMAT(tblaccountbook.varDate,'%d-%m-%Y') as varDate, tblaccountbook.varAccountNo, tblaccountbook.varVoucher, tblaccountbook.varReason, tblaccountbook.varPreviousBalance, tblaccountbook.varEntryType, tblaccountbook.varAmount, tblaccountbook.varBalance, tblaccountbook.varEntryBy, tblaccountdetails.varAccountName, CONCAT(tblsocietypersonnel.varEmpName, '-', rolesmasterculturemap.RoleName) AS Name FROM tblaccountbook INNER JOIN tblaccountdetails ON tblaccountbook.varAccountNo = tblaccountdetails.varAccountNo INNER JOIN tblsocietypersonnel ON tblaccountbook.varEntryBy = tblsocietypersonnel.intEmpCode INNER JOIN rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE (tblaccountbook.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') ORDER BY tblaccountbook.varDate DESC, tblaccountbook.intId DESC";

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}