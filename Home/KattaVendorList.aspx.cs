using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Data;

public partial class Home_KattaVendorList : BaseClass
{
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();RegexUtilities rex = new RegexUtilities();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Cache["City"] == null)
        {
            Response.Redirect("~/Home/KattaVendor.aspx", false);
        }
        else if (!IsPostBack)
        {
            ddlLocation.SelectedValue = Cache["City"].ToString();
            ddlService.DataBind();
            ddlService.SelectedValue = Cache["ServiceCode"].ToString();
             
            getVendorData(ddlService.SelectedValue, Cache["City"].ToString());
            getArea(Cache["City"].ToString());
            ddlArea.SelectedValue = Cache["Area"].ToString();
        }
    }
    protected void lnkSearch_Click(object sender, EventArgs e)
    {
        
            getVendorData(ddlService.SelectedValue, ddlLocation.SelectedValue);
          
    }
    public void getVendorData(string serviceId,string cityid)
    {
        try
        {
            vendorlisting.Visible = true;
            DataTable dt = new DataTable();

            string query = "SELECT tblvendor.varName,CAST(AVG(tblreviews.intRating) as DECIMAL(0)) as intRating, CAST(AVG(tblreviews.intOnTime) as DECIMAL(0)) as intOnTime, CAST(AVG(tblreviews.intQuality) as DECIMAL(0)) as intQuality, tblvendordescription.varDescription, tblvendor.intVendorCode, ";
            query += " tblvendorofferedservices.intServiceId, tblvendorabout.varAbout, tblvendorabout.varImage,tblvendordescription.varCharges ";
            query += " FROM  tblvendor INNER JOIN ";
            query += " tblreviews ON tblvendor.intVendorCode = tblreviews.varVendorId INNER JOIN ";
            query += " tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN ";
            query += " tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN ";
            query += " tblvendorabout ON tblvendor.intId = tblvendorabout.intId ";
            query += "  WHERE tblvendor.varIsActive = 1 AND (tblvendorofferedservices.intServiceId = " + serviceId + ") AND (tblvendor.varCity = " + cityid + ")";
            query += " group by tblvendor.intVendorCode";
            dbcs.dataAdapter = new MySql.Data.MySqlClient.MySqlDataAdapter(query, dbcs.con);
            dbcs.dataAdapter.Fill(dt);

          
                lstVendors.DataSource = dt;
                lstVendors.DataBind();
            
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
         //   MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }

    }
    protected void lstVendors_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ':' }); ;
        
        Cache["VendorCode"] = commandArgs[0];
        Cache["ServiceCode"] = commandArgs[1];
        Cache["City"] = ddlLocation.SelectedValue; 
       
        if (e.CommandName == "ViewVendor")
        {
            Response.Redirect("~/Home/PVendorProfile.aspx", false);
        }
        else if (e.CommandName == "Book")
        {
            Response.Redirect("~/Home/Order.aspx", false);
        }
    }
    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlArea.Items.Clear();
        ddlArea.Items.Add(":: Select Area ::");
        ddlArea.Items[0].Value = "";

        if (ddlLocation.SelectedIndex == 0)
        {
        }
        else
        {
            SqlDataSourceArea.SelectCommand = "SELECT DISTINCT tblvendor.varNeighbourhood AS Area FROM tblvendor INNER JOIN citymaster ON tblvendor.varCity = citymaster.CityId WHERE (citymaster.CityId = " + ddlLocation.SelectedValue + ")";
            ddlArea.DataBind();
        }
    }

    public void getArea(string loc)
    {
        SqlDataSourceArea.SelectCommand = "SELECT DISTINCT tblvendor.varNeighbourhood AS Area FROM tblvendor INNER JOIN citymaster ON tblvendor.varCity = citymaster.CityId WHERE (citymaster.CityId = " + loc + ")";
    }
}