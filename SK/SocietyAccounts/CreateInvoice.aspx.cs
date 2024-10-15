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
using System.Web.Services;

public partial class SK_SocietyAccounts_CreateInvoice : System.Web.UI.Page
{
    static string EditTypeId = string.Empty;
    static string Propertyid = string.Empty;
    string parkingslots = string.Empty;
    DataTable dtInvoice;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    DateTime datestart, dateend;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getLoadData();
            lstInvoiceDetails.DataBind();
            dtInvoice = new DataTable();
            MakeDataTable();

        }
        else
        {
            dtInvoice = (DataTable)ViewState["dtInvoice"];
        }
        ViewState["dtInvoice"] = dtInvoice;
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
            string exp = ex.Message;
        }
    }


    public void getLoadData()
    {
        try
        {
            lblSocietyName.Text = "Societykatta.com";
            lblSocietyAddress.Text = "Flat No. 1, Akshay Chambers,<br> Samarth Colony,<br> Near Prabhat Chowk, Jalgaon.";
            lblSocietyState.Text = "Maharashtra";
            lblSocietyCity.Text = "Jalgaon";
            lblSocietyPIN.Text = "425001";

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
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }


    }

    protected void btnAddToInvoice_Click(object sender, EventArgs e)
    {
        try
        {
            datestart = DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);

            if (datestart > DateTime.UtcNow)
            {
                lblDate.Text = txtDOB.Text;
                dtInvoice.Rows.Add("", "", txtParticulars.Text.Replace("'", "\\'"), txtAmount.Text);
                lstInvoiceDetails.DataSource = dtInvoice;
                lstInvoiceDetails.DataBind();
                lblSubBill.Text = Math.Round((Convert.ToDouble(lblSubBill.Text) + Convert.ToDouble(txtAmount.Text)), 2).ToString();
                lblFinalBill.Text = lblSubBill.Text;
                txtParticulars.Text = "";
                txtAmount.Text = "";
            }
            else if (datestart.ToString("dd-MM-yyyy").Equals(DateTime.UtcNow.ToString("dd-MM-yyyy")))
            {
                lblDate.Text = txtDOB.Text;
                dtInvoice.Rows.Add("", "", txtParticulars.Text.Replace("'", "\\'"), txtAmount.Text);
                lstInvoiceDetails.DataSource = dtInvoice;
                lstInvoiceDetails.DataBind();
                lblSubBill.Text = Math.Round((Convert.ToDouble(lblSubBill.Text) + Convert.ToDouble(txtAmount.Text)), 2).ToString();
                lblFinalBill.Text = lblSubBill.Text;
                txtParticulars.Text = "";
                txtAmount.Text = "";
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.CurrectDate, "alert alert-danger");
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void lstInvoiceDetails_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ':' });
            string id = commandArgs[0];
            string amount = commandArgs[1];

            if (e.CommandName == "remove")
            {

                ListViewItem gvr = (ListViewItem)(((LinkButton)e.CommandSource).NamingContainer);
                int RemoveAt = gvr.DataItemIndex;
                dtInvoice = (DataTable)ViewState["dtInvoice"];
                dtInvoice.Rows.RemoveAt(RemoveAt);
                dtInvoice.AcceptChanges();
                ViewState["dtInvoice"] = dtInvoice;
                lstInvoiceDetails.DataSource = dtInvoice;
                lstInvoiceDetails.DataBind();

                lblSubBill.Text = Math.Round((Convert.ToDouble(lblSubBill.Text) - Convert.ToDouble(amount)), 2).ToString();
                lblFinalBill.Text = lblSubBill.Text;
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (dtInvoice.Rows.Count == 0)
        {
            MessageDisplay(Resources.ErrorMessages.AddParticulars, "alert alert-danger");
            lstInvoiceDetails.DataBind();
        }
        else
        {
            Cache["dateInvoice"] = lblDate.Text;
            Cache["billAmount"] = lblFinalBill.Text;
            Cache["dtInvoice"] = dtInvoice;
            Response.Redirect("~/SK/SocietyAccounts/AssignInvoice.aspx", false);
        }
    }

    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
}