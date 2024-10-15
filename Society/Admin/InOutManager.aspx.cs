using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

public partial class Society_Admin_InOutManager : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) == null)
        {
            Response.Redirect("~/Home/Login.aspx", false);
        }
        if (this.IsPostBack)
        {
            TabName.Value = Request.Form[TabName.UniqueID];

        }
        if (!IsPostBack)
        {
            lstVisitors.DataBind();
            lstEmployee.DataBind();
            lstProperty.DataBind();

            string query = "  SELECT intId, CONCAT(FirstName, ' ', LastName) AS Name, ContactNumber, Email, VehicleNo, ArrivedFrom, InTime, OutTime, PurposeOFVisit, Comments, CreatedDate, IsActive FROM visitors where varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ORDER BY intId DESC";

            SqlDataSourceOut.SelectCommand = query;

            string query1 = "  SELECT CONCAT(tblproperty.varName, '- (', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')') AS Name, tblinoutstatus.varPersonnelId, tblinoutstatus.varSocietyId, tblinoutstatus.varStatus,tblproperty.varMobile AS Mobile, tblproperty.varEmail AS Email, tblproperty.varPhoneNo AS Phone FROM tblinoutstatus INNER JOIN tblproperty ON tblinoutstatus.varPersonnelId = tblproperty.varPropertyId AND tblinoutstatus.varSocietyId = tblproperty.varSocietyId AND tblinoutstatus.intRoleId = tblproperty.intRoleId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblproperty.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ORDER BY tblinoutstatus.intId DESC";

            SqlDataSource1.SelectCommand = query1;

            string queryemp = "  SELECT tblinoutstatus.varStatus, tblinoutstatus.varPersonnelId, CONCAT(tblsocietypersonnel.varEmpName, ' ( ', rolesmasterculturemap.RoleName, ' ) ') AS Name, tblsocietypersonnel.varMbPrimary AS Mobile, tblsocietypersonnel.varPrimaryEmail AS Email, tblsocietypersonnel.intSocietyId FROM tblinoutstatus INNER JOIN tblsocietypersonnel ON tblinoutstatus.varSocietyId = tblsocietypersonnel.intSocietyId AND tblinoutstatus.varPersonnelId = tblsocietypersonnel.intEmpCode AND tblinoutstatus.intRoleId = tblsocietypersonnel.intRole INNER JOIN rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE (tblsocietypersonnel.intSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') ORDER BY tblinoutstatus.intId DESC";

            SqlDataSourceEmp.SelectCommand = queryemp;


        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            dbc.con.Open();
            dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand();
            dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO visitors ( varSocietyId ,FirstName, LastName, ContactNumber, Email, VehicleNo, ArrivedFrom, InTime, OutTime, PurposeOFVisit, Comments, CreatedDate, IsActive) VALUES ( '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "', '" + txtFirstName.Text.Replace("'", "\\'") +"','" + txtLastName.Text.Replace("'", "\\'") +"','" + txtContactNumber.Text.Replace("'", "\\'") +"','" + txtEmail.Text.Replace("'", "\\'") +"','" + txtVehicleNumber.Text.Replace("'", "\\'") +"','" + txtArrivedFrom.Text.Replace("'", "\\'") +"', '" + DateTime.ParseExact(DateTime.UtcNow.AddMinutes(330).ToString("HH:mm:ss"), "HH:mm:ss", CultureInfo.InvariantCulture).ToString("HH:mm:ss") + "', '00:00:00', '" + txtPurpose.Text.Replace("'", "\\'") +"', '" + txtComments.Text.Replace("'", "\\'") +"', '" + DateTime.ParseExact(DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy"), "dd-MM-yyyy", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "', 1) ", dbc.con);
            if ((int)dbc.cmd.ExecuteNonQuery() == 1)
            {
                dbc.con.Close();
                MessageDisplay(Resources.Messages.Added, "alert alert-success");
            }
            else
            {
                dbc.con.Close();
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            }
            clear();
            lstVisitors.DataBind();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
        }
    }
    public void clear()
    {
        txtFirstName.Text = "";
        txtLastName.Text = "";
        txtArrivedFrom.Text = "";
        txtComments.Text = "";
        txtContactNumber.Text = "";
        txtVehicleNumber.Text = "";
        txtPurpose.Text = "";
        txtEmail.Text = "";
    }


    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }

    protected void lstEmployeeProperty_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        int status = 0;
        if (Convert.ToBoolean(e.CommandArgument.ToString().Split(':')[0]))
        {
            status = 0;
        }
        else
        {
            status = 1;
        }
        dbc.con.Open();
        dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand();
        dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblinouthistory(varSocietyId, varPersonnelId, varInOut, varDate, varTime) VALUES ('" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "', '" + e.CommandArgument.ToString().Split(':')[1] + "', " + status + ", '" + DateTime.ParseExact(DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy"), "dd-MM-yyyy", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "', '" + DateTime.ParseExact(DateTime.UtcNow.AddMinutes(330).ToString("HH:mm:ss"), "HH:mm:ss", CultureInfo.InvariantCulture).ToString("HH:mm:ss") + "')", dbc.con);
        dbc.cmd.ExecuteNonQuery();
        dbc.con.Close();

        dbc.con.Open();
        dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand();
        dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblinoutstatus SET varStatus= " + status + " WHERE varPersonnelId ='" + e.CommandArgument.ToString().Split(':')[1] + "' AND varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'", dbc.con);
        if ((int)dbc.cmd.ExecuteNonQuery() == 1)
        {
            dbc.con.Close();
            MessageDisplay(Resources.Messages.Added, "alert alert-success");
        }
        else
        {
            dbc.con.Close();
            MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
        clear();
        lstEmployee.DataBind();
        lstProperty.DataBind();
    }

    protected void lstVisitors_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        dbc.con.Open();
        dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand();
        dbc.cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE visitors SET  OutTime='" + DateTime.UtcNow.AddMinutes(330).ToString("HH:mm:ss") + "' WHERE intId=" + e.CommandArgument + "", dbc.con);
        if ((int)dbc.cmd.ExecuteNonQuery() == 1)
        {
            dbc.con.Close();
            MessageDisplay(Resources.Messages.Added, "alert alert-success");
        }
        else
        {
            dbc.con.Close();
            MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
        clear();
        lstVisitors.DataBind();
    }
}