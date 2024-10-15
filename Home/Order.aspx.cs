using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_Order : BaseClass
{
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();RegexUtilities rex = new RegexUtilities();
    DatabaseConnection dbc = new DatabaseConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["CookieCustomerEmail"] == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "message", "alert('Sorry..!! You must login as Services User to use this feature..!!');location.href = '../Society/Logout.aspx';", true);
                //Response.Redirect("~/Society/Logout.aspx", false); 
            }
            else
            {
                string query = "SELECT tblvendor.varName, CAST(AVG(tblreviews.intRating) as DECIMAL(0)) as intRating, CAST(AVG(tblreviews.intOnTime) as DECIMAL(0)) as intOnTime, CAST(AVG(tblreviews.intQuality) as DECIMAL(0)) as intQuality, tblvendordescription.varDescription, tblvendor.intVendorCode, ";
                query += " tblvendorofferedservices.intServiceId, tblvendorabout.varAbout, tblvendorabout.varImage, tblvendordescription.varCharges, tblvendorservices.varName AS serName ";               
                query += " FROM tblvendor INNER JOIN ";
                query += " tblreviews ON tblvendor.intVendorCode = tblreviews.varVendorId INNER JOIN ";
                query += " tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN ";
                query += " tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER  JOIN ";
                query += " tblvendorabout ON tblvendor.intId = tblvendorabout.intId INNER JOIN ";
                query += " tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode ";
                query += "WHERE (tblvendor.intVendorCode = '" + Cache["VendorCode"] + "') AND (tblvendorofferedservices.intServiceId = " + Cache["ServiceCode"] + ") ";
                SqlDataSourceServiceByCode.SelectCommand = query;
                getCountryData();
                getCustomerData();

                
            }
        }
    }
    public void getCustomerData()
    {
        try
        {
            dbcs.con.Close();
            MySql.Data.MySqlClient.MySqlCommand cmdej = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varName, varMobile, varMobileVerify, varEmail, varEmailVerify,varPassword, varAddress, varLandline, varLandmark, varCountry, varState, varCity, varNeighbourhood, varStatus, imgImage, ex1, ex2, ex3 FROM tblcustomer WHERE varEmail='" + rex.DecryptString(Request.Cookies["CookieCustomerEmail"].Value) + "'", dbcs.con);
            dbcs.con.Open();
            dbcs.dr = cmdej.ExecuteReader();
            if (dbcs.dr.Read())
            {
                txtName.Text = dbcs.dr["varName"].ToString();
                txtEmail.Text = dbcs.dr["varEmail"].ToString();
                txtMobile.Text = dbcs.dr["varMobile"].ToString();
                txtAddress.Text = dbcs.dr["varAddress"].ToString();
                txtLandmark.Text = dbcs.dr["varLandmark"].ToString();
                ddlCountry.SelectedValue = dbcs.dr["varCountry"].ToString();
                getStateFromCountry(dbcs.dr["varCountry"].ToString());
                ddlState.SelectedValue = dbcs.dr["varState"].ToString();
                getCityFromState(dbcs.dr["varState"].ToString());
                ddlCity.SelectedValue = dbcs.dr["varCity"].ToString();
            }
            dbcs.con.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    public void getCountryData()
    {
        try
        {
            ddlCountry.DataSource = dbc.GetCountryMasterData();
            ddlCountry.DataTextField = "CountryName";
            ddlCountry.DataValueField = "CountryId";
            ddlCountry.DataBind();
            ddlCountry.Items.Insert(0, new ListItem(":: Select Country ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }


    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            getCityFromState(ddlState.SelectedValue);
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    public void getCityFromState(string stateid)
    {
        ddlCity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(stateid));
        ddlCity.DataTextField = "CityName";
        ddlCity.DataValueField = "CityId";
        ddlCity.DataBind();
        ddlCity.Items.Insert(0, new ListItem(":: Select City ::", ""));
    }
    public void getStateFromCountry(string countryid)
    {
        ddlState.DataSource = dbc.GetstateMasterDataFromCountryId(Convert.ToInt32(countryid));
        ddlState.DataTextField = "StateName";
        ddlState.DataValueField = "StateId";
        ddlState.DataBind();
        ddlState.Items.Insert(0, new ListItem(":: Select State ::", ""));
    }
    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            getStateFromCountry(ddlCountry.SelectedValue);
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void btnPayment_Click(object sender, EventArgs e)
    {
        //Cache["City1"] = ddlLocation.SelectedValue;
        //Cache["ServiceCode"] = ddlService.SelectedValue;
        Cache["Date"] = txtDOB.Text;
        Cache["Time"] = ddlTime.SelectedItem;

        dbcs.con.Open();
        dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblcustomer SET   varAddress='" + txtAddress.Text.Replace("'", "\\'") +"',varLandmark='" + txtLandmark.Text.Replace("'", "\\'") +"',varCountry='" + ddlCountry.SelectedValue + "',varState='" + ddlState.SelectedValue + "',varCity='" + ddlCity.SelectedValue + "' WHERE varEmail='" + rex.DecryptString(Request.Cookies["CookieCustomerEmail"].Value) + "'", dbcs.con);
        dbcs.cmd.ExecuteNonQuery();
        dbcs.con.Close();


        Response.Redirect("~/Home/OrderSummery.aspx", false);
    }
}