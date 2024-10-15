using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Globalization;

public partial class Society_Admin_Accounts_BalanceSheet : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
       DateTime datef, datet;
    protected void Page_Load(object sender, EventArgs e)
    {
        grdAccountNave.DataBind();
        gdvAccount.DataBind();
    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        datef = DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);
        datet = DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);
        if (datef > DateTime.UtcNow)
        {
            Response.Write("<script>alert('Please Select Proper Date');window.location='BalanceSheet.aspx';</script>");
        }
        else if (datet > DateTime.UtcNow)
        {
            Response.Write("<script>alert('Please Select Proper Date');window.location='BalanceSheet.aspx';</script>");
        }
        else if (datef > datet)
        {
            Response.Write("<script>alert('Please Select Proper Date');window.location='BalanceSheet.aspx';</script>");
        }
        else
        {

            DataTable dt = new DataTable();

            dt.Columns.Add("Account Name");
            dt.Columns.Add("Amount");

            dt.Rows.Add("Initial Balance", dbc.getInitialbalance(datef.ToString("yyyy-MM-dd"), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)));

            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblaccountdetails.varAccountName AS 'Account Name', SUM(tblaccountbook.varAmount) AS 'Amount' FROM tblaccountbook INNER JOIN tblaccountdetails ON tblaccountbook.varAccountNo = tblaccountdetails.varAccountNo where tblaccountbook.varEntryType=1 AND tblaccountbook.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblaccountbook.varDate BETWEEN '" + datef.ToString("yyyy-MM-dd") + "' and '" + datet.ToString("yyyy-MM-dd") + "' GROUP BY tblaccountdetails.varAccountName ORDER BY tblaccountbook.varDate asc , tblaccountbook.intId asc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            dbc.con.Close();

            //nave 

            DataTable dta = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmda = new MySql.Data.MySqlClient.MySqlCommand();
            cmda = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblaccountdetails.varAccountName AS 'Account Name', SUM(tblaccountbook.varAmount) AS 'Amount' FROM tblaccountbook INNER JOIN tblaccountdetails ON tblaccountbook.varAccountNo = tblaccountdetails.varAccountNo where tblaccountbook.varEntryType=0 AND tblaccountbook.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblaccountbook.varDate BETWEEN '" + datef.ToString("yyyy-MM-dd") + "' and '" + datet.ToString("yyyy-MM-dd") + "' GROUP BY tblaccountdetails.varAccountName ORDER BY tblaccountbook.varDate asc , tblaccountbook.intId asc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpa = new MySql.Data.MySqlClient.MySqlDataAdapter(cmda);
            adpa.Fill(dta);
            dta.Rows.Add("Closing Balance", dbc.getClosingBalance(datet.ToString("yyyy-MM-dd"), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)));

            dbc.con.Close();


            if (dt.Rows.Count > dta.Rows.Count)
            {
                int cc = dt.Rows.Count - dta.Rows.Count;
                for (int i = 0; i < cc; i++)
                {
                    dta.Rows.Add(new object[] { null, null });
                }
                grdAccountNave.DataSource = dta;
                grdAccountNave.DataBind();
                gdvAccount.DataSource = dt;
                gdvAccount.DataBind();
            }
            else
            {
                int cc1 = dta.Rows.Count - dt.Rows.Count;
                for (int i = 0; i < cc1; i++)
                {
                    dt.Rows.Add(new object[] { null, null });
                }
                grdAccountNave.DataSource = dta;
                grdAccountNave.DataBind();
                gdvAccount.DataSource = dt;
                gdvAccount.DataBind();
            }
        }
    }
    private DataTable RemoveDuplicatesRecords(DataTable dt)
    {
        //Returns just 5 unique rows
        var UniqueRows = dt.AsEnumerable().Distinct(DataRowComparer.Default);
        DataTable dt2 = UniqueRows.CopyToDataTable();
        return dt2;
    }
    private decimal TotalPrice = (decimal)0.0;
    protected void gdvAccount_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        // check row type
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // if row type is DataRow, add ProductSales value to TotalSales
            if (DBNull.Value.Equals(DataBinder.Eval(e.Row.DataItem, "Amount")))
            { }
            else
                TotalPrice += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount"));
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        // If row type is footer, show calculated total value
        // Since this example uses sales in dollars, I formatted output as currency
        {
            e.Row.Cells[1].Text = TotalPrice.ToString();
        }
    }

    private decimal TotalPricenave = (decimal)0.0;
    protected void grdAccountNave_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // check row type
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // if row type is DataRow, add ProductSales value to TotalSales
            if (DBNull.Value.Equals(DataBinder.Eval(e.Row.DataItem, "Amount")))
            { }
            else
                TotalPricenave += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount"));
        }
        // if row type is DataRow, add ProductSales value to TotalSales

        else if (e.Row.RowType == DataControlRowType.Footer)
        // If row type is footer, show calculated total value
        // Since this example uses sales in dollars, I formatted output as currency
        {
            e.Row.Cells[1].Text = TotalPricenave.ToString();
        }
    }
}