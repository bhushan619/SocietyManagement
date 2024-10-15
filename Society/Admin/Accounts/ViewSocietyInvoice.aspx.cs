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

public partial class Society_Admin_Accounts_ViewSocietyInvoice : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();

    DatabaseConnectionSKAdmin dbcsk = new DatabaseConnectionSKAdmin();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {

                if (Request.Form["status"] == null || string.IsNullOrWhiteSpace(Request.Form["status"]))
                {
                    getLoadData();
                }
                else
                {
                    string[] merc_hash_vars_seq;
                    string merc_hash_string = string.Empty;
                    string merc_hash = string.Empty;
                    string transactionid = string.Empty;
                    string productinfo = string.Empty;
                    string amt = string.Empty;
                    string pname = string.Empty;
                    string personId = string.Empty;
                    string socId = string.Empty;

                    string hash_seq = "key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5|udf6|udf7|udf8|udf9|udf10";

                    if (Request.Form["status"] == "success")
                    {

                        merc_hash_vars_seq = hash_seq.Split('|');
                        Array.Reverse(merc_hash_vars_seq);
                        merc_hash_string = ConfigurationManager.AppSettings["SALT"] + "|" + Request.Form["status"];


                        foreach (string merc_hash_var in merc_hash_vars_seq)
                        {
                            merc_hash_string += "|";
                            merc_hash_string = merc_hash_string + (Request.Form[merc_hash_var] != null ? Request.Form[merc_hash_var] : "");


                        }
                        //Response.Write(merc_hash_string);//exit;
                        merc_hash = Generatehash512(merc_hash_string).ToLower();

                        if (merc_hash != Request.Form["hash"])
                        {
                            //Response.Write("Hash value did not matched");

                        }
                        else
                        {

                            string[] arry = merc_hash_string.Split(new char[] { '|' });

                            transactionid = arry[16].ToString();
                            productinfo = arry[14].ToString();
                            amt = arry[15].ToString();
                            pname = arry[10].ToString();
                            //OK Done


                            lblHash.Text = merc_hash_string.ToString();

                            dbcsk.con.Open();
                            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblinvoiceforsocietyorvendors SET  varRecieved='" + arry[15].ToString() + "',varOutstanding='0',varPaymentStatus='Paid',varTransactionId='" + arry[16].ToString() + "',varTransactionStatus='" + Request.Form["status"] + "',varPaymode='Internet Banking',varInvoiceStatus='Paid' WHERE varInvoiceId='" + arry[11].ToString() + "' AND varPersonnelId='" + arry[9].ToString() + "'", dbcsk.con);
                            cmd.ExecuteNonQuery();
                            dbcsk.con.Close();


                            //Hash value did not matched
                        }
                        getLoadData();
                    }
                    else
                    {

                    }
                }
            }
            catch (Exception ex)
            {
                lblHash.Text = ex.Message;
            }
        }
    }

    public string Generatehash512(string text)
    {


        byte[] message = Encoding.UTF8.GetBytes(text);

        UnicodeEncoding UE = new UnicodeEncoding();
        byte[] hashValue;
        SHA512Managed hashString = new SHA512Managed();
        string hex = "";
        hashValue = hashString.ComputeHash(message);
        foreach (byte x in hashValue)
        {
            hex += String.Format("{0:x2}", x);
        }
        return hex;


    }
    public void getLoadData()
    {
        if (Cache["InvoiceId"] == null)
        {
            Response.Redirect("~/Society/Admin/Accounts/SocietyInvoices.aspx", false);
        }
        else
        {
            lblInvoiceNo.Text = Cache["InvoiceId"].ToString();


            lblSocietyName.Text = "SocietyKatta.com";
            lblSocietyAddress.Text = "Flat No. 1, Akshay Chambers,<br> Samarth Colony,<br> Near Prabhat Chowk, Jalgaon.";
            lblSocietyState.Text = "Maharashtra";
            lblSocietyCity.Text = "Jalgaon";
            lblSocietyPIN.Text = "425001";


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

                if (dbcsk.dr["varPaymentStatus"].ToString() == "Paid")
                {
                    btnPayNow.Enabled = false;
                    btnPayNow.Text = "Paid";
                } 
            }
            dbcsk.con.Close();
            dbcsk.con.Open();
            MySqlDataAdapter adp = new MySqlDataAdapter("SELECT varParticulars as Particulars, varAmount as Amount, varInvoiceId FROM tblinvoicedetails WHERE(varInvoiceId = '" + Cache["InvoiceId"].ToString() + "')", dbcsk.con);
            DataSet dtInvoice = new DataSet();
            adp.Fill(dtInvoice);
            lstInvoiceDetails.DataSource = dtInvoice;
            lstInvoiceDetails.DataBind();
            dbcsk.con.Close();
        }
    }

    protected void btnPayNow_Click(object sender, EventArgs e)
    {
        dbcsk.con.Open();
        dbcsk.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblinvoice.varInvoiceNo, date_format(tblinvoice.varDateTime, '%d-%m-%Y') as varDateTime, tblinvoice.varTotal, tblinvoiceforsocietyorvendors.varPaymentStatus, tblinvoiceforsocietyorvendors.varOutstanding, tblinvoiceforsocietyorvendors.varPersonnelId FROM tblinvoice INNER JOIN tblinvoiceforsocietyorvendors ON tblinvoice.varInvoiceNo = tblinvoiceforsocietyorvendors.varInvoiceId and tblinvoiceforsocietyorvendors.varSocietyOrVendor=2 where tblinvoice.varInvoiceNo='" + Cache["InvoiceId"].ToString() + "'", dbcsk.con);
        dbcsk.dr = dbcsk.cmd.ExecuteReader();
        if (dbcsk.dr.Read())
        {
            dbc.con.Open();
            dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT concat(tblsocietyinfo.varName,'-' ,citymaster.CityName) as Society, tblsocietyinfo.varSEmail, tblsocietyinfo.varSMobile, tblsocietyinfo.intSocietyCode FROM tblsocietyinfo INNER JOIN citymaster ON tblsocietyinfo.varCityId = citymaster.CityId where tblsocietyinfo.intSocietyCode='" + Cache["PersonnelId"].ToString() + "'", dbc.con);
            dbc.dr = dbc.cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                Response.Redirect("~/Society/Payprocess/Default.aspx?amount=" + dbcsk.dr["varTotal"].ToString() + "&firstname=" + dbc.dr["Society"].ToString() + "&email=" + dbc.dr["varSEmail"].ToString() + "&phone=" + dbc.dr["varSMobile"].ToString() + "&productinfo=SKSPPAYMENT&udf1=" + lblInvoiceNo.Text + "&udf2=" + dbc.dr["intSocietyCode"].ToString() + "&udf3=" + dbc.dr["intSocietyCode"].ToString() + "&surl=http://societykatta.com/Society/Admin/Accounts/ViewSocietyInvoice.aspx&furl=http://societykatta.com/Society/Admin/Accounts/SocietyInvoices.aspx", false);
            }
            dbc.con.Close();
        }
        dbcsk.con.Close();
    }
}