using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SK_SocietyAccounts_Invoices : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();
    DatabaseConnectionSKAdmin dbcsk = new DatabaseConnectionSKAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.IsPostBack)
        {
            TabName.Value = Request.Form[TabName.UniqueID];
        }
        if (!IsPostBack)
        {
            getData();
        }
    }

    public void getData()
    {
        DataTable dtInvoice = new DataTable();

        dtInvoice.Columns.Add("Name");
        dtInvoice.Columns.Add("InvoiceNo");
        dtInvoice.Columns.Add("Date");
        dtInvoice.Columns.Add("Amount");
        dtInvoice.Columns.Add("Outstanding");
        dtInvoice.Columns.Add("PaymentStatus");
        dtInvoice.Columns.Add("varPersonnelId");
        dtInvoice.Columns.Add("SocOrVen");

        dbcsk.con.Open();
        dbcsk.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblinvoice.varInvoiceNo, date_format(tblinvoice.varDateTime, '%d-%m-%Y') as varDateTime, tblinvoice.varTotal, tblinvoiceforsocietyorvendors.varPaymentStatus, tblinvoiceforsocietyorvendors.varOutstanding, tblinvoiceforsocietyorvendors.varPersonnelId FROM tblinvoice INNER JOIN tblinvoiceforsocietyorvendors ON tblinvoice.varInvoiceNo = tblinvoiceforsocietyorvendors.varInvoiceId and tblinvoiceforsocietyorvendors.varSocietyOrVendor=2", dbcsk.con);
        dbcsk.dr = dbcsk.cmd.ExecuteReader();
        while (dbcsk.dr.Read())
        {
            dbc.con.Open();
            dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT concat(tblsocietyinfo.varName,'-' ,citymaster.CityName) as Society FROM tblsocietyinfo INNER JOIN citymaster ON tblsocietyinfo.varCityId = citymaster.CityId where tblsocietyinfo.intSocietyCode='" + dbcsk.dr["varPersonnelId"].ToString() + "'", dbc.con);
            dbc.dr = dbc.cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                dtInvoice.Rows.Add(dbc.dr["Society"].ToString(), dbcsk.dr["varInvoiceNo"].ToString(), dbcsk.dr["varDateTime"].ToString(), dbcsk.dr["varTotal"].ToString(), dbcsk.dr["varOutstanding"].ToString(), dbcsk.dr["varPaymentStatus"].ToString(), dbcsk.dr["varPersonnelId"].ToString(), "2");
            }
            dbc.con.Close();
        }
        dbcsk.con.Close();

        lstSocietyInvoices.DataSource = dtInvoice;
        lstSocietyInvoices.DataBind();

        dtInvoice.Rows.Clear();
        dbcsk.con.Open();
        dbcsk.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblinvoice.varInvoiceNo, date_format(tblinvoice.varDateTime, '%d-%m-%Y') as varDateTime, tblinvoice.varTotal, tblinvoiceforsocietyorvendors.varPaymentStatus, tblinvoiceforsocietyorvendors.varOutstanding, tblinvoiceforsocietyorvendors.varPersonnelId FROM tblinvoice INNER JOIN tblinvoiceforsocietyorvendors ON tblinvoice.varInvoiceNo = tblinvoiceforsocietyorvendors.varInvoiceId and tblinvoiceforsocietyorvendors.varSocietyOrVendor=1", dbcsk.con);
        dbcsk.dr = dbcsk.cmd.ExecuteReader();
        while (dbcsk.dr.Read())
        {
            dbcs.con.Open();
            dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT CONCAT(tblvendor.varName, '-', citymaster.CityName) AS vendors, tblvendor.intVendorCode FROM tblvendor INNER JOIN citymaster ON tblvendor.varCity = citymaster.CityId where tblvendor.intVendorCode='" + dbcsk.dr["varPersonnelId"].ToString() + "'", dbcs.con);
            dbcs.dr = dbcs.cmd.ExecuteReader();
            if (dbcs.dr.Read())
            {
                dtInvoice.Rows.Add(dbcs.dr["vendors"].ToString(), dbcsk.dr["varInvoiceNo"].ToString(), dbcsk.dr["varDateTime"].ToString(), dbcsk.dr["varTotal"].ToString(), dbcsk.dr["varOutstanding"].ToString(), dbcsk.dr["varPaymentStatus"].ToString(), dbcsk.dr["varPersonnelId"].ToString(), "1");
            }
            dbcs.con.Close();
        }
        dbcsk.con.Close();

        lstVendorInvoices.DataSource = dtInvoice;
        lstVendorInvoices.DataBind();

    }
    protected void lstInvoices_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            string[] cmdArgs = e.CommandArgument.ToString().Split(':');
            Cache["InvoiceId"] = cmdArgs[0].ToString();
            Cache["PersonnelId"] = cmdArgs[1].ToString();
            Cache["SocOrVen"] = cmdArgs[2].ToString();
            Response.Redirect("~/SK/SocietyAccounts/ViewInvoices.aspx", false);
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}