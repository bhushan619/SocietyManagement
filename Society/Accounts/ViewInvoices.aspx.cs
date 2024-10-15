using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Collections.Generic;
using System.IO;
using System.Net.Mail;
using System.Net;
using System.Globalization;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;

public partial class Society_Accounts_ViewInvoices : System.Web.UI.Page
{

    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
            getLoadData();
        }
        
    }
    public void getLoadData()
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
        da = new MySqlCommand("SELECT tblproperty.varName AS name, CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) AS address, DATE_FORMAT(tblinvoice.varDateTime,'%d-%m-%Y') AS dat, tblinvoiceforpersonnels.varOutstanding, tblinvoice.varTotal, tblinvoice.varInvoiceId, tblinvoiceforpersonnels.varPersonnelId FROM tblproperty INNER JOIN tblinvoiceforpersonnels ON tblproperty.varPropertyId = tblinvoiceforpersonnels.varPersonnelId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId INNER JOIN tblinvoice ON tblinvoiceforpersonnels.varInvoiceId = tblinvoice.varInvoiceId WHERE  (tblproperty.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') AND  (tblinvoice.varInvoiceId = '" + Cache["InvoiceId"].ToString() + "') AND(tblinvoiceforpersonnels.varPersonnelId = '" + Cache["PersonnelId"].ToString() + "')", dbc.con);
        dbc.dr1 = da.ExecuteReader();
        if (dbc.dr1.Read())
        {
            lblPropertyOwner.Text = dbc.dr1["name"].ToString();
            lblPropertyAddress.Text = dbc.dr1["address"].ToString(); 
            lblDate.Text = dbc.dr1["dat"].ToString();
            lblSubBill.Text = dbc.dr1["varTotal"].ToString();
            lblFinalBill.Text = dbc.dr1["varTotal"].ToString();
        }
        dbc.con.Close();
        dbc.dr1.Dispose();

        dbc.con.Close();
        dbc.con.Open();
        MySqlDataAdapter adp = new MySqlDataAdapter("SELECT varParticulars as Particulars, varAmount as Amount, varInvoiceId FROM tblinvoicedetails WHERE(varInvoiceId = '" + Cache["InvoiceId"].ToString() + "')", dbc.con);
        DataSet dtInvoice= new DataSet();
        adp.Fill(dtInvoice); 
        lstInvoiceDetails.DataSource = dtInvoice;
        lstInvoiceDetails.DataBind();
        dbc.con.Close();
        dbc.dr1.Dispose(); 
    } 
}