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
using System.Globalization;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;
using System.Net.Mail;
using System.Net;

public partial class SK_View_fullSocietyDetails : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();
    static string oldUsername = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Cache["SocietyProfile"] == null)
        {
            Response.Redirect("~/SK/View/Viewsociety.aspx", false);
        }
        else if (!IsPostBack)
        {
            getPersonalDetails();
            getVendorSummary();
        }

    }

    public void getVendorSummary()
    {
        DataTable dtInvoice = new DataTable();

        DataColumn ServiceName = new DataColumn("ServiceName");
        ServiceName.DataType = System.Type.GetType("System.String");
        dtInvoice.Columns.Add(ServiceName);

        DataColumn Vendors = new DataColumn("Vendors");
        Vendors.DataType = System.Type.GetType("System.Int64");
        dtInvoice.Columns.Add(Vendors); 
    
        dbc.con.Open();
        dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intSocietyId, varEmpName, varPrimaryEmail FROM tblsocietypersonnel WHERE (intSocietyId = '" + Cache["SocietyProfile"].ToString() + "')", dbc.con);
        dbc.dr = dbc.cmd.ExecuteReader();
        while (dbc.dr.Read())
        {
            dbcs.con.Open();
            dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(tblorder.intOrderId) AS Vendors, tblvendorservices.varName AS ServiceName FROM tblorder INNER JOIN tblcustomer ON tblorder.intCustId = tblcustomer.intId INNER JOIN tblvendorservices ON tblorder.intServiceID = tblvendorservices.intServiceCode WHERE (tblcustomer.varEmail = '" + dbc.dr["varPrimaryEmail"].ToString() + "') GROUP BY tblorder.intServiceID", dbcs.con);
            dbcs.dr = dbcs.cmd.ExecuteReader();
            while (dbcs.dr.Read())
            {
                dtInvoice.Rows.Add(dbcs.dr["ServiceName"].ToString(), dbcs.dr["Vendors"].ToString());
            }
            dbcs.con.Close();
        }
        dbc.con.Close();

        dbc.con.Open();
        dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT varPropertyId, varName, varEmail, varSocietyId FROM tblproperty WHERE (varSocietyId  = '" + Cache["SocietyProfile"].ToString() + "')", dbc.con);
        dbc.dr = dbc.cmd.ExecuteReader();
        while (dbc.dr.Read())
        {
            dbcs.con.Open();
            dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT COUNT(tblorder.intOrderId) AS Vendors, tblvendorservices.varName AS ServiceName FROM tblorder INNER JOIN tblcustomer ON tblorder.intCustId = tblcustomer.intId INNER JOIN tblvendorservices ON tblorder.intServiceID = tblvendorservices.intServiceCode WHERE (tblcustomer.varEmail = '" + dbc.dr["varEmail"].ToString() + "') GROUP BY tblorder.intServiceID", dbcs.con);
            dbcs.dr = dbcs.cmd.ExecuteReader();
            while (dbcs.dr.Read())
            {
                dtInvoice.Rows.Add(dbcs.dr["ServiceName"].ToString(), dbcs.dr["Vendors"].ToString());
            }
            dbcs.con.Close();
        }
        dbc.con.Close();


        var result = dtInvoice.AsEnumerable()
       .GroupBy(x => x.Field<string>("ServiceName"))
       .Select(g => new { ID = g.Key, Amount = g.Sum(z => z.Field<Int64>("Vendors")) });

        DataTable t2 = dtInvoice.Clone();

        foreach (var grp in result)
            t2.Rows.Add(grp.ID, grp.Amount);

        lstVendorSummary.DataSource = t2;
        lstVendorSummary.DataBind();
    }

    public void getPersonalDetails()
    {
        try
        {
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT   countrymaster.CountryName, statemaster.StateName, citymaster.CityName, tblsocietyinfo.intId, tblsocietyinfo.intSocietyCode, tblsocietyinfo.varRegistrationNo,    tblsocietyinfo.varName, tblsocietyinfo.varSAddress, tblsocietyinfo.varSPhone, tblsocietyinfo.varSMobile, tblsocietyinfo.varSEmail, tblsocietyinfo.varSFax,       tblsocietyinfo.varPin, tblsocietyinfo.varConstructedby, tblsocietyinfo.varCompany, tblsocietyinfo.varCompanyAddress, tblsocietyinfo.varContactPerson,     tblsocietyinfo.varContactMobile, tblsocietyinfo.varContactPhone, tblsocietyinfo.varContactEmail, tblsocietyinfo.varConstuctionYear, tblsocietyinfo.varTotalArea,    tblsocietyinfo.varTotalWings, tblsocietyinfo.varIsActive FROM            tblsocietyinfo INNER JOIN     countrymaster ON tblsocietyinfo.varCountryId = countrymaster.CountryId INNER JOIN     statemaster ON tblsocietyinfo.varStateId = statemaster.StateId INNER JOIN        citymaster ON tblsocietyinfo.varCityId = citymaster.CityId WHERE        tblsocietyinfo.intSocietyCode ='" + Cache["SocietyProfile"].ToString() + "'", dbc.con);


            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {//Society info
                lblssRegistrationno.Text = dbc.dr["varRegistrationNo"].ToString();

                lblSSSocietyname.Text = dbc.dr["varName"].ToString();
                lblssMobileNo.Text = dbc.dr["varSMobile"].ToString();
                lblssPhone.Text = dbc.dr["varSPhone"].ToString();
                lblssemailid.Text = dbc.dr["varSEmail"].ToString();
                lblssfax.Text = dbc.dr["varSFax"].ToString();
                //lblssarea.Text = dbc.dr["varTotalArea"].ToString();
                //lblssswing.Text = dbc.dr["varTotalWings"].ToString();
                lblssaddress.Text = dbc.dr["varSAddress"].ToString();


                lblsscounty.Text = dbc.dr["CountryName"].ToString();
                lblssstate.Text = dbc.dr["StateName"].ToString();
                lblssscity.Text = dbc.dr["CityName"].ToString();

                //society admin info
                lblcFullName.Text = dbc.dr["varContactPerson"].ToString();
                lblcMobile.Text = dbc.dr["varContactMobile"].ToString();
                //  varEmpPoliceVerify varMaritalStatus varFatherHusband varSpouseName varDateOfJoin varDOB varPANNo, varPFNo, varESINo, intCountry, intState, intCity, varPin,
                //varPermanentAddress
                lblcphone.Text = dbc.dr["varContactPhone"].ToString();
                lblcEmail.Text = dbc.dr["varContactEmail"].ToString();

            }
            dbc.con.Close();

            dbc.con.Open();
            cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT * FROM (SELECT SUM(tblinvoice.varTotal) AS total, tblinvoiceforpersonnels.varInvoiceId as invId FROM tblinvoice INNER JOIN tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId WHERE (tblinvoiceforpersonnels.varSocietyId = '" + Cache["SocietyProfile"].ToString() + "') GROUP BY tblinvoiceforpersonnels.varInvoiceId WITH ROLLUP ) A WHERE ISNULL(invId)", dbc.con);


            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblAccountSumary.Text = dbc.dr["total"].ToString();
            }
            dbc.con.Close();

        }
        catch (Exception ex)
        {
            dbc.con1.Close();
            string exp = ex.Message;
        }
    }
}