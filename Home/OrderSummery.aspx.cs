using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using System.Globalization;
using System.Net.Mail;
using System.Net;
using System.IO;
using System.Text;

public partial class Home_OrderSummery : BaseClass
{
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();
    RegexUtilities rex = new RegexUtilities();
    static Int32 country, state, city = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["CookieCustomerEmail"] == null)
            {
                Response.Redirect("~/Home/Login.aspx", false);
            }
            if (!IsPostBack)
            {
                string query = "SELECT tblvendor.varName, CAST(AVG(tblreviews.intRating) as DECIMAL(0)) as intRating, CAST(AVG(tblreviews.intOnTime) as DECIMAL(0)) as intOnTime, CAST(AVG(tblreviews.intQuality) as DECIMAL(0)) as intQuality, tblvendordescription.varDescription, tblvendor.intVendorCode, ";
                query += " tblvendorofferedservices.intServiceId,concat(tblvendor.varMobileNo,'/' ,tblvendor.varPhoneNo) as contact, tblvendorabout.varAbout, tblvendorabout.varImage, tblvendordescription.varCharges, tblvendorservices.varName AS serName, ";
                query += "'" + Cache["Date"].ToString() + "," + Cache["Time"].ToString() + "'" + " as Dte "; 
                query += " FROM tblvendor INNER JOIN ";
                query += " tblreviews ON tblvendor.intVendorCode = tblreviews.varVendorId INNER JOIN ";
                query += " tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN ";
                query += " tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER  JOIN ";
                query += " tblvendorabout ON tblvendor.intId = tblvendorabout.intId INNER JOIN ";
                query += " tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode ";
                query += "WHERE (tblvendor.intVendorCode = '" + Cache["VendorCode"] + "') AND (tblvendorofferedservices.intServiceId = " + Cache["ServiceCode"] + ") ";
                SqlDataSourceServiceByCode.SelectCommand = query;
              
                getCustomerData(); 
                
                lblservicename.Text = dbcs.GetServiceNamefromServiceId(Convert.ToInt32(Cache["ServiceCode"]));
            }
        }
    }
    public void getCustomerData()
    {
        try
        {
            dbcs.con1.Close();
            MySql.Data.MySqlClient.MySqlCommand cmdej = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblcustomer.varCountry, tblcustomer.varState, tblcustomer.varCity, tblcustomer.varName, tblcustomer.varMobile, tblcustomer.varMobileVerify, tblcustomer.varEmail, tblcustomer.varEmailVerify, tblcustomer.varAddress, tblcustomer.varPassword, tblcustomer.varLandline, tblcustomer.intId, tblcustomer.varLandmark,   tblcustomer.varNeighbourhood, tblcustomer.varStatus, tblcustomer.imgImage, countrymaster.CountryName, statemaster.StateName, citymaster.CityName FROM  tblcustomer INNER JOIN       countrymaster ON tblcustomer.varCountry = countrymaster.CountryId INNER JOIN  statemaster ON tblcustomer.varState = statemaster.StateId INNER JOIN     citymaster ON tblcustomer.varCity = citymaster.CityId WHERE  tblcustomer.varEmail='" + rex.DecryptString(Request.Cookies["CookieCustomerEmail"].Value) + "'", dbcs.con1);
            dbcs.con1.Open();
            dbcs.dr = cmdej.ExecuteReader();
            if (dbcs.dr.Read())
            {
                txtName.Text = dbcs.dr["varName"].ToString();
                txtEmail.Text = dbcs.dr["varEmail"].ToString();
                txtMobile.Text = dbcs.dr["varMobile"].ToString();
                txtAddress.Text = dbcs.dr["varAddress"].ToString();
                txtLandmark.Text = dbcs.dr["varLandmark"].ToString();
                ddlCountry.Text = dbcs.dr["CountryName"].ToString();

                ddlState.Text = dbcs.dr["StateName"].ToString();

                ddlCity.Text = dbcs.dr["CityName"].ToString();

                country = Convert.ToInt32(dbcs.dr["varCountry"].ToString());
                state = Convert.ToInt32(dbcs.dr["varState"].ToString());
                city = Convert.ToInt32(dbcs.dr["varCity"].ToString());
            }
            dbcs.con1.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void btnPayment_Click(object sender, EventArgs e)
    {
        string query = "SELECT tblvendor.varName, CAST(AVG(tblreviews.intRating) as DECIMAL(0)) as intRating, CAST(AVG(tblreviews.intOnTime) as DECIMAL(0)) as intOnTime, CAST(AVG(tblreviews.intQuality) as DECIMAL(0)) as intQuality, tblvendordescription.varDescription, tblvendor.intVendorCode, ";
        query += " tblvendor.varEmailId ,tblvendorofferedservices.intServiceId, tblvendorabout.varAbout, tblvendorabout.varImage, tblvendordescription.varCharges, tblvendorservices.varName AS serName ";
        query += " FROM tblvendor INNER JOIN ";
        query += " tblreviews ON tblvendor.intVendorCode = tblreviews.varVendorId INNER JOIN ";
        query += " tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN ";
        query += " tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER  JOIN ";
        query += " tblvendorabout ON tblvendor.intId = tblvendorabout.intId INNER JOIN ";
        query += " tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode ";
        query += "WHERE (tblvendor.intVendorCode = '" + Cache["VendorCode"] + "') AND (tblvendorofferedservices.intServiceId = " + Cache["ServiceCode"] + ") ";

        dbcs.con.Close();
        MySql.Data.MySqlClient.MySqlCommand cmdej = new MySql.Data.MySqlClient.MySqlCommand(query, dbcs.con);
        dbcs.con.Open();
        dbcs.dr = cmdej.ExecuteReader();
        if (dbcs.dr.Read())
        {
            dbcs.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("sp_insert_Order", dbcs.con1);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new MySqlParameter("intCustId", rex.DecryptString(Request.Cookies["CookieCustomerID"].Value)));
            cmd.Parameters.Add(new MySqlParameter("varVendorId", Cache["VendorCode"]));
            cmd.Parameters.Add(new MySqlParameter("intServiceID", Cache["ServiceCode"]));
            cmd.Parameters.Add(new MySqlParameter("varOrderCreatedDate", DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd")));
            cmd.Parameters.Add(new MySqlParameter("varOrderDate", Convert.ToDateTime(DateTime.ParseExact(Cache["Date"].ToString(), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd")));
            cmd.Parameters.Add(new MySqlParameter("varOrderTime", Cache["Time"]));
            cmd.Parameters.Add(new MySqlParameter("intCountryId", country));
            cmd.Parameters.Add(new MySqlParameter("intStateId",state));
            cmd.Parameters.Add(new MySqlParameter("intCityId", city));
            cmd.Parameters.Add(new MySqlParameter("varAddress", txtAddress.Text));
            cmd.Parameters.Add(new MySqlParameter("intNeighbourhood", "NA"));
            cmd.Parameters.Add(new MySqlParameter("varAmount", dbcs.dr["varCharges"].ToString()));
            cmd.Parameters.Add(new MySqlParameter("varRecieved", "0"));
            cmd.Parameters.Add(new MySqlParameter("varPaymentStatus", "Pending"));
            cmd.Parameters.Add(new MySqlParameter("varTransactionId", "NA"));
            cmd.Parameters.Add(new MySqlParameter("varTransactionStatus", "Pending"));
            cmd.Parameters.Add(new MySqlParameter("varPaymode", "NA"));
            cmd.Parameters.Add(new MySqlParameter("varOrderStatus", "Started"));

            string invoiceid = (string)cmd.ExecuteScalar();
            dbcs.con1.Close();


            sendmailCustomer(txtName.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), lblservicename.Text.Replace("'", "\\'"), dbcs.dr["varName"].ToString(), dbcs.dr["varCharges"].ToString(), dbcs.dr["varCharges"].ToString(), invoiceid, Cache["Date"].ToString(), Cache["Time"].ToString());
            sendmailVendor(txtName.Text.Replace("'", "\\'"), dbcs.dr["varEmailId"].ToString(), lblservicename.Text.Replace("'", "\\'"), dbcs.dr["varName"].ToString(), dbcs.dr["varCharges"].ToString(), dbcs.dr["varCharges"].ToString(), invoiceid, Cache["Date"].ToString(), Cache["Time"].ToString());

           

            Response.Redirect("~/Home/ViewOrders.aspx", false);
            //Response.Redirect("~/Society/Payprocess/Default.aspx?amount=" + dbcs.dr["varCharges"].ToString() + "&firstname=" + txtName.Text + "&email=" + txtEmail.Text + "&phone=" + txtMobile.Text + "&productinfo=SKSCPAYMENT&udf1=" + invoiceid + "&udf2=" + rex.DecryptString(Request.Cookies["CookieCustomerID"].Value) + "&udf3=" + rex.DecryptString(Request.Cookies["CookieCustomerID"].Value) + "&surl=http://societykatta.com/Home/ViewOrders.aspx&furl=http://societykatta.com/Home/ViewOrders.aspx", false);

        }
        dbcs.con.Close();

    }

    protected void sendmailCustomer(string custname, string custemail, string servicename, string serviceprovider, string fees, string totalfees, string invoiceno, string date, string time)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <support@societykatta.com>"), new MailAddress(custemail)))
            {
                mm.Subject = "Your SocietyKatta Service Booking Details";

                mm.Body = PopulateBodyCustomer(custname, servicename, serviceprovider, fees, totalfees, invoiceno, date, time);

                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient(); 
                //for server

                smtp.Host = "relay-hosting.secureserver.net";
                smtp.EnableSsl = false;

                //for local 

                //smtp.Host = "smtp.rediffmailpro.com";
                //smtp.EnableSsl = true;

                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                NetworkCredential NetworkCred = new NetworkCredential("support@societykatta.com", "support@2016");
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = NetworkCred;
                //for server

                smtp.Port = 25;

                //for local
                  //smtp.Port = 587;
                smtp.Send(mm);

            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //ScriptManager.RegisterStartupScript(
            //             this,
            //             this.GetType(),
            //             "MessageBox",
            //              "alert('Email Not Sent....');", true);

        }
    }

    private string PopulateBodyCustomer(string custname, string servicename, string serviceprovider, string fees, string totalfees, string invoiceno, string date, string time)
    {
        try
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/BookServiceCustomerMail.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{custname}", custname);
            body = body.Replace("{servicename}", servicename);
            body = body.Replace("{invoiceno}", invoiceno);           
            body = body.Replace("{ServiceProvider}", serviceprovider);
            body = body.Replace("{Fees}", fees);
            body = body.Replace("{TotalFees}", totalfees);
            body = body.Replace("{date}", date);
            body = body.Replace("{time}", time); 

            return body;
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            return "";

        }
    }
    private string PopulateBodyVendor(string custname, string servicename, string serviceprovider, string fees, string totalfees, string invoiceno, string date, string time)
    {
        try
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/BookServiceVendorEmail.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{custname}", custname);
            body = body.Replace("{servicename}", servicename);
            body = body.Replace("{invoiceno}", invoiceno);
            body = body.Replace("{ServiceProvider}", serviceprovider);
            body = body.Replace("{Fees}", fees);
            body = body.Replace("{TotalFees}", totalfees);
            body = body.Replace("{date}", date);
            body = body.Replace("{time}", time);

            return body;
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            return "";

        }
    }

    protected void sendmailVendor(string custname, string vendoremail, string servicename, string serviceprovider, string fees, string totalfees, string invoiceno, string date, string time)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("Sales Enquiry <sales@societykatta.com>"), new MailAddress(vendoremail)))
            {
                mm.Subject = "Your SocietyKatta Service Booking Details";

                mm.Body = PopulateBodyVendor(custname, servicename, serviceprovider, fees, totalfees, invoiceno, date, time);

                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                //for server

                //smtp.Host = "relay-hosting.secureserver.net";
                //smtp.EnableSsl = false;

                //for local 

                smtp.Host = "smtp.rediffmailpro.com";
                smtp.EnableSsl = true;

                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                NetworkCredential NetworkCred = new NetworkCredential("sales@societykatta.com", "sales@2016");
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = NetworkCred;
                //for server
                //smtp.Port = 25;
                //for local
                smtp.Port = 587;

                smtp.Send(mm);

                

            }
        }
        catch (Exception rx)
        {
            string exp = rx.Message;
            //ScriptManager.RegisterStartupScript(
            //             this,
            //             this.GetType(),
            //             "MessageBox",
            //              "alert('Email Not Sent....');", true);

        }

    }

}