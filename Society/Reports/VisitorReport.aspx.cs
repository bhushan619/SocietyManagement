using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Data;
using System.IO;

public partial class Society_Reports_VisitorReport : System.Web.UI.Page
{
   // DateTime datef, datet;

    string datef, datet;
    MySql.Data.MySqlClient.MySqlCommand cmd, cmd1;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.IsPostBack)
        {
            TabName.Value = Request.Form[TabName.UniqueID];

        }
        if (!IsPostBack)
        {
            getvisitordata();

            string queryinout = "SELECT intId, CONCAT(FirstName, ' ', LastName) AS Name, ContactNumber, Email, VehicleNo, ArrivedFrom, InTime, OutTime, PurposeOFVisit, Comments, CreatedDate, IsActive FROM visitors where varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ORDER BY intId DESC   ";

            SqlDataSourceOut.SelectCommand = queryinout;

            string query = "SELECT CONCAT(tblproperty.varName, '- (', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')') AS Name, tblinoutstatus.varPersonnelId, tblinoutstatus.varSocietyId, tblinoutstatus.varStatus,tblproperty.varMobile AS Mobile, tblproperty.varEmail AS Email, tblproperty.varPhoneNo AS Phone FROM tblinoutstatus INNER JOIN tblproperty ON tblinoutstatus.varPersonnelId = tblproperty.varPropertyId AND tblinoutstatus.varSocietyId = tblproperty.varSocietyId AND tblinoutstatus.intRoleId = tblproperty.intRoleId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblproperty.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ORDER BY tblinoutstatus.intId DESC ";

            SqlDataSource1.SelectCommand = query;

            string queryemp = "SELECT tblinoutstatus.varStatus, tblinoutstatus.varPersonnelId, CONCAT(tblsocietypersonnel.varEmpName, ' ( ', rolesmasterculturemap.RoleName, ' ) ') AS Name, tblsocietypersonnel.varMbPrimary AS Mobile, tblsocietypersonnel.varPrimaryEmail AS Email, tblsocietypersonnel.intSocietyId FROM tblinoutstatus INNER JOIN tblsocietypersonnel ON tblinoutstatus.varSocietyId = tblsocietypersonnel.intSocietyId AND tblinoutstatus.varPersonnelId = tblsocietypersonnel.intEmpCode AND tblinoutstatus.intRoleId = tblsocietypersonnel.intRole INNER JOIN rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE (tblsocietypersonnel.intSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') ORDER BY tblinoutstatus.intId DESC";
            SqlDataSourceemp.SelectCommand = queryemp;
                                                    
        }
    }
    public void getvisitordata()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Close();
            dbc.con.Open();
            dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, CONCAT(FirstName, ' ', LastName) AS Name, ContactNumber, Email, VehicleNo, ArrivedFrom, InTime, OutTime, PurposeOFVisit, Comments, CreatedDate, IsActive FROM visitors where varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  ORDER BY intId DESC", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter ad = new MySql.Data.MySqlClient.MySqlDataAdapter(dbc.cmd);
            ad.Fill(dt);
            lstVisitors.DataSource = dt;
            lstVisitors.DataBind();
            dbc.con.Close();
          dt.Dispose();
            cmd.Dispose();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //Response.Write("<script>alert('Pls Try Again...');window.location='SalesReport.aspx';</script>");
        }
    }
    protected void btnview_Click(object sender, EventArgs e)
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
                datef = Convert.ToDateTime(txtStartDate.Text).ToString("yyyy-MM-dd");
                datet = Convert.ToDateTime(txtEndDate.Text).ToString("yyyy-MM-dd");

                // datef = DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                // datet = DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                dbc.con.Close();
                dbc.con.Open();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, CONCAT(FirstName, ' ', LastName) AS Name, ContactNumber, Email, VehicleNo, ArrivedFrom, InTime, OutTime, PurposeOFVisit, Comments, DATE_FORMAT(CreatedDate,'%d-%m-%Y') as CreatedDate, IsActive FROM visitors where varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and  (CreatedDate AS DATE) BETWEEN '" + datef + "' and '" + datet + "' ORDER BY intId DESC", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter ad = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                ad.Fill(dbc.oDt);
                lstVisitors.DataSource = dbc.oDt;
                lstVisitors.DataBind();
                dbc.con.Close();
                dbc.oDt.Dispose();
                cmd.Dispose();
                txtEndDate.Text = "";
                txtStartDate.Text = "";
            }

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //Response.Write("<script>alert('Pls Try Again...');window.location='SalesReport.aspx';</script>");
        }
    }
}