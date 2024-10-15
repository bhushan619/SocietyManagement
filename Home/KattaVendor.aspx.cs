using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

public partial class Home_KattaVendor : BaseClass
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lnkSearch_Click(object sender, EventArgs e)
    {
        Cache["City"] = ddlLocation.SelectedValue;
        Cache["ServiceCode"] = ddlService.SelectedValue;
        Cache["Area"] = ddlArea.SelectedValue;
        Response.Redirect("~/Home/KattaVendorList.aspx", false);
    }
    protected void lstVendors_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Cache["City"] = 345;
        Cache["ServiceCode"] = e.CommandArgument;
        Cache["Area"] = "Pune";
        Response.Redirect("~/Home/KattaVendorList.aspx", false);
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
        }
    }
}