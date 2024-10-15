using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Net.Mail;
using System.Net;
using System.IO;
using System.Text;

public partial class Home_RescheduleOrder : BaseClass
{
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices(); RegexUtilities rex = new RegexUtilities();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Cache["OrderId"] == null)
        {
            Response.Redirect("~/Society/Logout.aspx", false);
        }
        else if (Cache["Operation"] == null)
        {
            Response.Redirect("~/Society/Logout.aspx", false);
        }
        else
        {
            lblOrderNo.Text = (string)Cache["OrderId"];
            lblOrderOp.Text = (string)Cache["Operation"];

            if (Request.Cookies["CookieCustomerEmail"] != null)
            {
                lstOrders.Visible = true;

                string query = "SELECT tblorder.intOrderId AS OrderId, tblorder.varVendorId AS VendorId, DATE_FORMAT( tblorder.varOrderCreatedDate,'%d %b, %y') AS CreatedDate,  DATE_FORMAT(tblorder.varOrderDate,'%d %b, %y')  AS OrderDate, ";
                query += " tblorder.varOrderTime AS OrderTime, tblorder.varAddress AS Address, tblorder.varAmount AS FeesAmount, tblorder.varRecieved AS Recieved,  ";
                query += " tblorder.varPaymentStatus AS PaymentStatus, tblorder.varTransactionId AS TransactionID, tblorder.varTransactionStatus AS TransactionStatus,  ";
                query += " tblorder.varPaymode AS Paymode, tblorder.varOrderStatus AS OrderStatus, tblvendor.intVendorCode AS VendorCode, tblvendor.varName AS VendorName,  ";
                query += " tblvendor.varContactPerson, tblvendor.varPhoneNo, tblvendor.varMobileNo, tblvendor.varEmailId AS VendorEmail, tblcustomer.varName AS CustomerName,  ";
                query += " tblcustomer.varMobile AS CustomerMobile, tblcustomer.varEmail AS CustomerEmail, tblvendorabout.varImage AS VendorImage,  ";
                query += " tblvendorservices.varName AS ServiceName, tblvendorservices.varDescription AS ServiceDescription, countrymaster.CountryName, citymaster.CityName,  ";
                query += " statemaster.StateName  ";
                query += " FROM tblorder INNER JOIN ";
                query += " tblvendor ON tblorder.varVendorId = tblvendor.intVendorCode INNER JOIN ";
                query += " tblcustomer ON tblorder.intCustId = tblcustomer.intId INNER JOIN ";
                query += " tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN ";
                query += " tblvendorservices ON tblorder.intServiceID = tblvendorservices.intServiceCode INNER JOIN ";
                query += " countrymaster ON tblorder.intCountryId = countrymaster.CountryId INNER JOIN ";
                query += " citymaster ON tblorder.intCityId = citymaster.CityId INNER JOIN ";
                query += " statemaster ON tblorder.intStateId = statemaster.StateId ";
                query += " where tblorder.intOrderId='" + Cache["OrderId"].ToString() + "'";

                SqlDataSourceOrders.SelectCommand = query;

                lstVendorOrder.Visible = false;
                vendor.Visible = false;
                if (Cache["Operation"].ToString() == "Review")
                {
                    review.Visible = true;
                    btnReview.Visible = true;

                    reschedule.Visible = false;
                    btnReschedule.Visible = false;
                }
                else
                {
                    review.Visible = false;
                    btnReview.Visible = false;

                    reschedule.Visible = true;
                    btnReschedule.Visible = true;
                }
            }
            else if (Request.Cookies["CookieVendorEmail"] != null)
            {
                lstOrders.Visible = false;
                string query = " SELECT        tblorder.intOrderId AS OrderId, tblorder.varVendorId AS VendorId, DATE_FORMAT( tblorder.varOrderCreatedDate,'%d %b, %y') AS CreatedDate,  DATE_FORMAT(tblorder.varOrderDate,'%d %b, %y')  AS OrderDate,  ";
                query += " tblorder.varOrderTime AS OrderTime, tblorder.varAddress AS Address, tblorder.varAmount AS FeesAmount, tblorder.varRecieved AS Recieved,  ";
                query += " tblorder.varPaymentStatus AS PaymentStatus, tblorder.varTransactionId AS TransactionID, tblorder.varTransactionStatus AS TransactionStatus,  ";
                query += " tblorder.varPaymode AS Paymode, tblorder.varOrderStatus AS OrderStatus, tblvendor.intVendorCode AS VendorCode, tblvendor.varName AS VendorName,  ";
                query += "  tblvendor.varContactPerson, tblvendor.varPhoneNo, tblvendor.varMobileNo, tblvendor.varEmailId AS VendorEmail, tblcustomer.varName AS CustomerName,  ";
                query += " tblcustomer.varMobile AS CustomerMobile, tblcustomer.varEmail AS CustomerEmail, tblvendorabout.varImage AS VendorImage,  ";
                query += " tblvendorservices.varName AS ServiceName, tblvendorservices.varDescription AS ServiceDescription, countrymaster.CountryName, citymaster.CityName,  ";
                query += "   statemaster.StateName, tblcustomer.imgImage AS CustomerImage ";
                query += " FROM            tblorder INNER JOIN ";
                query += "   tblvendor ON tblorder.varVendorId = tblvendor.intVendorCode INNER JOIN ";
                query += "   tblcustomer ON tblorder.intCustId = tblcustomer.intId INNER JOIN ";
                query += "  tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN ";
                query += "  tblvendorservices ON tblorder.intServiceID = tblvendorservices.intServiceCode INNER JOIN ";
                query += "  countrymaster ON tblorder.intCountryId = countrymaster.CountryId INNER JOIN ";
                query += "   citymaster ON tblorder.intCityId = citymaster.CityId INNER JOIN ";
                query += "   statemaster ON tblorder.intStateId = statemaster.StateId ";
                query += " where tblorder.intOrderId='" + Cache["OrderId"].ToString() + "'";

                SqlDataSourceVendorOrder.SelectCommand = query;
                lstVendorOrder.Visible = true;
                vendor.Visible = true;
                reschedule.Visible = false;
                btnReschedule.Visible = true;
            }
            else
            {
                Response.Redirect("~/Home/", false);
            }
        }
    }

    protected void btnReschdule_Click(object sender, EventArgs e)
    {
        try
        {
            string OrderStatus = ddlStatus.SelectedValue == null ? "Started" : "Started";

            if (ddlStatus.SelectedValue == "Completed")
            {
                dbcs.con.Open();
                dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("update tblorder set varOrderStatus='" + ddlStatus.SelectedValue + "'  where intOrderId='" + Cache["OrderId"].ToString() + "'", dbcs.con);
                dbcs.cmd.ExecuteNonQuery();
                dbcs.con.Close();

                Response.Redirect("~/Home/ViewOrders.aspx", false);
            }
            else if (Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)) < DateTime.ParseExact(DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy"), "dd-MM-yyyy", CultureInfo.InvariantCulture))
            {
                Response.Write("<script>alert('Please select proper date ..!!');</script>");
            }
            else if (Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)) == DateTime.ParseExact(DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy"), "dd-MM-yyyy", CultureInfo.InvariantCulture))
            {
                dbcs.con.Open();
                dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("update tblorder set varOrderStatus='" + OrderStatus + "',varOrderDate='" + Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd") + "',varOrderTime='" + ddlTime.SelectedItem + "' where intOrderId='" + Cache["OrderId"].ToString() + "'", dbcs.con);
                dbcs.cmd.ExecuteNonQuery();
                dbcs.con.Close();

                dbcs.con.Open();
                dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblorderhistory(intOrderId, varDate, varTime,varDescription) VALUES ( '" + Cache["OrderId"].ToString() + "', '" + Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd") + "', '" + ddlTime.SelectedItem + "','" + txtUpdate.Text.Replace("'", "\\'") +"')", dbcs.con);
                dbcs.cmd.ExecuteNonQuery();
                dbcs.con.Close();

                dbcs.con.Open();
                dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT tblcustomer.varEmail AS cust, tblvendor.varEmailId AS vend, tblvendor.varName AS vname, tblorder.varAmount AS fees, tblcustomer.varName AS cname FROM tblorder INNER JOIN tblcustomer ON tblorder.intCustId = tblcustomer.intId INNER JOIN tblvendor ON tblorder.varVendorId = tblvendor.intVendorCode WHERE (tblorder.intOrderId  = '" + Cache["OrderId"].ToString() + "')", dbcs.con);
                dbcs.dr = dbcs.cmd.ExecuteReader();
                if (dbcs.dr.Read())
                {
                    sendmail(dbcs.dr["cust"].ToString(), dbcs.dr["cname"].ToString(), Cache["OrderId"].ToString(), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), ddlTime.SelectedItem.ToString(), dbcs.dr["vname"].ToString(), dbcs.dr["fees"].ToString(), dbcs.dr["fees"].ToString(), "~/SK/EmailTemplate/ResheduleServiceCustomerMail.html");
                    sendmail(dbcs.dr["cust"].ToString(), dbcs.dr["cname"].ToString(), Cache["OrderId"].ToString(), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), ddlTime.SelectedItem.ToString(), dbcs.dr["vname"].ToString(), dbcs.dr["fees"].ToString(), dbcs.dr["fees"].ToString(), "~/SK/EmailTemplate/ResheduleServiceVendorMail.html");
                }
                dbcs.con.Close();
                Response.Redirect("~/Home/ViewOrders.aspx", false);


            }
            else
            {
                dbcs.con.Open();
                dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("update tblorder set varOrderStatus='" + OrderStatus + "',varOrderDate='" + Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd") + "',varOrderTime='" + ddlTime.SelectedItem + "' where intOrderId='" + Cache["OrderId"].ToString() + "'", dbcs.con);
                dbcs.cmd.ExecuteNonQuery();
                dbcs.con.Close();

                dbcs.con.Open();
                dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblorderhistory(intOrderId, varDate, varTime,varDescription) VALUES ( '" + Cache["OrderId"].ToString() + "', '" + Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd") + "', '" + ddlTime.SelectedItem + "','" + txtUpdate.Text.Replace("'", "\\'") +"')", dbcs.con);
                dbcs.cmd.ExecuteNonQuery();
                dbcs.con.Close();

                dbcs.con.Open();
                dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT tblcustomer.varEmail AS cust, tblvendor.varEmailId AS vend, tblvendor.varName AS vname, tblorder.varAmount AS fees, tblcustomer.varName AS cname FROM tblorder INNER JOIN tblcustomer ON tblorder.intCustId = tblcustomer.intId INNER JOIN tblvendor ON tblorder.varVendorId = tblvendor.intVendorCode WHERE (tblorder.intOrderId  = '" + Cache["OrderId"].ToString() + "')", dbcs.con);
                dbcs.dr = dbcs.cmd.ExecuteReader();
                if (dbcs.dr.Read())
                {
                    sendmail(dbcs.dr["cust"].ToString(), dbcs.dr["cname"].ToString(), Cache["OrderId"].ToString(), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("dd-MM-yyyy"), ddlTime.SelectedItem.ToString(), dbcs.dr["vname"].ToString(), dbcs.dr["fees"].ToString(), dbcs.dr["fees"].ToString(), "~/SK/EmailTemplate/ResheduleServiceCustomerMail.html");
                    sendmail(dbcs.dr["vend"].ToString(), dbcs.dr["cname"].ToString(), Cache["OrderId"].ToString(), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("dd-MM-yyyy"), ddlTime.SelectedItem.ToString(), dbcs.dr["vname"].ToString(), dbcs.dr["fees"].ToString(), dbcs.dr["fees"].ToString(), "~/SK/EmailTemplate/ResheduleServiceVendorMail.html");
                }
                dbcs.con.Close();
                Response.Redirect("~/Home/ViewOrders.aspx", false);
            }
        }
        catch (Exception ex)
        {
            string exs = ex.Message;
        }
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlStatus.SelectedValue == "Started")
        {
            reschedule.Visible = true;
        }
        else
        {
            reschedule.Visible = false;
        }
    }
    protected void btnReview_Click(object sender, EventArgs e)
    {

        dbcs.con.Open();
        dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand(" SELECT intCustId, varVendorId FROM tblorder WHERE intOrderId='" + lblOrderNo.Text.Replace("'", "\\'") +"'", dbcs.con);
        dbcs.dr = dbcs.cmd.ExecuteReader();
        if (dbcs.dr.Read())
        {
            dbcs.con1.Open();
            dbcs.cmd1 = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblreviews( intOrderId, varVendorId, varCustomerId, intRating, varReview, intOnTime, intQuality,ex1 ) VALUES ( '" + lblOrderNo.Text.Replace("'", "\\'") +"', '" + dbcs.dr["varVendorId"].ToString() + "', '" + dbcs.dr["intCustId"].ToString() + "', " + Convert.ToInt32(ddlRating.SelectedValue) + ", '" + txtReview.Text.Replace("'", "\\'") +"', " + cbkTime.Checked + ", " + cbkQuality.Checked + ",'" + DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd") + "' ) ", dbcs.con1);
            dbcs.cmd1.ExecuteNonQuery();
            dbcs.con1.Close();
        }
        dbcs.con.Close();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "message", "alert('Thank You for submitting Review..');location.href = 'ViewOrders.aspx';", true);

    }

    protected void sendmail(string email, string custname, string orderid, string date, string time, string serviceprovider, string fees, string totalfees, string path)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <support@societykatta.com>"), new MailAddress(email)))
            {
                mm.Subject = " Your SocietyKatta Service Reshedule Details";

                mm.Body = PopulateBody(custname, orderid, date, time, serviceprovider, fees, totalfees, path);

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


    private string PopulateBody(string custname, string orderid, string date, string time, string serviceprovider, string fees, string totalfees, string path)
    {
        try
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath(path)))
            {
                body = reader.ReadToEnd();
            }

            body = body.Replace("{custname}", custname);
            body = body.Replace("{orderid}", orderid);
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
    //Mail
    public string listviewData(ListView gv)
    {
        StringBuilder sb = new StringBuilder();
        StringWriter sw = new StringWriter(sb);
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gv.RenderControl(htw);

        return sb.ToString();
    }
    public override void VerifyRenderingInServerForm(Control Listview)
    {
        /* Verifies that the control is rendered */
    }

}