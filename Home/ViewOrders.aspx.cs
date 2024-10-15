using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_ViewOrders : BaseClass
{
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
       

        if (Request.Cookies["CookieCustomerEmail"] != null)
        { string query = "SELECT        tblorder.intOrderId AS OrderId, tblorder.varVendorId AS VendorId, DATE_FORMAT( tblorder.varOrderCreatedDate,'%d %b, %y') AS CreatedDate,  DATE_FORMAT(tblorder.varOrderDate,'%d %b, %y')  AS OrderDate, ";
        query += "   tblorder.varOrderTime AS OrderTime, tblorder.varAddress AS Address, tblorder.varAmount AS FeesAmount, tblorder.varRecieved AS Recieved, ";
        query += "     tblorder.varPaymentStatus AS `Payment Status`, tblorder.varTransactionId AS TransactionID, tblorder.varTransactionStatus AS TransactionStatus, ";
        query += "    tblorder.varPaymode AS Paymode, tblorder.varOrderStatus AS OrderStatus, tblvendor.intVendorCode AS VendorCode, tblvendor.varName AS VendorName, ";
        query += "      tblvendor.varContactPerson, tblvendor.varPhoneNo, tblvendor.varMobileNo, tblvendor.varEmailId AS VendorEmail, tblcustomer.varName AS CustomerName, ";
        query += "    tblcustomer.varMobile AS CustomerMobile, tblcustomer.varEmail AS CustomerEmail, tblvendorabout.varImage AS VendorImage, ";
        query += "   tblvendorservices.varName AS ServiceName, tblvendorservices.varDescription AS ServiceDescription, countrymaster.CountryName, citymaster.CityName, ";
        query += "  statemaster.StateName";
        query += " FROM            tblorder INNER JOIN";
        query += "                tblvendor ON tblorder.varVendorId = tblvendor.intVendorCode INNER JOIN";
        query += "      tblcustomer ON tblorder.intCustId = tblcustomer.intId INNER JOIN";
        query += "      tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN";
        query += "     tblvendorservices ON tblorder.intServiceID = tblvendorservices.intServiceCode INNER JOIN";
        query += "     countrymaster ON tblorder.intCountryId = countrymaster.CountryId INNER JOIN";
        query += "      citymaster ON tblorder.intCityId = citymaster.CityId INNER JOIN";
            query += "     statemaster ON tblorder.intStateId = statemaster.StateId where tblcustomer.varEmail='" + rex.DecryptString(Request.Cookies["CookieCustomerEmail"].Value) + "'";
            Customer.Visible = true;
            Vendor.Visible = false;
            SqlDataSourceOrders.SelectCommand = query;
        }
        else if (Request.Cookies["CookieVendorEmail"] != null)
        {
            string query = "SELECT        tblorder.intOrderId AS OrderId, tblorder.varVendorId AS VendorId, DATE_FORMAT( tblorder.varOrderCreatedDate,'%d %b, %y') AS CreatedDate,  DATE_FORMAT(tblorder.varOrderDate,'%d %b, %y')  AS OrderDate, ";
            query += "       tblorder.varOrderTime AS OrderTime, tblorder.varAddress AS Address, tblorder.varAmount AS FeesAmount, tblorder.varRecieved AS Recieved, ";
            query += "  tblorder.varPaymentStatus AS `Payment Status`, tblorder.varTransactionId AS TransactionID, tblorder.varTransactionStatus AS TransactionStatus, ";
            query += "  tblorder.varPaymode AS Paymode, tblorder.varOrderStatus AS OrderStatus, tblvendor.intVendorCode AS VendorCode, tblvendor.varName AS VendorName, ";
            query += "  tblvendor.varContactPerson, tblvendor.varPhoneNo, tblvendor.varMobileNo, tblvendor.varEmailId AS VendorEmail, tblcustomer.varName AS CustomerName,";
            query += "  tblcustomer.varMobile AS CustomerMobile, tblcustomer.varEmail AS CustomerEmail, tblvendorabout.varImage AS VendorImage, ";
            query += "  tblvendorservices.varName AS ServiceName, tblvendorservices.varDescription AS ServiceDescription, countrymaster.CountryName, citymaster.CityName, ";
            query += "  statemaster.StateName, tblcustomer.imgImage AS CustomerImage";
            query += "  FROM            tblorder INNER JOIN";
            query += "              tblvendor ON tblorder.varVendorId = tblvendor.intVendorCode INNER JOIN";
            query += "  tblcustomer ON tblorder.intCustId = tblcustomer.intId INNER JOIN";
            query += "  tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN";
            query += "  tblvendorservices ON tblorder.intServiceID = tblvendorservices.intServiceCode INNER JOIN";
            query += "  countrymaster ON tblorder.intCountryId = countrymaster.CountryId INNER JOIN";
            query += "  citymaster ON tblorder.intCityId = citymaster.CityId INNER JOIN";
            query += "  statemaster ON tblorder.intStateId = statemaster.StateId where tblvendor.varEmailId='" + rex.DecryptString(Request.Cookies["CookieVendorEmail"].Value) + "'";
            
            Customer.Visible = false;
            Vendor.Visible = true;
            SqlDataSourceVendorOrder.SelectCommand = query;
        }
        else
        {
            Response.Redirect("~/Home/", false);
        }  
    }
    protected void lstOrders_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "canceled")
        {
            dbcs.con.Open();
            dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("update tblorder set varOrderStatus='Cancelled' where intOrderId='" + e.CommandArgument + "'", dbcs.con);
            dbcs.cmd.ExecuteNonQuery();
            dbcs.con.Close();
        }
        else if (e.CommandName == "reschedule")
        {
            Cache["OrderId"] = e.CommandArgument;
            Cache["Operation"] = "Reschedule";
            Response.Redirect("~/Home/RescheduleOrder.aspx", false);
        }
        else if (e.CommandName == "review")
        {
            Cache["OrderId"] = e.CommandArgument;
            Cache["Operation"] = "Review";
            Response.Redirect("~/Home/RescheduleOrder.aspx", false);
        }

        lstOrders.DataBind();
    }
    protected void lstVendorOrder_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "canceled")
        {
            dbcs.con.Open();
            dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("update tblorder set varOrderStatus='Cancelled' where intOrderId='" + e.CommandArgument + "'", dbcs.con);
            dbcs.cmd.ExecuteNonQuery();
            dbcs.con.Close();
        }
        else if (e.CommandName == "reschedule")
        {
            Cache["OrderId"] = e.CommandArgument;
            Response.Redirect("~/Home/RescheduleOrder.aspx", false);
        }
        lstVendorOrder.DataBind();
    }

    protected string GetString()
    {
        return rex.DecryptString(Request.Cookies["CookieCustomerEmail"].Value);
    }
}