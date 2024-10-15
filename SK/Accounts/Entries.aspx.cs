using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Globalization;

public partial class Society_Admin_Accounts_Entries : System.Web.UI.Page
{
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getAccountNames();
            getAmounts();
        }
    }
    public void getAccountNames()
    {
        try
        {
            dbc.con1.Open();
            dbc.oDt = new DataTable();
            dbc.dataAdapter = new MySql.Data.MySqlClient.MySqlDataAdapter("SELECT intId,  varAccountNo, varAccountName, varDescription, ex1, ex2, ex3, ex4 FROM tblaccountdetails", dbc.con1);
            dbc.dataAdapter.Fill(dbc.oDt);
            ddlAccount.DataSource = dbc.oDt;
            ddlAccount.DataTextField = "varAccountName";
            ddlAccount.DataValueField = "varAccountNo";
            ddlAccount.DataBind();
            dbc.con1.Close();

        }
        catch (Exception ex)
        {
            string ws = ex.Message;
        }
    }
    public void getAmounts()
    {
        txtInitialBalance.Text = dbc.getInitialbalance(DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"));

        txtClosingBalance.Text = dbc.getClosingBalance(DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"));

        SqlDataSourceEntries.SelectCommand = "SELECT tblaccountbook.intId, DATE_FORMAT(tblaccountbook.varDate,'%d-%m-%Y') as varDate, tblaccountbook.varAccountNo, tblaccountbook.varVoucher, tblaccountbook.varReason, tblaccountbook.varPreviousBalance, tblaccountbook.varEntryType, tblaccountbook.varAmount, tblaccountbook.varBalance, tblaccountbook.varEntryBy, tblaccountdetails.varAccountName FROM tblaccountbook INNER JOIN tblaccountdetails ON tblaccountbook.varAccountNo = tblaccountdetails.varAccountNo   ORDER BY tblaccountbook.varDate DESC, tblaccountbook.intId DESC";

    }
    protected void lstEntries_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            SqlDataSourceEntries.SelectCommand = "SELECT tblaccountbook.intId, DATE_FORMAT(tblaccountbook.varDate,'%d-%m-%Y') as varDate, tblaccountbook.varAccountNo, tblaccountbook.varVoucher, tblaccountbook.varReason, tblaccountbook.varPreviousBalance, tblaccountbook.varEntryType, tblaccountbook.varAmount, tblaccountbook.varBalance, tblaccountbook.varEntryBy, tblaccountdetails.varAccountName FROM tblaccountbook INNER JOIN tblaccountdetails ON tblaccountbook.varAccountNo = tblaccountdetails.varAccountNo   ORDER BY tblaccountbook.varDate DESC, tblaccountbook.intId DESC";

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstEntries_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Deletes")
        {
            int insert_ok = dbc.delete_tblamsaccountbook(e.CommandArgument.ToString().Split(':')[0], e.CommandArgument.ToString().Split(':')[1], Convert.ToDateTime(DateTime.ParseExact(e.CommandArgument.ToString().Split(':')[2], "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"),  e.CommandArgument.ToString().Split(':')[3]);

            if (insert_ok == 1)
            {
                ScriptManager.RegisterStartupScript(
                   this,
                   this.GetType(),
                   "MessageBox",
                   "alert('Entry Deleted Successfully !!!');window.location='Entries.aspx';", true);
            } 
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlEntryType.SelectedValue == "0")
            {

                if (Convert.ToDateTime(txtDOB.Text) < Convert.ToDateTime(DateTime.UtcNow.ToString("dd-MM-yyyy")))
                {
                    MessageDisplay(Resources.Messages.DebitPreviousNoEntry, "alert alert-danger");
                }
                else
                {
                    executeDebit();
                }
            }
            else
            {
                execute();
            }
            getAmounts();
            clear();
        }
        catch (Exception ex)
        {
            string ed = ex.Message;
            getAmounts();
        }
    }

    public void execute()
    {
        string prevBalbance = dbc.getClosingBalance(Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"));
        if (dbc.insert_tblaccountbook( Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), ddlAccount.SelectedValue, txtVoucher.Text.Replace("'", "\\'"), txtReason.Text.Replace("'", "\\'"), prevBalbance, ddlEntryType.SelectedValue, txtAmount.Text.Replace("'", "\\'"), Convert.ToInt16(ddlEntryType.SelectedValue) == 1 ? (Convert.ToDouble(prevBalbance) + Convert.ToDouble(txtAmount.Text)).ToString() : (Convert.ToDouble(prevBalbance) - Convert.ToDouble(txtAmount.Text)).ToString(), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value)) == 1)
        {
            MessageDisplay(Resources.Messages.AccountEntryOk, "alert alert-success");
        }
        else
        {

        } 
    }

    public void executeDebit()
    {
        Double oldDebit = Convert.ToDouble(dbc.getClosingBalance(Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd")));

        if (txtClosingBalance.Text != "0")
        {
            if (oldDebit == 0)
            {
                MessageDisplay(Resources.Messages.AmountGreater, "alert alert-danger");
            }
            else if (oldDebit < Convert.ToDouble(txtAmount.Text))
            {
                MessageDisplay(Resources.Messages.AmountGreater, "alert alert-danger");
            }
            else
            {
                int insert_ok = dbc.insert_tblaccountbook( Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), ddlAccount.SelectedValue, txtVoucher.Text.Replace("'", "\\'"), txtReason.Text.Replace("'", "\\'"), oldDebit.ToString(), ddlEntryType.SelectedValue, txtAmount.Text.Replace("'", "\\'"), txtAmount.Text.Replace("'", "\\'"), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value));

                if (insert_ok == 1)
                {
                    MessageDisplay(Resources.Messages.AccountEntryOk, "alert alert-success");
                }
            }
        }
        else
        {
            MessageDisplay(Resources.Messages.AmountGreater, "alert alert-danger");
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {

    }

    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }

    public void clear()
    {
        txtAmount.Text = "";
        txtDOB.Text = "";
        txtReason.Text = "";
        txtVoucher.Text = "";
        ddlAccount.SelectedIndex = 0;
        ddlEntryType.SelectedIndex = 0;
    }
}