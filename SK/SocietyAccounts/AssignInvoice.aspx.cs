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
using System.Net.Mail;
using System.Net;
using System.Globalization;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;
using System.Text;

public partial class SK_SocietyAccounts_AssignInvoice : System.Web.UI.Page
{
    DataTable dtInvoice;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();
    DatabaseConnectionSKAdmin dbcsk = new DatabaseConnectionSKAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Cache["dtInvoice"] == null)
        {
            Response.Redirect("~/SK/SocietyAccounts/CreateInvoice.aspx", false);
        }
        else if (!IsPostBack)
        {
            dtInvoice = new DataTable();
            MakeDataTable();
            getLoadData();
        }
        else
        {
            dtInvoice = (DataTable)ViewState["dtInvoice"];
        }
        ViewState["dtInvoice"] = dtInvoice;

    }
    public void getLoadData()
    {
        try
        {
            //dbc.con.Close();
            //dbc.con.Open();
            //MySqlCommand da = new MySqlCommand("SELECT intId, intSocietyCode, varRegistrationNo, varName, varSAddress, varSPhone, varSMobile, varSEmail, varSFax, varCountryId, varStateId, varCityId, varPin, varConstructedby, varCompany, varCompanyAddress, varContactPerson, varContactMobile, varContactPhone, varContactEmail, varConstuctionYear, varTotalArea, varTotalWings, varIsActive,  statemaster.StateName, citymaster.CityName FROM tblsocietyinfo INNER JOIN  statemaster ON tblsocietyinfo.varStateId = statemaster.StateId INNER JOIN citymaster ON tblsocietyinfo.varCityId = citymaster.CityId  WHERE intSocietyCode='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'", dbc.con);
            //dbc.dr1 = da.ExecuteReader();
            //if (dbc.dr1.Read())
            //{
            //    lblSocietyName.Text = dbc.dr1["varName"].ToString();
            //    lblSocietyAddress.Text = dbc.dr1["varSAddress"].ToString();
            //    lblSocietyState.Text = dbc.dr1["StateName"].ToString();
            //    lblSocietyCity.Text = dbc.dr1["CityName"].ToString();
            //    lblSocietyPIN.Text = dbc.dr1["varPin"].ToString();
            //}
            //dbc.con.Close();
            //dbc.dr1.Dispose();

            lblSocietyName.Text = "Societykatta.com";
            lblSocietyAddress.Text = "Flat No. 1, Akshay Chambers,<br> Samarth Colony,<br> Near Prabhat Chowk, Jalgaon.";
            lblSocietyState.Text = "Maharashtra";
            lblSocietyCity.Text = "Jalgaon";
            lblSocietyPIN.Text = "425001";

            dtInvoice = (DataTable)Cache["dtInvoice"];
            lstInvoiceDetails.DataSource = dtInvoice;
            lstInvoiceDetails.DataBind();

            lblSubBill.Text = (string)Cache["billAmount"];
            lblFinalBill.Text = lblSubBill.Text;
            lblDate.Text = (string)Cache["dateInvoice"];
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            dbc.dr1.Dispose();
            string exp = ex.Message;
        }
    }
    private void MakeDataTable()
    {
        try
        {
            dtInvoice.Columns.Add("Operation");
            dtInvoice.Columns.Add("SrNo");
            dtInvoice.Columns.Add("Particulars");
            dtInvoice.Columns.Add("Amount");

        }
        catch (Exception ex)
        {
            dbc.con.Close();
            dbc.dr1.Dispose();
            string exp = ex.Message;
        }
    }

   

    protected void ddlAllOrMultiple_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAllOrMultiple.SelectedItem.ToString() == "All")
        {
            ddlSocOrVen.Disabled = true;
        }
        else if (ddlAllOrMultiple.SelectedItem.ToString() == "Multiple")
        {
            ddlSocOrVen.Disabled = false;
        }
        else
        {
            ddlSocOrVen.Disabled = false;
        }
    }

    protected void btnCreate_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlAllOrMultiple.Enabled == false)
            {
                Response.Write("<script>alert('Please Select All or Multiple');</script>");
            }
            else
            { 
                dbcsk.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("sp_insert_Invoice", dbcsk.con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("varDateTime", Convert.ToDateTime(DateTime.ParseExact(lblDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd")));
                cmd.Parameters.Add(new MySqlParameter("varSubTotal", lblSubBill.Text));
                cmd.Parameters.Add(new MySqlParameter("varDiscount", "NA"));
                cmd.Parameters.Add(new MySqlParameter("varTax", "NA"));
                cmd.Parameters.Add(new MySqlParameter("varOther", "NA"));
                cmd.Parameters.Add(new MySqlParameter("varTotal", lblFinalBill.Text));
                string invoiceid = (string)cmd.ExecuteScalar();
                dbcsk.con.Close();

                foreach (DataRow drow in dtInvoice.Rows)
                {
                    dbcsk.con.Open();
                    dbcsk.cmd = new MySqlCommand("INSERT INTO tblinvoicedetails(varInvoiceId, varParticulars, varAttachment, varAmount) VALUES ('" + invoiceid + "','" + drow["Particulars"].ToString() + "','NA','" + drow["Amount"].ToString() + "')", dbcsk.con);
                    dbcsk.cmd.ExecuteNonQuery();
                    dbcsk.con.Close();
                }


                if (ddlInvoiceFor.SelectedValue == "1")
                {
                    if (ddlAllOrMultiple.SelectedValue == "1")
                    {
                        dbcs.con.Open();
                        MySqlCommand das = new MySqlCommand("SELECT CONCAT(tblvendor.varName, '-', citymaster.CityName) AS vendors, tblvendor.intVendorCode FROM tblvendor INNER JOIN citymaster ON tblvendor.varCity = citymaster.CityId", dbcs.con);
                        dbcs.dr1 = das.ExecuteReader();
                        while (dbcs.dr1.Read())
                        {
                            dbcsk.con1.Open();
                            dbcsk.cmd = new MySqlCommand("INSERT INTO tblinvoiceforsocietyorvendors (varSocietyOrVendor,varPersonnelId, varInvoiceId, varRecieved, varOutstanding, varPaymentStatus, varTransactionId, varTransactionStatus, varPaymode, varInvoiceStatus) VALUES ( " + ddlInvoiceFor.SelectedValue + ",'" + dbcs.dr1["intVendorCode"].ToString() + "','" + invoiceid + "','0','" + lblFinalBill.Text.Replace("'", "\\'") +"','Pending','0','Started','NA','Started')", dbcsk.con1);
                            dbcsk.cmd.ExecuteNonQuery();
                            dbcsk.con1.Close();

                            //sendmail(dbcsk.dr1["Name"].ToString(), dbcsk.dr1["varPropertyId"].ToString(), invoiceid, lblFinalBill.Text.Replace("'", "\\'"), dbcsk.dr1["varEmail"].ToString());

                             
                        }
                        dbcsk.con.Close();
                    }
                    else
                    {
                        for (int i = 0; i <= ddlSocOrVen.Items.Count - 1; i++)
                        {
                            if (ddlSocOrVen.Items[i].Selected)
                            {

                                dbcsk.con1.Open();
                                dbcsk.cmd = new MySqlCommand("INSERT INTO tblinvoiceforsocietyorvendors (varSocietyOrVendor,varPersonnelId, varInvoiceId, varRecieved, varOutstanding, varPaymentStatus, varTransactionId, varTransactionStatus, varPaymode, varInvoiceStatus) VALUES ( " + ddlInvoiceFor.SelectedValue + ",'" + ddlSocOrVen.Items[i].Value.ToString() + "','" + invoiceid + "','0','" + lblFinalBill.Text.Replace("'", "\\'") +"','Pending','0','Started','NA','Started')", dbcsk.con1);
                                dbcsk.cmd.ExecuteNonQuery();
                                dbcsk.con1.Close();

                                dbcs.con.Open();
                                MySqlCommand das = new MySqlCommand("SELECT CONCAT(tblvendor.varName, '-', citymaster.CityName) AS vendors, tblvendor.intVendorCode FROM tblvendor INNER JOIN citymaster ON tblvendor.varCity = citymaster.CityId where tblvendor.intVendorCode='" + ddlSocOrVen.Items[i].Value.ToString() + "'", dbcs.con);
                                dbcs.dr1 = das.ExecuteReader();
                                if (dbcs.dr1.Read())
                                {
                                    //sendmail(dbc.dr1["Name"].ToString(), dbc.dr1["varPropertyId"].ToString(), invoiceid, lblFinalBill.Text.Replace("'", "\\'"), dbc.dr1["varEmail"].ToString());
                                }
                                dbc.con.Close();
                            }
                        }
                    }
                }
                else if (ddlInvoiceFor.SelectedValue == "2")
                {
                    if (ddlAllOrMultiple.SelectedValue == "1")
                    {
                        dbc.con.Open();
                        MySqlCommand das = new MySqlCommand("SELECT CONCAT(tblsocietyinfo.varName, '-', tblsocietyinfo.intSocietyCode, '-', citymaster.CityName) AS society, tblsocietyinfo.intSocietyCode, tblsocietypersonnel.intEmpCode,tblsocietypersonnel.intRole FROM tblsocietyinfo INNER JOIN citymaster ON tblsocietyinfo.varCityId = citymaster.CityId INNER JOIN tblsocietypersonnel ON tblsocietyinfo.intSocietyCode = tblsocietypersonnel.intSocietyId INNER JOIN rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE (rolesmasterculturemap.RoleName = 'Admin')", dbc.con);
                        dbc.dr1 = das.ExecuteReader();
                        while (dbc.dr1.Read())
                        {
                            dbcsk.con1.Open();
                            dbcsk.cmd = new MySqlCommand("INSERT INTO tblinvoiceforsocietyorvendors (varSocietyOrVendor,varPersonnelId, varInvoiceId, varRecieved, varOutstanding, varPaymentStatus, varTransactionId, varTransactionStatus, varPaymode, varInvoiceStatus) VALUES ( " + ddlInvoiceFor.SelectedValue + ",'" + dbc.dr1["intSocietyCode"].ToString() + "','" + invoiceid + "','0','" + lblFinalBill.Text.Replace("'", "\\'") +"','Pending','0','Started','NA','Started')", dbcsk.con1);
                            dbcsk.cmd.ExecuteNonQuery();
                            dbcsk.con1.Close();

                            //sendmail(dbcsk.dr1["Name"].ToString(), dbcsk.dr1["varPropertyId"].ToString(), invoiceid, lblFinalBill.Text.Replace("'", "\\'"), dbcsk.dr1["varEmail"].ToString());

                            dbc.insert_tblnotifications(dbc.dr1["intSocietyCode"].ToString(), "text", "0", "0", dbc.dr1["intEmpCode"].ToString(), dbc.dr1["intRole"].ToString(), "New Invoice Generated by SocietyKatta ", "", "", "Unread", "");

                        }
                        dbcsk.con.Close();
                    }
                    else
                    {
                        for (int i = 0; i <= ddlSocOrVen.Items.Count - 1; i++)
                        {
                            if (ddlSocOrVen.Items[i].Selected)
                            {

                                dbcsk.con1.Open();
                                dbcsk.cmd = new MySqlCommand("INSERT INTO tblinvoiceforsocietyorvendors (varSocietyOrVendor,varPersonnelId, varInvoiceId, varRecieved, varOutstanding, varPaymentStatus, varTransactionId, varTransactionStatus, varPaymode, varInvoiceStatus) VALUES ( " + ddlInvoiceFor.SelectedValue + ",'" + ddlSocOrVen.Items[i].Value.ToString() + "','" + invoiceid + "','0','" + lblFinalBill.Text.Replace("'", "\\'") +"','Pending','0','Started','NA','Started')", dbcsk.con1);
                                dbcsk.cmd.ExecuteNonQuery();
                                dbcsk.con1.Close();

                                dbc.con.Open();
                                MySqlCommand das = new MySqlCommand("SELECT CONCAT(tblsocietyinfo.varName, '-', tblsocietyinfo.intSocietyCode, '-', citymaster.CityName) AS society, tblsocietyinfo.intSocietyCode, tblsocietypersonnel.intEmpCode,tblsocietypersonnel.intRole FROM tblsocietyinfo INNER JOIN citymaster ON tblsocietyinfo.varCityId = citymaster.CityId INNER JOIN tblsocietypersonnel ON tblsocietyinfo.intSocietyCode = tblsocietypersonnel.intSocietyId INNER JOIN rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE tblsocietyinfo.intSocietyCode='" + ddlSocOrVen.Items[i].Value.ToString() + "' and (rolesmasterculturemap.RoleName = 'Admin')", dbc.con);
                                dbc.dr1 = das.ExecuteReader();
                                if (dbc.dr1.Read())
                                {
                                    //sendmail(dbc.dr1["Name"].ToString(), dbc.dr1["varPropertyId"].ToString(), invoiceid, lblFinalBill.Text.Replace("'", "\\'"), dbc.dr1["varEmail"].ToString());
                                    dbc.insert_tblnotifications(dbc.dr1["intSocietyCode"].ToString(), "text", "0", "0", dbc.dr1["intEmpCode"].ToString(), dbc.dr1["intRole"].ToString(), "New Invoice Generated by SocietyKatta ", "", "", "Unread", "");
                                }
                                dbc.con.Close();
                            }
                        }
                    }
                }
                else
                {
                }
                Response.Write("<script>alert('Invoice Created Successfully');window.location='Invoices.aspx';</script>");
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public override void VerifyRenderingInServerForm(Control Listview)
    {
        /* Verifies that the control is rendered */
    }
    public string listviewData(ListView gv)
    { 
        StringBuilder sb = new StringBuilder();
        StringWriter sw = new StringWriter(sb);
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gv.RenderControl(htw);

        return sb.ToString(); 
    }

    //call this send mail function on submit button click
    private string PopulateBody(string Name, string propertyid, string invoiceid, string finalbill, string email)
    {
        string body = string.Empty;
        using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/Invoice.html")))
        {
            body = reader.ReadToEnd();
        }
        body = body.Replace("{Name}", Name);
        body = body.Replace("{propertyid}", propertyid);
        body = body.Replace("{invoiceid}", invoiceid);

        body = body.Replace("{finalbill}", finalbill);
        body = body.Replace("{grid}", listviewData(lstInvoiceDetails));
        body = body.Replace("{email}", email);
        return body;
    }
    protected void sendmail(string name, string propertyid, string invoiceid, string finalbill, string email)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <support@societykatta.com>"), new MailAddress(email)))
            {
                mm.Subject = " Your Invoice Details";

                mm.Body = PopulateBody(name, propertyid, invoiceid, finalbill, email);

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
        catch (Exception rx)
        {
            Response.Write("<script>alert('" + rx.Message + "');window.location='Invoices.aspx';</script>");
        }
    }


    protected void ddlInvoiceFor_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlSocOrVen.Items.Clear();

        if (ddlInvoiceFor.SelectedIndex == 0)
        {
            ddlAllOrMultiple.Enabled = false;
        }
        else if (ddlInvoiceFor.SelectedIndex == 1)
        {             
            dbcs.con.Open();
            MySqlCommand das = new MySqlCommand("SELECT CONCAT(tblvendor.intVendorCode, '-', tblvendor.varName, '-', citymaster.CityName) AS vendor, tblvendor.intVendorCode FROM tblvendor INNER JOIN citymaster ON tblvendor.varCity = citymaster.CityId", dbcs.con);
            dbc.dr1 = das.ExecuteReader();
            while (dbc.dr1.Read())
            {
                ddlSocOrVen.Items.Add(new ListItem(dbc.dr1["vendor"].ToString(), dbc.dr1["intVendorCode"].ToString()));
                //ddlReportto.Items.FindByValue(dbc.dr1["varPropertyId"].ToString()).Selected = true;
            }
            ddlSocOrVen.DataBind();
            dbc.con.Close();
            ddlAllOrMultiple.Enabled = true;
        }
        else if (ddlInvoiceFor.SelectedIndex == 2)
        {
            dbc.con.Open();
            MySqlCommand das = new MySqlCommand("SELECT CONCAT(tblsocietyinfo.varName, '-', tblsocietyinfo.intSocietyCode, '-', citymaster.CityName) AS society, tblsocietyinfo.intSocietyCode FROM tblsocietyinfo INNER JOIN citymaster ON tblsocietyinfo.varCityId = citymaster.CityId", dbc.con);
            dbc.dr1 = das.ExecuteReader();
            while (dbc.dr1.Read())
            {
                ddlSocOrVen.Items.Add(new ListItem(dbc.dr1["society"].ToString(), dbc.dr1["intSocietyCode"].ToString()));
                //ddlReportto.Items.FindByValue(dbc.dr1["varPropertyId"].ToString()).Selected = true;
            }
            ddlSocOrVen.DataBind();
            dbc.con.Close();
            ddlAllOrMultiple.Enabled = true;
        }
    }
}