using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Society_Admin_Accounts_SocietyInvoices : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
  
    DatabaseConnectionSKAdmin dbcsk = new DatabaseConnectionSKAdmin();
    protected void Page_Load(object sender, EventArgs e)
    {
        getData();
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
                Response.Redirect("~/Society/Admin/Accounts/ViewSocietyInvoice.aspx", false);
            }
            else if (e.CommandName == "pay")
            {
                dbcsk.con.Open();
                dbcsk.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblinvoice.varInvoiceNo, date_format(tblinvoice.varDateTime, '%d-%m-%Y') as varDateTime, tblinvoice.varTotal, tblinvoiceforsocietyorvendors.varPaymentStatus, tblinvoiceforsocietyorvendors.varOutstanding, tblinvoiceforsocietyorvendors.varPersonnelId FROM tblinvoice INNER JOIN tblinvoiceforsocietyorvendors ON tblinvoice.varInvoiceNo = tblinvoiceforsocietyorvendors.varInvoiceId and tblinvoiceforsocietyorvendors.varSocietyOrVendor=2 where tblinvoice.varInvoiceNo='" + cmdArgs[0].ToString() + "'", dbcsk.con);
                dbcsk.dr = dbcsk.cmd.ExecuteReader();
                if (dbcsk.dr.Read())
                {
                    dbc.con.Open();
                    dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT concat(tblsocietyinfo.varName,'-' ,citymaster.CityName) as Society, tblsocietyinfo.varSEmail, tblsocietyinfo.varSMobile, tblsocietyinfo.intSocietyCode FROM tblsocietyinfo INNER JOIN citymaster ON tblsocietyinfo.varCityId = citymaster.CityId where tblsocietyinfo.intSocietyCode='" + cmdArgs[1].ToString() + "'", dbc.con);
                    dbc.dr = dbc.cmd.ExecuteReader();
                    if (dbc.dr.Read())
                    {
                        Response.Redirect("~/Society/Payprocess/Default.aspx?amount=" + dbcsk.dr["varTotal"].ToString() + "&firstname=" + dbc.dr["Society"].ToString() + "&email=" + dbc.dr["varSEmail"].ToString() + "&phone=" + dbc.dr["varSMobile"].ToString() + "&productinfo=SKSPPAYMENT&udf1=" + cmdArgs[0].ToString() + "&udf2=" + dbc.dr["intSocietyCode"].ToString() + "&udf3=" + dbc.dr["intSocietyCode"].ToString() + "&surl=http://societykatta.com/Society/Admin/Accounts/ViewSocietyInvoice.aspx&furl=http://societykatta.com/Society/Admin/Accounts/SocietyInvoices.aspx", false);
                    }
                    dbc.con.Close();
                }
                dbcsk.con.Close();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}