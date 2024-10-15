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
using System.Net.Mail;
using System.Net;

public partial class SK_Employee_ViewEmpolyee : System.Web.UI.Page
{
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    static string Employeid = string.Empty;
    static string EditEmpId = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getListViewMasterData();

        }
    }
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT        rolesmaster.RoleName, tblskdepartment.varDepartmentName, tblskpersonnel.intEmpCode, tblskpersonnel.intId, tblskpersonnel.varEmpName,     tblskpersonnel.varMaritalStatus, tblskpersonnel.varFatherHusband, tblskpersonnel.varDateOfJoin, tblskpersonnel.varDOB, tblskpersonnel.varGender,  tblskpersonnel.varMbPrimary, tblskpersonnel.varMbOther, tblskpersonnel.varEmailOther, tblskpersonnel.varPANNo, tblskpersonnel.varPFNo,    tblskpersonnel.varESINo, tblskpersonnel.varPin, tblskpersonnel.varAddress, tblskpersonnel.varPermanentAddress, tblskpersonnel.varPrimaryEmail,    tblskpersonnel.varUsername, tblskpersonnel.varPassword, tblskpersonnel.varMobile, tblskpersonnel.varImage, tblskpersonnel.intIsActive,      tblskpersonnel.intCreatedBy, tblskpersonnel.varCreatedDate, countrymaster.CountryName, statemaster.StateName, citymaster.CityName,    tblskpersonnel.intRole   FROM            tblskpersonnel INNER JOIN    tblskdepartment ON tblskpersonnel.intDeptId = tblskdepartment.intId INNER JOIN   countrymaster ON tblskpersonnel.intCountry = countrymaster.CountryId INNER JOIN      statemaster ON tblskpersonnel.intState = statemaster.StateId INNER JOIN        citymaster ON tblskpersonnel.intCity = citymaster.CityId INNER JOIN         rolesmaster ON tblskpersonnel.intRole = rolesmaster.intId  WHERE intEmpCode !='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "' order by intId desc", dbc.con);// where intEmpCode !='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
                if (e.CommandName == "Views")
                {
                    Cache["EmployeeProfile"] = e.CommandArgument.ToString();// e.CommandArgument.ToString();
                    Response.Redirect("~/SK/Employee/ViewFullEmpProfile.aspx", false);
                }
                else if (e.CommandName == "Approve")
                {
                    dbc.update_tblskpersonnelStatusbySKadmin(e.CommandArgument.ToString(),  "1");
                }
                else if (e.CommandName == "Reject")
                {
                    dbc.update_tblskpersonnelStatusbySKadmin(e.CommandArgument.ToString(),  "0");
                }
                getListViewMasterData();
           
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }

}