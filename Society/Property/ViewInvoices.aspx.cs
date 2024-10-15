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

public partial class Society_Property_ViewInvoices : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
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



                        dbc.con.Open();
                        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblinvoiceforpersonnels SET  varRecieved='" + arry[15].ToString() + "',varOutstanding='0',varPaymentStatus='Paid',varTransactionId='" + arry[16].ToString() + "',varTransactionStatus='" + Request.Form["status"] + "',varPaymode='Internet Banking',varInvoiceStatus='Paid' WHERE varInvoiceId='" + arry[11].ToString() + "' and varSocietyId='" + arry[10].ToString() + "' AND varPersonnelId='" + arry[9].ToString() + "'", dbc.con);
                        cmd.ExecuteNonQuery();
                        dbc.con.Close();


                        //Hash value did not matched
                    }
                    getLoadData();
                }
                else
                {

                }
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
        try
        {
            lblInvoiceNo.Text = Cache["InvoiceId"].ToString();

            dbc.con.Close();
            dbc.con.Open();
            MySqlCommand da = new MySqlCommand("SELECT intId, intSocietyCode, varRegistrationNo, varName, varSAddress, varSPhone, varSMobile, varSEmail, varSFax, varCountryId, varStateId, varCityId, varPin, varConstructedby, varCompany, varCompanyAddress, varContactPerson, varContactMobile, varContactPhone, varContactEmail, varConstuctionYear, varTotalArea, varTotalWings, varIsActive,  statemaster.StateName, citymaster.CityName FROM tblsocietyinfo INNER JOIN  statemaster ON tblsocietyinfo.varStateId = statemaster.StateId INNER JOIN citymaster ON tblsocietyinfo.varCityId = citymaster.CityId  WHERE intSocietyCode='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'", dbc.con);
            dbc.dr1 = da.ExecuteReader();
            if (dbc.dr1.Read())
            {
                lblSocietyName.Text = dbc.dr1["varName"].ToString();
                lblPropertySociety.Text = dbc.dr1["varName"].ToString();
                lblSocietyAddress.Text = dbc.dr1["varSAddress"].ToString();
                lblSocietyState.Text = dbc.dr1["StateName"].ToString();
                lblSocietyCity.Text = dbc.dr1["CityName"].ToString();
                lblSocietyPIN.Text = dbc.dr1["varPin"].ToString();
            }
            dbc.con.Close();
            dbc.dr1.Dispose();

            dbc.con.Close();
            dbc.con.Open();
            da = new MySqlCommand("SELECT tblproperty.varName AS name, CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) AS address,DATE_FORMAT(tblinvoice.varDateTime,'%d-%m-%Y') AS dat, tblinvoiceforpersonnels.varOutstanding, tblinvoice.varTotal, tblinvoice.varInvoiceId, tblinvoiceforpersonnels.varPersonnelId,tblproperty.varMobile, tblproperty.varEmail, tblinvoiceforpersonnels.varPaymentStatus FROM tblproperty INNER JOIN tblinvoiceforpersonnels ON tblproperty.varPropertyId = tblinvoiceforpersonnels.varPersonnelId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId INNER JOIN tblinvoice ON tblinvoiceforpersonnels.varInvoiceId = tblinvoice.varInvoiceId WHERE  (tblproperty.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') AND  (tblinvoice.varInvoiceId = '" + Cache["InvoiceId"].ToString() + "') AND(tblinvoiceforpersonnels.varPersonnelId = '" + Cache["PersonnelId"].ToString() + "' ) ", dbc.con);
            dbc.dr1 = da.ExecuteReader();
            if (dbc.dr1.Read())
            {
                lblPropertyOwner.Text = dbc.dr1["name"].ToString();
                lblPropertyAddress.Text = dbc.dr1["address"].ToString();
                lblMobile.Text = dbc.dr1["varMobile"].ToString();
                lblEmail.Text = dbc.dr1["varEmail"].ToString();
                lblDate.Text = dbc.dr1["dat"].ToString();
                lblSubBill.Text = dbc.dr1["varTotal"].ToString();
                lblFinalBill.Text = dbc.dr1["varTotal"].ToString();

                if (dbc.dr1["varPaymentStatus"].ToString() == "Paid")
                {
                    btnPayNow.Text = "Paid";
                    btnPayNow.Enabled = false;
                }
            }
            dbc.con.Close();
            dbc.dr1.Dispose();

            dbc.con.Close();
            dbc.con.Open();
            MySqlDataAdapter adp = new MySqlDataAdapter("SELECT varParticulars as Particulars, varAmount as Amount, varInvoiceId FROM tblinvoicedetails WHERE(varInvoiceId = '" + Cache["InvoiceId"].ToString() + "')", dbc.con);
            DataSet dtInvoice = new DataSet();
            adp.Fill(dtInvoice);
            lstInvoiceDetails.DataSource = dtInvoice;
            lstInvoiceDetails.DataBind();
            dbc.con.Close();
            dbc.dr1.Dispose();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            dbc.dr1.Dispose();
            string exp = ex.Message;
        }
    }


    protected void btnPayNow_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Society/Payprocess/Default.aspx?amount=" + lblFinalBill.Text + "&firstname=" + lblPropertyOwner.Text + "&email=" + lblEmail.Text + "&phone=" + lblMobile.Text + "&productinfo=SKSPPAYMENT&udf1=" + lblInvoiceNo.Text + "&udf2=" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "&udf3=" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "&surl=http://societykatta.com/Society/Property/ViewInvoices.aspx&furl=http://societykatta.com/Society/Property/Invoices.aspx", false);
    }
}