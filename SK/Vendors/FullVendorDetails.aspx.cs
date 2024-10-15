using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SK_Vendors_FullVendorDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Cache["Vendorintid"] != null)
            {
                SqlDataSourceVendorList.SelectCommand = "SELECT DISTINCT tblvendor.varName,CAST(AVG(tblreviews.intRating) as DECIMAL(0)) as intRating, CAST(AVG(tblreviews.intOnTime) as DECIMAL(0)) as intOnTime, CAST(AVG(tblreviews.intQuality) as DECIMAL(0)) as intQuality, tblvendordescription.varDescription, tblvendor.intVendorCode,  tblvendorofferedservices.intServiceId, tblvendorabout.varAbout, tblvendorabout.varImage,tblvendordescription.varCharges  FROM  tblvendor INNER JOIN  tblreviews ON tblvendor.intVendorCode = tblreviews.varVendorId INNER JOIN  tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN  tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN  tblvendorabout ON tblvendor.intId = tblvendorabout.intId   WHERE (tblvendor.intid = '" + Cache["Vendorintid"] + "')";
                SqlDataSource1.SelectCommand = "SELECT tblreviews.intRating, tblreviews.varReview, tblreviews.intOnTime, tblreviews.intQuality, tblcustomer.varName, tblvendor.intVendorCode, tblreviews.intOrderId FROM tblvendor INNER JOIN tblcustomer ON tblvendor.intId = tblcustomer.intId INNER JOIN tblreviews ON tblcustomer.intId = tblreviews.varCustomerId WHERE (tblreviews.intOrderId <> '0') AND (tblvendor.intid = '" + Cache["Vendorintid"] + "')";
            }
            else
            {
                Response.Redirect("~/SK/Vendors/ViewVendor.aspx", false);
            }
        }
    }
}