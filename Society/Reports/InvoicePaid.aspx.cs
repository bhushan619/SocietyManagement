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

public partial class Society_Reports_InvoicePaid : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindLV("");
            string query = "SELECT DISTINCT       CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode ) AS Flat ,tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo,   ";
            query += "    DATE_FORMAT(tblinvoice.varDateTime,'%d-%m-%Y') AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,   ";
            query += "      tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`,tblinvoiceforpersonnels.varPersonnelId  ";
            query += "      FROM            tblinvoice INNER JOIN  ";
            query += "       tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  ";
            query += "      tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN  ";
            query += "      tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN  ";
            query += "     tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'    ";


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
        lstInvoices.DataSource = GetPaidInvoiceDetails("SELECT DISTINCT  CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) AS Flat, tblproperty.varName AS Name, tblinvoice.varInvoiceId AS InvoiceNo,  DATE_FORMAT(tblinvoice.varDateTime, '%d-%m-%Y') AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`, tblinvoiceforpersonnels.varPersonnelId       FROM            tblinvoice INNER JOIN   tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN  tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId = '"+rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)+ "' and   tblinvoiceforpersonnels.varPaymentStatus='Paid' " + SortExpression);
        lstInvoices.DataBind();
    }


    //protected void lstInvoicepaid_Sorting(object sender, ListViewSortEventArgs e)
    //{
    //    ImageButton imEmpID = lstInvoicepaid.FindControl("imEmpID") as ImageButton;
    //    ImageButton imEmpName = lstInvoicepaid.FindControl("imEmpName") as ImageButton;

    //    string DefaultSortIMG = "~/Designs/Outside/images/asc.png";
    //    string imgUrl = "~/Designs/Outside/images/desc.png";

    //    string SortDirection = "ASC";

    //    if (ViewState["SortExpression"] != null)
    //    {
    //        if (ViewState["SortExpression"].ToString() == e.SortExpression)
    //        {
    //            ViewState["SortExpression"] = null;
    //           // SortDirection = "DESC";
    //            imgUrl = DefaultSortIMG;
    //        }
    //        else
    //        {
    //            ViewState["SortExpression"] = e.SortExpression;
    //        }
    //    }
    //    else
    //    {
    //        ViewState["SortExpression"] = e.SortExpression;
    //    }
    //    switch (e.SortExpression)
    //    {
    //        case "intId":
    //            if (imEmpName != null)
    //                imEmpName.ImageUrl = DefaultSortIMG;
    //            if (imEmpID != null)
    //                imEmpID.ImageUrl = imgUrl;
    //            break;
    //        case "varPersonnelId":
    //            if (imEmpID != null)
    //                imEmpID.ImageUrl = DefaultSortIMG;
    //            if (imEmpName != null)
    //                imEmpName.ImageUrl = imgUrl;
    //            break;
    //    }
    //    // BindLV(" order by " + e.SortExpression + " " + SortDirection);
    //    BindLV(" order by " + e.SortExpression + " " + ((ViewState["SortExpression"] != null) ? "ASC" : "DESC"));
    //}
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
}