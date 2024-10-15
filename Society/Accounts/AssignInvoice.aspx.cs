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

public partial class Society_Accounts_AssignInvoice : System.Web.UI.Page
{
    DataTable dtInvoice;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
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
            dbc.con.Close();
            dbc.con.Open();
            MySqlCommand da = new MySqlCommand("SELECT intId, intSocietyCode, varRegistrationNo, varName, varSAddress, varSPhone, varSMobile, varSEmail, varSFax, varCountryId, varStateId, varCityId, varPin, varConstructedby, varCompany, varCompanyAddress, varContactPerson, varContactMobile, varContactPhone, varContactEmail, varConstuctionYear, varTotalArea, varTotalWings, varIsActive,  statemaster.StateName, citymaster.CityName FROM tblsocietyinfo INNER JOIN  statemaster ON tblsocietyinfo.varStateId = statemaster.StateId INNER JOIN citymaster ON tblsocietyinfo.varCityId = citymaster.CityId  WHERE intSocietyCode='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'", dbc.con);
            dbc.dr1 = da.ExecuteReader();
            if (dbc.dr1.Read())
            {
                lblSocietyName.Text = dbc.dr1["varName"].ToString();
                lblSocietyAddress.Text = dbc.dr1["varSAddress"].ToString();
                lblSocietyState.Text = dbc.dr1["StateName"].ToString();
                lblSocietyCity.Text = dbc.dr1["CityName"].ToString();
                lblSocietyPIN.Text = dbc.dr1["varPin"].ToString();
            }
            dbc.con.Close();
            dbc.dr1.Dispose();
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


            ddlWing.DataSource = dbc.GetSocietyWingMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlWing.DataTextField = "varWingName";
            ddlWing.DataValueField = "intId";
            ddlWing.DataBind();
            ddlWing.Items.Insert(0, new ListItem(":: Select Wing ::", ""));
        }
        catch(Exception ex)
        {
            dbc.con.Close();
            dbc.dr1.Dispose();
            string exp = ex.Message;
        }
    }

    protected void ddlWing_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlProperty.Items.Clear();

        if (ddlWing.SelectedIndex == 0)
        {
            ddlAllOrMultiple.Enabled = false;
        }
        else
        {
            dbc.con.Open();
            MySqlCommand das = new MySqlCommand("SELECT tblproperty.intId, tblproperty.varPropertyId, tblproperty.intRoleId, CONCAT(tblproperty.varName,' ( ', tblmastersocietywing.varWingName,' - ', tblproperty.varPropertyCode,' )')   AS Name, tblproperty.varMobile, tblproperty.varEmail, tblproperty.intIsActive, tblproperty.varSocietyId FROM      tblproperty INNER JOIN         tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE        (tblproperty.intIsActive = 1) AND tblproperty.varSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblproperty.intWingId=" + ddlWing.SelectedValue + "", dbc.con);
            dbc.dr1 = das.ExecuteReader();
            while (dbc.dr1.Read())
            {
                ddlProperty.Items.Add(new ListItem(dbc.dr1["Name"].ToString(), dbc.dr1["varPropertyId"].ToString()));
                //ddlReportto.Items.FindByValue(dbc.dr1["varPropertyId"].ToString()).Selected = true;
            }
            ddlProperty.DataBind();
            dbc.con.Close();
            ddlAllOrMultiple.Enabled = true;
        }
    }

    protected void ddlAllOrMultiple_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAllOrMultiple.SelectedItem.ToString() == "All")
        {
            ddlProperty.Disabled = true;
        }
        else if (ddlAllOrMultiple.SelectedItem.ToString() == "Multiple")
        {
            ddlProperty.Disabled = false;
        }
        else
        {
            ddlProperty.Disabled = false;
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


                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("sp_insert_Invoice", dbc.con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("varOrderNo", "NA"));
                cmd.Parameters.Add(new MySqlParameter("varDateTime", Convert.ToDateTime(DateTime.ParseExact(lblDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd")));
                cmd.Parameters.Add(new MySqlParameter("intFromSocietyId", rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)));
                cmd.Parameters.Add(new MySqlParameter("intFromRole", rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)));
                cmd.Parameters.Add(new MySqlParameter("intFromId", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value)));
                cmd.Parameters.Add(new MySqlParameter("varSubTotal", lblSubBill.Text));
                cmd.Parameters.Add(new MySqlParameter("varDiscount", "NA"));
                cmd.Parameters.Add(new MySqlParameter("varTax", "NA"));
                cmd.Parameters.Add(new MySqlParameter("varOther", "NA"));
                cmd.Parameters.Add(new MySqlParameter("varTotal", lblFinalBill.Text));
                string invoiceid = (string)cmd.ExecuteScalar();
                dbc.con.Close();

                foreach (DataRow drow in dtInvoice.Rows)
                {
                    dbc.con.Open();
                    dbc.cmd = new MySqlCommand("INSERT INTO tblinvoicedetails(varInvoiceId, varParticulars, varAttachment, varAmount) VALUES ('" + invoiceid + "','" + drow["Particulars"].ToString() + "','NA','" + drow["Amount"].ToString() + "')", dbc.con);
                    dbc.cmd.ExecuteNonQuery();
                    dbc.con.Close();
                }
                string propertyRoleid = dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner");

                if (ddlAllOrMultiple.SelectedItem.ToString() == "All")
                {
                    dbc.con.Open();
                    MySqlCommand das = new MySqlCommand("SELECT tblproperty.intId, tblproperty.varPropertyId, tblproperty.intRoleId, CONCAT(tblproperty.varName,' ( ', tblmastersocietywing.varWingName,' - ', tblproperty.varPropertyCode,' )')   AS Name, tblproperty.varMobile, tblproperty.varEmail, tblproperty.intIsActive, tblproperty.varSocietyId FROM      tblproperty INNER JOIN         tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE        (tblproperty.intIsActive = 1) AND tblproperty.varSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblproperty.intWingId=" + ddlWing.SelectedValue + "", dbc.con);
                    dbc.dr1 = das.ExecuteReader();
                    while (dbc.dr1.Read())
                    {
                        dbc.con1.Open();
                        dbc.cmd = new MySqlCommand("INSERT INTO tblinvoiceforpersonnels(  varSocietyId, varInvoiceId, intRoleId, varPersonnelId , `varRecieved`, `varOutstanding`, `varPaymentStatus`, `varTransactionId`, `varTransactionStatus`, `varPaymode`, `varInvoiceStatus`) VALUES ( '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "','" + invoiceid + "','" + propertyRoleid + "','" + dbc.dr1["varPropertyId"].ToString() + "','0','" + lblFinalBill.Text.Replace("'", "\\'") +"','Pending','0','Started','NA','Started')", dbc.con1);
                        dbc.cmd.ExecuteNonQuery();
                        dbc.con1.Close();
                        // sendmail(dbc.dr1["Name"].ToString(), dbc.dr1["varPropertyId"].ToString(), invoiceid,lblFinalBill.Text.Replace("'", "\\'"), dbc.dr1["varEmail"].ToString());
              
                        dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.dr1["varPropertyId"].ToString(), dbc.dr1["intRoleId"].ToString(), "New Invoice Generated by " + dbc.get_PropertyOwnerName(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value)), "", "", "Unread", "");
     
                     }
                    dbc.con.Close();
                }
                else if (ddlAllOrMultiple.SelectedItem.ToString() == "Multiple")
                {
                    for (int i = 0; i <= ddlProperty.Items.Count - 1; i++)
                    {
                        if (ddlProperty.Items[i].Selected)
                        {

                            dbc.con.Open();
                            dbc.cmd = new MySqlCommand("INSERT INTO tblinvoiceforpersonnels(  varSocietyId, varInvoiceId, intRoleId, varPersonnelId , `varRecieved`, `varOutstanding`, `varPaymentStatus`, `varTransactionId`, `varTransactionStatus`, `varPaymode`, `varInvoiceStatus`) VALUES ( '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "','" + invoiceid + "','" + propertyRoleid + "','" + ddlProperty.Items[i].Value.ToString() + "','0','" + lblFinalBill.Text.Replace("'", "\\'") +"','Pending','0','Started','NA','Started')", dbc.con);
                            dbc.cmd.ExecuteNonQuery();
                            dbc.con.Close();

                            dbc.con.Open();
                            MySqlCommand das = new MySqlCommand("SELECT tblproperty.intId, tblproperty.varPropertyId, tblproperty.intRoleId, CONCAT(tblproperty.varName,' ( ', tblmastersocietywing.varWingName,' - ', tblproperty.varPropertyCode,' )')   AS Name, tblproperty.varMobile, tblproperty.varEmail, tblproperty.intIsActive, tblproperty.varSocietyId FROM      tblproperty INNER JOIN         tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE        (tblproperty.intIsActive = 1) AND tblproperty.varPropertyId  = '" + ddlProperty.Items[i].Value.ToString() + "'", dbc.con);
                            dbc.dr1 = das.ExecuteReader();
                            if (dbc.dr1.Read())
                            {
                              //  sendmail(dbc.dr1["Name"].ToString(), dbc.dr1["varPropertyId"].ToString(), invoiceid, lblFinalBill.Text.Replace("'", "\\'"), dbc.dr1["varEmail"].ToString());
                                dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.dr1["varPropertyId"].ToString(), dbc.dr1["intRoleId"].ToString(), "New Invoice Generated by " + dbc.get_PropertyOwnerName(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value)), "", "", "Unread", "");
                            }
                            dbc.con.Close();
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
    protected void sendmail(string name,  string propertyid, string invoiceid, string finalbill, string email)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <support@societykatta.com>"), new MailAddress(email)))
            {
                mm.Subject = " Your Invoice Details";

                mm.Body = PopulateBody(name, propertyid,invoiceid, finalbill, email);

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
     
}