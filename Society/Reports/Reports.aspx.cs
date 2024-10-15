using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Configuration;
using MySql.Data.MySqlClient;
using System.Web.Services;

public partial class Society_Reports_Reports : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getCountData();
        }
    }
    public void getCountData()
    {
        try
        {
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT  CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) AS Flat, tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo,  DATE_FORMAT(tblinvoice.varDateTime, '%d-%m-%Y') AS Date,sum(tblinvoice.varTotal) AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  tblinvoiceforpersonnels.varPaymentStatus AS PaymentStatus, tblinvoiceforpersonnels.varPersonnelId       FROM            tblinvoice INNER JOIN   tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and   tblinvoiceforpersonnels.varPaymentStatus='Paid'", dbc.con1);

            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblTopInvoicePaid.Text = string.IsNullOrEmpty(dbc.dr["Amount"].ToString()) ? "0" : dbc.dr["Amount"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmda = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT  CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) AS Flat, tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo,  DATE_FORMAT(tblinvoice.varDateTime, '%d-%m-%Y') AS Date,sum(tblinvoice.varTotal) AS UnpaidAmount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  tblinvoiceforpersonnels.varPaymentStatus AS PaymentStatus, tblinvoiceforpersonnels.varPersonnelId       FROM            tblinvoice INNER JOIN   tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and   tblinvoiceforpersonnels.varPaymentStatus='Pending'", dbc.con1);

            dbc.dr = cmda.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblunpaid.Text = string.IsNullOrEmpty(dbc.dr["UnpaidAmount"].ToString()) ? "0" : dbc.dr["UnpaidAmount"].ToString(); 
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdpr = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId) as newvisitor, CONCAT(FirstName, ' ', LastName) AS Name, ContactNumber, Email, VehicleNo, ArrivedFrom, InTime, OutTime, PurposeOFVisit, Comments, CreatedDate, IsActive FROM visitors where varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ", dbc.con1);
            dbc.dr = cmdpr.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblVisitor.Text = string.IsNullOrEmpty(dbc.dr["newvisitor"].ToString()) ? "0" : dbc.dr["newvisitor"].ToString(); 
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdemp = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId) as totalComplaints, varSocietyId, varPersonneId, intPersonelRole, varAssignToRoleId, varDate, varTime, varSubject, varDescription, varStatus, varRemark, varProceedDate, intIsActive, ex1, ex2, ex3, ex4, ex5 FROM tblcompliants WHERE  varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ", dbc.con1);
            dbc.dr = cmdemp.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblcomplaints.Text = string.IsNullOrEmpty(dbc.dr["totalComplaints"].ToString()) ? "0" : dbc.dr["totalComplaints"].ToString(); 
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdaj = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId) as TotalPendingrequest FROM tblrequest WHERE   varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ", dbc.con1);

            dbc.dr = cmdaj.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblrequest.Text = string.IsNullOrEmpty(dbc.dr["TotalPendingrequest"].ToString()) ? "0" : dbc.dr["TotalPendingrequest"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdajdoc = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT COUNT( DISTINCT varPersonnelId) as totalmemberdoc FROM tbldocuments where varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ", dbc.con1);

            dbc.dr = cmdajdoc.ExecuteReader();
            if (dbc.dr.Read())
            {
                lbldocument.Text = string.IsNullOrEmpty(dbc.dr["totalmemberdoc"].ToString()) ? "0" : dbc.dr["totalmemberdoc"].ToString(); 
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdajinvo = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(intId) as totalinvoice FROM tblinvoiceforpersonnels where varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ", dbc.con1);

            dbc.dr = cmdajinvo.ExecuteReader();
            if (dbc.dr.Read())
            {
                lbltotalinvoices.Text = string.IsNullOrEmpty(dbc.dr["totalinvoice"].ToString()) ? "0" : dbc.dr["totalinvoice"].ToString(); 
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

        }
        catch (Exception ex)
        {
            dbc.con1.Close();
            //dbc.dr.Dispose();
            string exp = ex.Message;
        }

    }
}