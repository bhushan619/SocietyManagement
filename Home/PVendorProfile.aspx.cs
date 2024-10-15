using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_PVendorProfile : BaseClass
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Cache["VendorCode"] != null)
            {
                string query = "SELECT tblvendor.varName,CAST(AVG(tblreviews.intRating) as DECIMAL(0)) as intRating, CAST(AVG(tblreviews.intOnTime) as DECIMAL(0)) as intOnTime, CAST(AVG(tblreviews.intQuality) as DECIMAL(0)) as intQuality,tblreviews.ex1 as Date, tblvendordescription.varDescription, tblvendor.intVendorCode, ";
                query += " tblvendorofferedservices.intServiceId, tblvendorabout.varAbout, tblvendorabout.varImage,tblvendordescription.varCharges ";
                query += " FROM  tblvendor INNER JOIN ";
                query += " tblreviews ON tblvendor.intVendorCode = tblreviews.varVendorId INNER JOIN ";
                query += " tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN ";
                query += " tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN ";
                query += " tblvendorabout ON tblvendor.intId = tblvendorabout.intId ";
                query += "  WHERE (tblvendor.intVendorCode = '" + Cache["VendorCode"] + "')";
                SqlDataSourceVendorList.SelectCommand = query;

                SqlDataSource1.SelectCommand = "SELECT tblreviews.varReview, CAST(AVG(tblreviews.intRating) as DECIMAL(0)) as intRating, CAST(AVG(tblreviews.intOnTime) as DECIMAL(0)) as intOnTime, CAST(AVG(tblreviews.intQuality) as DECIMAL(0)) as intQuality, date_format(tblreviews.ex1,'%M %e, %Y') as Date, tblcustomer.varName, tblcustomer.imgImage, tblvendor.intVendorCode, tblreviews.intOrderId FROM tblvendor INNER JOIN tblcustomer ON tblvendor.intId = tblcustomer.intId INNER JOIN tblreviews ON tblcustomer.intId = tblreviews.varCustomerId WHERE (tblreviews.intOrderId <> '0') AND (tblreviews.varVendorId = '" + Cache["VendorCode"].ToString() + "') group by tblreviews.varVendorId";
             }
            else
            {
                Response.Redirect("~/Home/KattaVendor.aspx", false);
            }
        }
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ':' }); ;
        Cache["ServiceCode"] = commandArgs[1];
        Cache["VendorCode"] = commandArgs[0];
        if (e.CommandName == "Book")
        {
            Response.Redirect("~/Home/Order.aspx", false);
        }
        else if (e.CommandName == "Back")
        {
            Response.Redirect("~/Home/KattaVendor.aspx", false);
        }
    }
}