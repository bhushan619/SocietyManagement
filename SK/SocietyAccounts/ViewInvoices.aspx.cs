using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

public partial class SK_SocietyAccounts_ViewInvoices : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices(); 
    DatabaseConnectionSKAdmin dbcsk = new DatabaseConnectionSKAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Cache["InvoiceId"] == null)
        {
            Response.Redirect("~/SK/SocietyAccounts/Invoices.aspx", false);
        }
        else if (!IsPostBack)
        {
            getLoadData();
        }

    }
    public void getLoadData()
    {
        lblInvoiceNo.Text = Cache["InvoiceId"].ToString();

         
        lblSocietyName.Text = "SocietyKatta.com";
        lblSocietyAddress.Text = "Flat No. 1, Akshay Chambers,<br> Samarth Colony,<br> Near Prabhat Chowk, Jalgaon.";
        lblSocietyState.Text = "Maharashtra";
        lblSocietyCity.Text = "Jalgaon";
        lblSocietyPIN.Text = "425001";

        if (Cache["SocOrVen"].ToString() == "1")
        {
            
            dbcsk.con.Open();
            dbcsk.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblinvoice.varInvoiceNo, date_format(tblinvoice.varDateTime, '%d-%m-%Y') as varDateTime, tblinvoice.varSubTotal,tblinvoice.varTotal, tblinvoiceforsocietyorvendors.varPaymentStatus, tblinvoiceforsocietyorvendors.varOutstanding, tblinvoiceforsocietyorvendors.varPersonnelId FROM tblinvoice INNER JOIN tblinvoiceforsocietyorvendors ON tblinvoice.varInvoiceNo = tblinvoiceforsocietyorvendors.varInvoiceId and tblinvoiceforsocietyorvendors.varSocietyOrVendor=1 where tblinvoice.varInvoiceNo='" + Cache["InvoiceId"].ToString() + "'", dbcsk.con);
            dbcsk.dr = dbcsk.cmd.ExecuteReader();
            if (dbcsk.dr.Read())
            {
                dbcs.con.Open();
                dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT  tblvendor.varName, tblvendor.varAddress, citymaster.CityName, tblvendor.intVendorCode FROM tblvendor INNER JOIN citymaster ON tblvendor.varCity = citymaster.CityId where tblvendor.intVendorCode='" + Cache["PersonnelId"].ToString() + "'", dbcs.con);
                dbcs.dr = dbcs.cmd.ExecuteReader();
                if (dbcs.dr.Read())
                {
                    lblSocOrVenName.Text = dbcs.dr["varName"].ToString();
                    lblSocOrVenAddress.Text = dbcs.dr["varAddress"].ToString();
                    lblSocOrVenCity.Text = dbcs.dr["CityName"].ToString();
                }
                dbcs.con.Close();

                lblDate.Text = dbcsk.dr["varDateTime"].ToString();
                lblSubBill.Text = dbcsk.dr["varSubTotal"].ToString();
                lblFinalBill.Text = dbcsk.dr["varTotal"].ToString();
            }
            dbcsk.con.Close();
        }
        else
        {
            dbcsk.con.Open();
            dbcsk.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblinvoice.varInvoiceNo, date_format(tblinvoice.varDateTime, '%d-%m-%Y') as varDateTime, tblinvoice.varSubTotal,tblinvoice.varTotal, tblinvoiceforsocietyorvendors.varPaymentStatus, tblinvoiceforsocietyorvendors.varOutstanding, tblinvoiceforsocietyorvendors.varPersonnelId FROM tblinvoice INNER JOIN tblinvoiceforsocietyorvendors ON tblinvoice.varInvoiceNo = tblinvoiceforsocietyorvendors.varInvoiceId and tblinvoiceforsocietyorvendors.varSocietyOrVendor=2 where tblinvoice.varInvoiceNo='" + Cache["InvoiceId"].ToString() + "'", dbcsk.con);
            dbcsk.dr = dbcsk.cmd.ExecuteReader();
            if (dbcsk.dr.Read())
            {
                dbc.con.Open();
                dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblsocietyinfo.varName, tblsocietyinfo.intSocietyCode,  citymaster.CityName, tblsocietyinfo.varSAddress, tblsocietypersonnel.intEmpCode,tblsocietypersonnel.intRole FROM tblsocietyinfo INNER JOIN citymaster ON tblsocietyinfo.varCityId = citymaster.CityId INNER JOIN tblsocietypersonnel ON tblsocietyinfo.intSocietyCode = tblsocietypersonnel.intSocietyId INNER JOIN rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE (rolesmasterculturemap.RoleName = 'Admin') and tblsocietyinfo.intSocietyCode='" + Cache["PersonnelId"].ToString() + "'", dbc.con);
                dbc.dr = dbc.cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    lblSocOrVenName.Text = dbc.dr["varName"].ToString();
                    lblSocOrVenAddress.Text = dbc.dr["varSAddress"].ToString();
                    lblSocOrVenCity.Text = dbc.dr["CityName"].ToString();
                }
                dbc.con.Close();

                lblDate.Text = dbcsk.dr["varDateTime"].ToString();
                lblSubBill.Text = dbcsk.dr["varSubTotal"].ToString();
                lblFinalBill.Text = dbcsk.dr["varTotal"].ToString();
            }
            dbcsk.con.Close();
        } 
       
        dbcsk.con.Open();
        MySqlDataAdapter adp = new MySqlDataAdapter("SELECT varParticulars as Particulars, varAmount as Amount, varInvoiceId FROM tblinvoicedetails WHERE(varInvoiceId = '" + Cache["InvoiceId"].ToString() + "')", dbcsk.con);
        DataSet dtInvoice = new DataSet();
        adp.Fill(dtInvoice);
        lstInvoiceDetails.DataSource = dtInvoice;
        lstInvoiceDetails.DataBind();
        dbcsk.con.Close();
       
    }
}