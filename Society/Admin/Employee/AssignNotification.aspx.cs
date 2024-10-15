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
using System.Globalization;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;
using System.Net.Mail;
using System.Net;

public partial class Society_Admin_Employee_AssignNotification : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getDepartmentData();
            getListViewMasterData();
        }

    }
    public void getDepartmentData()
    {
        try
        {
            dbc.con.Open();
            dbc.cmd = new MySqlCommand("SELECT DISTINCT CONCAT(rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName) AS Employee, CONCAT(tblsocietypersonnel.intRole, '-', tblsocietypersonnel.intEmpCode) AS Value FROM rolefeaturesmap INNER JOIN rolesmaster ON rolefeaturesmap.RoleId = rolesmaster.RoleId INNER JOIN rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId INNER JOIN featuresmaster ON rolefeaturesmap.FeatureId = featuresmaster.FeatureId INNER JOIN tblsocietypersonnel ON rolefeaturesmap.varSocietyId = tblsocietypersonnel.intSocietyId AND rolefeaturesmap.RoleId = tblsocietypersonnel.intRole WHERE(rolefeaturesmap.IsActive = 1) AND (rolefeaturesmap.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') AND(rolefeaturesmap.RoleId <> 2)", dbc.con);
            dbc.dataAdapter = new MySqlDataAdapter(dbc.cmd);
            dbc.oDt1 = new DataTable();
            dbc.dataAdapter.Fill(dbc.oDt1);

            ddlRole.DataSource = dbc.oDt1;
            ddlRole.DataTextField = "Employee";
            ddlRole.DataValueField = "Value";
            ddlRole.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }

    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT CONCAT(rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName) AS EMP, tblsocietypersonnel.varMbPrimary AS Mob FROM tblsocietypersonnel INNER JOIN tblassignnotifications ON tblsocietypersonnel.intSocietyId = tblassignnotifications.varSocietyId AND tblsocietypersonnel.intRole = tblassignnotifications.intRoleId INNER JOIN rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE(tblassignnotifications.varSocietyId ='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' )", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int insert_ok = dbc.update_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), ddlRole.SelectedValue.Split('-')[1], Convert.ToInt32(ddlRole.SelectedValue.Split('-')[0]));

            if (insert_ok == 1)
            {
                MessageDisplay(Resources.Messages.Added, "alert alert-success");
                getListViewMasterData();
                ddlRole.SelectedIndex = 0;
            }

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}