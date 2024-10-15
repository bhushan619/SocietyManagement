using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SK_Reports_Dashboard : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    DatabaseConnectionSKAdmin dbcsk = new DatabaseConnectionSKAdmin();
    DatabaseConnectionServices dbser = new DatabaseConnectionServices();
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
            //Totalclassified
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intid) as Totalclassified FROM tblclassified WHERE  intIsActive=1  ", dbc.con1);

            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblTopClassifieds.Text = string.IsNullOrEmpty(dbc.dr["Totalclassified"].ToString()) ? "0" : dbc.dr["Totalclassified"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();
            //Totalrequest
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmda = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId) as Totalrequest FROM tblrequest WHERE   varStatus='Pending' ", dbc.con1);

            dbc.dr = cmda.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblTopRequests.Text = string.IsNullOrEmpty(dbc.dr["Totalrequest"].ToString()) ? "0" : dbc.dr["Totalrequest"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();
            //totalComplaints
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdempr = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId) as totalComplaints, varSocietyId, varPersonneId, intPersonelRole, varAssignToRoleId, varDate, varTime, varSubject, varDescription, varStatus, varRemark, varProceedDate, intIsActive, ex1, ex2, ex3, ex4, ex5 FROM tblcompliants WHERE  varStatus ='New'  ", dbc.con1);
            dbc.dr = cmdempr.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblcomplaints.Text = string.IsNullOrEmpty(dbc.dr["totalComplaints"].ToString()) ? "0" : dbc.dr["totalComplaints"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();
            //event
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdevent = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(intId) as totalevent FROM tbleventannouncement where intIsActive=1  ", dbc.con1);

            dbc.dr = cmdevent.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblTotalevent.Text = string.IsNullOrEmpty(dbc.dr["totalevent"].ToString()) ? "0" : dbc.dr["totalevent"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();
            //Enquiry
            dbcsk.con1.Close();
            dbcsk.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdEnquiry = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(intId) as totalenquiry FROM tblenquiry   ", dbcsk.con1);

            dbcsk.dr = cmdEnquiry.ExecuteReader();
            if (dbcsk.dr.Read())
            {
                lblTotalenquiry.Text = string.IsNullOrEmpty(dbcsk.dr["totalenquiry"].ToString()) ? "0" : dbcsk.dr["totalenquiry"].ToString();
            }
            dbcsk.con1.Close();
            dbcsk.dr.Dispose();
            //help
            dbcsk.con1.Close();
            dbcsk.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdhelp = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(intId) as totalhelp FROM tblskhelp   ", dbcsk.con1);

            dbcsk.dr = cmdhelp.ExecuteReader();
            if (dbcsk.dr.Read())
            {
                lbltotalhelp.Text = string.IsNullOrEmpty(dbcsk.dr["totalhelp"].ToString()) ? "0" : dbcsk.dr["totalhelp"].ToString();
            }
            dbcsk.con1.Close();
            dbcsk.dr.Dispose();
            //support
            dbcsk.con1.Close();
            dbcsk.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdsupport = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(intId) as totalsupport FROM tblsksupport where intIsActive=1   ", dbcsk.con1);

            dbcsk.dr = cmdsupport.ExecuteReader();
            if (dbcsk.dr.Read())
            {
                lbltotsupport.Text = string.IsNullOrEmpty(dbcsk.dr["totalsupport"].ToString()) ? "0" : dbcsk.dr["totalsupport"].ToString();
            }
            dbcsk.con1.Close();
            dbcsk.dr.Dispose();

            //poll
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdpoll = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(intId) as totalpoll FROM tblpoll where intIsActive=1   ", dbc.con1);

            dbc.dr = cmdpoll.ExecuteReader();
            if (dbc.dr.Read())
            {
                lbltotalpoll.Text = string.IsNullOrEmpty(dbc.dr["totalpoll"].ToString()) ? "0" : dbc.dr["totalpoll"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            //Notices
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdNotices = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(intId) as totalNotices FROM tblnotice where intIsActive=1   ", dbc.con1);

            dbc.dr = cmdNotices.ExecuteReader();
            if (dbc.dr.Read())
            {
                lbltotalNotices.Text = string.IsNullOrEmpty(dbc.dr["totalNotices"].ToString()) ? "0" : dbc.dr["totalNotices"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            //Vendor
            dbser.con1.Close();
            dbser.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdVendor = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(intId) as totalVendor FROM tblvendor where varIsActive=1   ", dbser.con1);

            dbser.dr = cmdVendor.ExecuteReader();
            if (dbser.dr.Read())
            {
                lbltotalvendor.Text = string.IsNullOrEmpty(dbser.dr["totalVendor"].ToString()) ? "0" : dbser.dr["totalVendor"].ToString();
            }
            dbser.con1.Close();
            dbser.dr.Dispose();

          //  SELECT COUNT(tblsocietypersonnel.intId)AS totadmin, tblsocietypersonnel.intRole, rolesmasterculturemap.RoleName FROM     tblsocietypersonnel INNER JOIN    rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN   rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId HAVING(rolesmasterculturemap.RoleName = 'Admin')
            //   ...............................................................................................
            //Totalproperty
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdpr = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId) as Totalproperty FROM tblproperty WHERE intIsActive=1 ", dbc.con1);
            dbc.dr = cmdpr.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblTopProperties.Text = string.IsNullOrEmpty(dbc.dr["Totalproperty"].ToString()) ? "0" : dbc.dr["Totalproperty"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();
            //Total employee
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdemp = new MySql.Data.MySqlClient.MySqlCommand(" SELECT COUNT(tblsocietypersonnel.intId)AS Totalemp, tblsocietypersonnel.intRole,tblsocietypersonnel.intIsActive, rolesmasterculturemap.RoleName FROM     tblsocietypersonnel INNER JOIN    rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN   rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId HAVING(rolesmasterculturemap.RoleName != 'Admin') and tblsocietypersonnel.intIsActive=1  ", dbc.con1);
            dbc.dr = cmdemp.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblTopEmployees.Text = string.IsNullOrEmpty(dbc.dr["Totalemp"].ToString()) ? "0" : dbc.dr["Totalemp"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            //Total admin
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdadmin = new MySql.Data.MySqlClient.MySqlCommand(" SELECT COUNT(tblsocietypersonnel.intId)AS Totaladmin, tblsocietypersonnel.intRole,tblsocietypersonnel.intIsActive, rolesmasterculturemap.RoleName FROM     tblsocietypersonnel INNER JOIN    rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN   rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId HAVING (rolesmasterculturemap.RoleName = 'Admin') and tblsocietypersonnel.intIsActive=1  ", dbc.con1);
            dbc.dr = cmdadmin.ExecuteReader();
            if (dbc.dr.Read())
            {
                lbltotaladmin.Text = string.IsNullOrEmpty(dbc.dr["Totaladmin"].ToString()) ? "0" : dbc.dr["Totaladmin"].ToString();
              
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            //Total Society
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdSociety = new MySql.Data.MySqlClient.MySqlCommand(" SELECT count(intId) as TotalSociety FROM tblsocietyinfo WHERE varIsActive=1  ", dbc.con1);
            dbc.dr = cmdSociety.ExecuteReader();
            if (dbc.dr.Read())
            {
                lbltotalsociety.Text = string.IsNullOrEmpty(dbc.dr["TotalSociety"].ToString()) ? "0" : dbc.dr["TotalSociety"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();
            //paid Amount
            //dbc.con1.Close();
            //dbc.con1.Open();
            //MySql.Data.MySqlClient.MySqlCommand cmdx = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT  CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) AS Flat, tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo,  DATE_FORMAT(tblinvoice.varDateTime, '%d-%m-%Y') AS Date,sum(tblinvoice.varTotal) AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  tblinvoiceforpersonnels.varPaymentStatus AS PaymentStatus, tblinvoiceforpersonnels.varPersonnelId       FROM            tblinvoice INNER JOIN   tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoiceforpersonnels.varPaymentStatus='Paid'", dbc.con1);

            //dbc.dr = cmdx.ExecuteReader();
            //if (dbc.dr.Read())
            //{
            //    lblTopInvoicePaid.Text = string.IsNullOrEmpty(dbc.dr["Amount"].ToString()) ? "0" : dbc.dr["Amount"].ToString();
            //}
            //dbc.con1.Close();
            //dbc.dr.Dispose();
            ////UnpaidAmount
            //dbc.con1.Close();
            //dbc.con1.Open();
            //MySql.Data.MySqlClient.MySqlCommand cmdaw = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT  CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) AS Flat, tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo,  DATE_FORMAT(tblinvoice.varDateTime, '%d-%m-%Y') AS Date,sum(tblinvoice.varTotal) AS UnpaidAmount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  tblinvoiceforpersonnels.varPaymentStatus AS PaymentStatus, tblinvoiceforpersonnels.varPersonnelId       FROM            tblinvoice INNER JOIN   tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where    tblinvoiceforpersonnels.varPaymentStatus='Pending'", dbc.con1);

            //dbc.dr = cmdaw.ExecuteReader();
            //if (dbc.dr.Read())
            //{
            //    lblunpaid.Text = string.IsNullOrEmpty(dbc.dr["UnpaidAmount"].ToString()) ? "0" : dbc.dr["UnpaidAmount"].ToString();
            //}
            //dbc.con1.Close();
            //dbc.dr.Dispose();

            ////totalinvoice
            //dbc.con1.Close();
            //dbc.con1.Open();
            //MySql.Data.MySqlClient.MySqlCommand cmdajinvo = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(intId) as totalinvoice FROM tblinvoiceforpersonnels  ", dbc.con1);

            //dbc.dr = cmdajinvo.ExecuteReader();
            //if (dbc.dr.Read())
            //{
            //    lbltotalinvoices.Text = string.IsNullOrEmpty(dbc.dr["totalinvoice"].ToString()) ? "0" : dbc.dr["totalinvoice"].ToString();
            //}
            //dbc.con1.Close();
            //dbc.dr.Dispose();

            ////newvisitor
            //dbc.con1.Close();
            //dbc.con1.Open();
            //MySql.Data.MySqlClient.MySqlCommand cmdprq = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId) as newvisitor, CONCAT(FirstName, ' ', LastName) AS Name, ContactNumber, Email, VehicleNo, ArrivedFrom, InTime, OutTime, PurposeOFVisit, Comments, CreatedDate, IsActive FROM visitors  ", dbc.con1);
            //dbc.dr = cmdprq.ExecuteReader();
            //if (dbc.dr.Read())
            //{
            //    lblVisitor.Text = string.IsNullOrEmpty(dbc.dr["newvisitor"].ToString()) ? "0" : dbc.dr["newvisitor"].ToString();
            //}
            //dbc.con1.Close();
            //dbc.dr.Dispose();

            ////totalmember document
            //dbc.con1.Close();
            //dbc.con1.Open();
            //MySql.Data.MySqlClient.MySqlCommand cmdajdoc = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT COUNT( DISTINCT varPersonnelId) as totalmemberdoc FROM tbldocuments where intIsActive=1 ", dbc.con1);

            //dbc.dr = cmdajdoc.ExecuteReader();
            //if (dbc.dr.Read())
            //{
            //    lbldocument.Text = string.IsNullOrEmpty(dbc.dr["totalmemberdoc"].ToString()) ? "0" : dbc.dr["totalmemberdoc"].ToString();
            //}
            //dbc.con1.Close();
            //dbc.dr.Dispose();

        }
        catch (Exception ex)
        {
            dbc.con1.Close();
            //dbc.dr.Dispose();
            string exp = ex.Message;
        }

    }
}