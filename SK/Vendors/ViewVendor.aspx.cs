using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Configuration;
using MySql.Data.MySqlClient;
using System.Web.Services;

public partial class SK_Vendors_ViewVendor : ClsVendor
{
    string datef, datet;
    MySql.Data.MySqlClient.MySqlCommand cmd, cmd1;
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();RegexUtilities rex = new RegexUtilities();
    static string EditVendorId = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           getVendorGridData();
          
        }  
          
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

        this.getVendorGridData();
    }
    public void getVendorGridData()
    {
        try
        {
            //lstVendors.DataSource = FetchVendor();
            //lstVendors.DataBind();
            DataTable dt = new DataTable();
            dbcs.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblvendor.varName AS Name, tblvendor.varContactPerson AS `Contact Person`, tblvendorabout.varAbout AS `About Us`, tblvendordescription.varCharges AS Charges, tblvendordescription.varDescription AS Description, tblvendorservices.varName AS `Service Name`, tblvendorabout.varImage AS varImage,   tblvendor.varPhoneNo AS `Ph no`, tblvendor.varMobileNo AS Mobile, tblvendor.varEmailId AS Email, tblvendor.varAddress AS Address,tblvendor.varNeighbourhood AS Neighbourhood, tblvendor.varPincode AS PIN, tblvendor.varIsActive, citymaster.CityName, countrymaster.CountryName, statemaster.StateName, tblvendor.intId, tblvendor.intVendorCode  from  tblvendor INNER JOIN tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN    tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN    tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode INNER JOIN  citymaster ON tblvendor.varCity = citymaster.CityId INNER JOIN   countrymaster ON tblvendor.varCountry = countrymaster.CountryId INNER JOIN    statemaster ON tblvendor.varState = statemaster.StateId  order BY tblvendor.intId desc", dbcs.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            lstVendors.DataSource = dt;
            lstVendors.DataBind();
            dbcs.con.Close();

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void lstVendors_ItemCommand(object sender, ListViewCommandEventArgs e)
    {//string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
        //string id = commandArgs[0];
        //string stat = commandArgs[1];
        try
        {
            int claasifiedintid = Convert.ToInt32(e.CommandArgument.ToString());
            Cache["Vendorintid"] = Convert.ToInt32(e.CommandArgument.ToString());
            if (e.CommandName == "Views")
            {
                Cache["Vendorintid"] = e.CommandArgument.ToString();
                Response.Redirect("~/SK/Vendors/FullVendorDetails.aspx", false);
            }
            else if (e.CommandName == "active")
            {
                dbcs.update_tblvendorBySKAdmin(Convert.ToInt32(e.CommandArgument.ToString()), 1);
            }
            else if (e.CommandName == "inactive")
            {
                dbcs.update_tblvendorBySKAdmin(Convert.ToInt32(e.CommandArgument.ToString()), 0);
            }
            getVendorGridData();

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }

    }

    public void getListViewMasterDataRadio(string wherecondition)
    {
        try
        {
            DataTable dt = new DataTable();
            dbcs.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT  DISTINCT      tblvendor.varName AS Name, tblvendor.varContactPerson AS `Contact Person`, tblvendorabout.varAbout AS `About Us`, tblvendordescription.varCharges AS Charges, tblvendordescription.varDescription AS Description, tblvendorservices.varName AS `Service Name`, tblvendorabout.varImage AS varImage,   tblvendor.varPhoneNo AS `Ph no`, tblvendor.varMobileNo AS Mobile, tblvendor.varEmailId AS Email, tblvendor.varAddress AS Address,tblvendor.varNeighbourhood AS Neighbourhood, tblvendor.varPincode AS PIN, tblvendor.varIsActive, citymaster.CityName, countrymaster.CountryName, statemaster.StateName, tblvendor.intId, tblvendor.intVendorCode  from tblvendor INNER JOIN tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN    tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN    tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode INNER JOIN  citymaster ON tblvendor.varCity = citymaster.CityId INNER JOIN   countrymaster ON tblvendor.varCountry = countrymaster.CountryId INNER JOIN    statemaster ON tblvendor.varState = statemaster.StateId  " + wherecondition + "", dbcs.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            lstVendors.DataSource = dt;
            lstVendors.DataBind();
            dbcs.con.Close();


        }
        catch (Exception ex)
        {
            // cmd.Dispose();
            dbcs.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }

    protected void rgbName_CheckedChanged(object sender, EventArgs e)
    {
        if (rgbName.Checked == true)
        {
        
            divnamesearch.Visible = true;
            divservicesearch.Visible = false;
            divCity.Visible = false; 
            divRating.Visible = false;
        }
        else if (rgbservice.Checked == true)
        {
            divservicesearch.Visible = true;
            divnamesearch.Visible = false;
            divCity.Visible = false;
            divRating.Visible = false;
        }
        else if (rgblocation.Checked == true)
        {
            divCity.Visible = true;
            divservicesearch.Visible = false;
            divnamesearch.Visible = false;
            divRating.Visible = false;
        }
        else if (rgbrating.Checked == true)
        {
            divRating.Visible = true;
            divservicesearch.Visible = false;
            divnamesearch.Visible = false;
            divCity.Visible = false;
        }
        else
        {
            divRating.Visible = false;
            divCity.Visible = false;
            divnamesearch.Visible = false;
            divservicesearch.Visible = false;
            getVendorGridData();
        }
    }

    //search by text value
    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static List<string> GetCompletionList(string prefixText, int count, string contextKey)
    {
        String connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringServices"].ConnectionString;

        MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(connStr);
        con.Open();
        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT  distinct      tblvendor.varName AS Name, tblvendor.varContactPerson AS `Contact Person`, tblvendorabout.varAbout AS `About Us`, tblvendordescription.varCharges AS Charges, tblvendordescription.varDescription AS Description, tblvendorservices.varName AS `Service Name`, tblvendorabout.varImage AS varImage,   tblvendor.varPhoneNo AS `Ph no`, tblvendor.varMobileNo AS Mobile, tblvendor.varEmailId AS Email, tblvendor.varAddress AS Address,tblvendor.varNeighbourhood AS Neighbourhood, tblvendor.varPincode AS PIN, tblvendor.varIsActive, citymaster.CityName, countrymaster.CountryName, statemaster.StateName, tblvendor.intId, tblvendor.intVendorCode from   tblvendor INNER JOIN tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN    tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN    tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode INNER JOIN  citymaster ON tblvendor.varCity = citymaster.CityId INNER JOIN   countrymaster ON tblvendor.varCountry = countrymaster.CountryId INNER JOIN    statemaster ON tblvendor.varState = statemaster.StateId where  tblvendor.varName like '%" + prefixText + "%'", con);
        //     cmd.Parameters.AddWithValue("@Name", prefixText);
        MySql.Data.MySqlClient.MySqlDataAdapter da = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        int j = 0;
        List<string> CompanyName = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            CompanyName.Add(dt.Rows[i][0].ToString());
            //  CompanyName[j++] =dt.Rows[i][0].ToString();
        }
        con.Close();
        return CompanyName;
    }

    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static List<string> GetCompletionListService(string prefixText, int count, string contextKey)
    {
        String connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringServices"].ConnectionString;

        MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(connStr);
        con.Open();
        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT  distinct      tblvendor.varName AS Name, tblvendor.varContactPerson AS `Contact Person`, tblvendorabout.varAbout AS `About Us`, tblvendordescription.varCharges AS Charges, tblvendordescription.varDescription AS Description, tblvendorservices.varName AS `Service Name`, tblvendorabout.varImage AS varImage,   tblvendor.varPhoneNo AS `Ph no`, tblvendor.varMobileNo AS Mobile, tblvendor.varEmailId AS Email, tblvendor.varAddress AS Address,tblvendor.varNeighbourhood AS Neighbourhood, tblvendor.varPincode AS PIN, tblvendor.varIsActive, citymaster.CityName, countrymaster.CountryName, statemaster.StateName, tblvendor.intId, tblvendor.intVendorCode from  tblvendor INNER JOIN tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN    tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN    tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode INNER JOIN  citymaster ON tblvendor.varCity = citymaster.CityId INNER JOIN   countrymaster ON tblvendor.varCountry = countrymaster.CountryId INNER JOIN    statemaster ON tblvendor.varState = statemaster.StateId where  tblvendorservices.varName like '%" + prefixText + "%'", con);
        //     cmd.Parameters.AddWithValue("@Name", prefixText);
        MySql.Data.MySqlClient.MySqlDataAdapter da = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        int j = 0;
        List<string> CompanyName = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            CompanyName.Add(dt.Rows[i][5].ToString());
            //  CompanyName[j++] =dt.Rows[i][0].ToString();
        }
        con.Close();
        return CompanyName;
    }
    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static List<string> GetCompletionListCity(string prefixText, int count, string contextKey)
    {
        String connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringServices"].ConnectionString;

        MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(connStr);
        con.Open();
        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT distinct citymaster.CityName from  tblvendor INNER JOIN tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN    tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN    tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode INNER JOIN  citymaster ON tblvendor.varCity = citymaster.CityId INNER JOIN   countrymaster ON tblvendor.varCountry = countrymaster.CountryId INNER JOIN    statemaster ON tblvendor.varState = statemaster.StateId where  citymaster.CityName like '%" + prefixText + "%'", con);
        //     cmd.Parameters.AddWithValue("@Name", prefixText);
        MySql.Data.MySqlClient.MySqlDataAdapter da = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        int j = 0;
        List<string> CompanyName = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            CompanyName.Add(dt.Rows[i][0].ToString());
            //  CompanyName[j++] =dt.Rows[i][0].ToString();
        }
        con.Close();
        return CompanyName;
    }

    protected void btnNamesearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtVendorName.Text == "")
            {
                ScriptManager.RegisterStartupScript(
                          this,
                          this.GetType(),
                          "MessageBox",
                           "alert('Please Enter  Name....');", true);
            }
            else
            {
                getListViewMasterDataRadio("where  tblvendor.varName = '" + txtVendorName.Text.Replace("'", "\\'") +"' ");
                txtVendorName.Text = "";
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void btnservice_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtservice.Text == "")
            {
                ScriptManager.RegisterStartupScript(
                          this,
                          this.GetType(),
                          "MessageBox",
                           "alert('Please Enter  Service....');", true);
            }
            else
            {
                getListViewMasterDataRadio("where tblvendorservices.varName = '" + txtservice.Text.Replace("'", "\\'") +"' ");
                txtservice.Text = "";
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void btncity_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtcity.Text == "")
            {
                ScriptManager.RegisterStartupScript(
                          this,
                          this.GetType(),
                          "MessageBox",
                           "alert('Please Enter  Service....');", true);
            }
            else
            {
                getListViewMasterDataRadio("where  citymaster.CityName = '" + txtcity.Text.Replace("'", "\\'") +"' ");
                txtcity.Text = "";
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void btnRating_Click(object sender, EventArgs e)
    { 
        getListViewMasterDataRadio("INNER JOIN  tblreviews ON tblvendor.intVendorCode = tblreviews.varVendorId WHERE (tblreviews.intOrderId <> '0') and (SELECT CAST(AVG(tblreviews.intRating) as DECIMAL(0)) FROM  tblvendor INNER JOIN  tblreviews ON tblvendor.intVendorCode = tblreviews.varVendorId INNER JOIN  tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN  tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN  tblvendorabout ON tblvendor.intId = tblvendorabout.intId)=" + ddlRating.SelectedValue + "");
    }
}