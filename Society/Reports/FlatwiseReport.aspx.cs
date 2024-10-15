using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Configuration;
using MySql.Data.MySqlClient;
using System.Web.Services;
using System.Globalization;

public partial class Society_Reports_FlatwiseReport : System.Web.UI.Page
{
    string datef, datet;
    MySql.Data.MySqlClient.MySqlCommand cmd, cmd1;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindLV("");
            string query = "SELECT DISTINCT   CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode ) AS Flat ,tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo,  ";
            query += "                 DATE_FORMAT(tblinvoice.varDateTime,'%d-%m-%Y') AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  ";
            query += "                      tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`,tblinvoiceforpersonnels.varPersonnelId ";
            query += "     FROM            tblinvoice INNER JOIN ";
            query += "                            tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN ";
            query += "                            tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN ";
            query += "                     tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN ";
            query += "                tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'";




            SqlDataSource1.SelectCommand = query;
        }

    }
    public DataTable GetPaidInvoiceDetails(string query)
    {
        dbc.con = new MySqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        MySqlDataAdapter ada = new MySqlDataAdapter(query, dbc.con);
        DataTable dtEmp = new DataTable();
        ada.Fill(dtEmp);
        return dtEmp;
    }
    private void BindLV(string SortExpression)
    {
        lstInvoices.DataSource = GetPaidInvoiceDetails("SELECT   (tblmastersocietywing.varWingName) as varWingName,  (tblproperty.varPropertyCode) AS Flat, tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo,  DATE_FORMAT(tblinvoice.varDateTime, '%d-%m-%Y') AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`, tblinvoiceforpersonnels.varPersonnelId       FROM            tblinvoice INNER JOIN   tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  " + SortExpression);
        lstInvoices.DataBind();
    }



    protected void lstInvoices_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "view")
        {
            string[] cmdArgs = e.CommandArgument.ToString().Split(':');
            Cache["InvoiceId"] = cmdArgs[0].ToString();
            Cache["PersonnelId"] = cmdArgs[1].ToString();
            Response.Redirect("~/Society/Accounts/ViewInvoices.aspx", false);
        }
    }
    protected void lstInvoices_Sorting(object sender, ListViewSortEventArgs e)
    {

        ImageButton imFlat = lstInvoices.FindControl("imFlat") as ImageButton;
        ImageButton imOwner = lstInvoices.FindControl("imOwner") as ImageButton;


        string DefaultSortIMG = "~/Designs/Outside/images/asc.png";
        string imgUrl = "~/Designs/Outside/images/desc.png";

        string SortDirection = "ASC";

        if (ViewState["SortExpression"] != null)
        {
            if (ViewState["SortExpression"].ToString() == e.SortExpression)
            {
                ViewState["SortExpression"] = null;
                // SortDirection = "DESC";
                imgUrl = DefaultSortIMG;
            }
            else
            {
                ViewState["SortExpression"] = e.SortExpression;
            }
        }
        else
        {
            ViewState["SortExpression"] = e.SortExpression;
        }
        switch (e.SortExpression)
        {
            case "Flat"://comnd arg name
                if (imOwner != null)
                    imOwner.ImageUrl = DefaultSortIMG;
                if (imFlat != null)
                    imFlat.ImageUrl = imgUrl;
                break;
            case "Name":
                if (imFlat != null)
                    imFlat.ImageUrl = DefaultSortIMG;
                if (imOwner != null)
                    imOwner.ImageUrl = imgUrl;
                break;


        }
        // BindLV(" order by " + e.SortExpression + " " + SortDirection);
        BindLV(" order by " + e.SortExpression + " " + ((ViewState["SortExpression"] != null) ? "ASC" : "DESC"));
    }
    double totl = 0;

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtStartDate.Text == "")
            {
                ScriptManager.RegisterStartupScript(
                      this,
                      this.GetType(),
                      "MessageBox",
                       "alert('Please Enter From Date....');", true);
            }
            else if (txtEndDate.Text == "")
            {
                ScriptManager.RegisterStartupScript(
                      this,
                      this.GetType(),
                      "MessageBox",
                       "alert('Please Enter To Date....');", true);

            }
            else {
                string temp = string.Empty;

                dbc.oDt = new System.Data.DataTable();
                //datef = Convert.ToDateTime(txtStartDate.Text).ToString("yyyy-MM-dd");
                //datet = Convert.ToDateTime(txtEndDate.Text).ToString("yyyy-MM-dd");

                datef = Convert.ToDateTime(DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd");
                datet = Convert.ToDateTime(DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd");

                // datef = DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                // datet = DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);

                dbc.con.Close();
                dbc.con.Open();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT   tblmastersocietywing.varWingName as varWingName ,  tblproperty.varPropertyCode AS Flat, tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo,  DATE_FORMAT(tblinvoice.varDateTime, '%d-%m-%Y') AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`, tblinvoiceforpersonnels.varPersonnelId       FROM            tblinvoice INNER JOIN   tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'    and  tblinvoice.varDateTime BETWEEN '" + datef + "' and '" + datet + "' order by tblinvoice.intid desc", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter ad = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                ad.Fill(dbc.oDt);



                lstInvoices.DataSource = dbc.oDt;
                lstInvoices.DataBind();
                dbc.con.Close();
                dbc.oDt.Dispose();
                cmd.Dispose();

                txtEndDate.Text = "";
                txtStartDate.Text = "";
            }

        }
        catch (Exception ex)
        {
            cmd.Dispose();
            dbc.con.Close();
            string exp = ex.Message;
            //Response.Write("<script>alert('Pls Try Again...');window.location='SalesReport.aspx';</script>");
        }
    }
    public void getListViewMasterDataRadio(string wherecondition)
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT   (tblmastersocietywing.varWingName) as varWingName,  tblproperty.varPropertyCode AS Flat, tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo, DATE_FORMAT(tblinvoice.varDateTime, '%d-%m-%Y') AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding, tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`, tblinvoiceforpersonnels.varPersonnelId       FROM            tblinvoice INNER JOIN   tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and " + wherecondition + " order by tblinvoice.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            lstInvoices.DataSource = dt;
            lstInvoices.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
           // cmd.Dispose();
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
   
    protected void rgbName_CheckedChanged(object sender, EventArgs e)
    {
        if (rgbName.Checked == true)
        {
            divSearchbyDate.Visible = false;
            divsearchbyname.Visible = true;
               getListViewMasterDataRadio(" tblproperty.varName = "+txtPropertyName.Text+" ");
        }
        else if (rgbdate.Checked == true)
        {
            divSearchbyDate.Visible = true;
            divsearchbyname.Visible = false;
            // getListViewMasterDataRadio(" tblproperty.varPropertyCode = " + txtPropertyName.Text + " ");
        }

        else
        {
            divSearchbyDate.Visible = true;
            divsearchbyname.Visible = false;
            BindLV("");
        }
    }

    //search by text value
    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static List<string> GetCompletionList(string prefixText, int count, string contextKey)
    {
        String connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(connStr);
        con.Open();
        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT distinct  (tblmastersocietywing.varWingName) as varWingName,  (tblproperty.varPropertyCode) AS Flat, tblproperty.varName AS Name FROM            tblinvoice INNER JOIN   tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where  tblproperty.varName like '%" + prefixText + "%'", con);
        //     cmd.Parameters.AddWithValue("@Name", prefixText);
        MySql.Data.MySqlClient.MySqlDataAdapter da = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        int j = 0;
        List<string> CompanyName = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            CompanyName.Add(dt.Rows[i][2].ToString());
            //  CompanyName[j++] =dt.Rows[i][0].ToString();
        }
        con.Close();
        return CompanyName;
    }
    protected void btnPropertySearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtPropertyName.Text == "")
            {
                ScriptManager.RegisterStartupScript(
                          this,
                          this.GetType(),
                          "MessageBox",
                           "alert('Please Enter  Name....');", true);
            }
            else
            {               
                getPropertydocumentData(txtPropertyName.Text);
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getPropertydocumentData(string Name)
    {
        try
        {
            DataTable dtdoc = new DataTable();
            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoc = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoc = new MySql.Data.MySqlClient.MySqlCommand("SELECT   (tblmastersocietywing.varWingName) as varWingName,  tblproperty.varPropertyCode AS Flat, tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo, DATE_FORMAT(tblinvoice.varDateTime, '%d-%m-%Y') AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding, tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`, tblinvoiceforpersonnels.varPersonnelId       FROM            tblinvoice INNER JOIN   tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where     tblproperty.varName='" + Name + "' ", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoc = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoc);
            adpdoc.Fill(dtdoc);

            lstInvoices.DataSource = dtdoc;
            lstInvoices.DataBind();
            dbc.con.Close();

        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
}