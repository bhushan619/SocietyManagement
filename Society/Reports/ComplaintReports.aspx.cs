using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;
using System.Data;
using System.Globalization;

public partial class Society_Reports_ComplaintReports : System.Web.UI.Page
{
    string datef, datet;
    MySql.Data.MySqlClient.MySqlCommand cmd, cmd1;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
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
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblcompliants.intId, tblcompliants.varSocietyId, tblcompliants.varPersonneId, tblcompliants.intPersonelRole, tblcompliants.varAssignToRoleId,date_format(tblcompliants.varDate,'%d-%m-%Y') as varDate, tblcompliants.varTime, tblcompliants.varSubject, tblcompliants.varDescription, tblcompliants.varStatus, tblcompliants.varRemark, tblcompliants.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ') ', tblproperty.varName) AS Name,date_format(tblcompliants.varProceedDate,'%d-%m-%Y') as varProceedDate FROM tblcompliants INNER JOIN tblproperty ON tblcompliants.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblcompliants.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tblcompliants.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblcompliants.intId, tblcompliants.varSocietyId, tblcompliants.varPersonneId, tblcompliants.intPersonelRole, tblcompliants.varAssignToRoleId,date_format(tblcompliants.varDate,'%d-%m-%Y') as varDate, tblcompliants.varTime, tblcompliants.varSubject, tblcompliants.varDescription, tblcompliants.varStatus, tblcompliants.varRemark, tblcompliants.intIsActive, tblsocietypersonnel.intRole, rolesmaster.RoleId, CONCAT(rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName)  AS Name ,date_format(tblcompliants.varProceedDate,'%d-%m-%Y') as varProceedDate from  tblcompliants INNER JOIN      tblsocietypersonnel ON tblcompliants.varPersonneId = tblsocietypersonnel.intEmpCode INNER JOIN  rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE tblcompliants.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  ORDER BY tblcompliants.intId DESC", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoce = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoce);
            adpdoce.Fill(dt);


            lstRequests.DataSource = dt;
            lstRequests.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            dbc.con.Close();
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
                datef = Convert.ToDateTime(DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd");
                datet = Convert.ToDateTime(DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd");

                // datef = DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                // datet = DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);

                dbc.con.Close();
                dbc.con.Open();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblcompliants.intId, tblcompliants.varSocietyId, tblcompliants.varPersonneId, tblcompliants.intPersonelRole, tblcompliants.varAssignToRoleId,date_format(tblcompliants.varDate,'%d-%m-%Y') as varDate, tblcompliants.varTime, tblcompliants.varSubject, tblcompliants.varDescription, tblcompliants.varStatus, tblcompliants.varRemark, tblcompliants.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ') ', tblproperty.varName) AS Name,date_format(tblcompliants.varProceedDate,'%d-%m-%Y') as varProceedDate FROM tblcompliants INNER JOIN tblproperty ON tblcompliants.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblcompliants.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  and  tblcompliants.varDate BETWEEN '" + datef + "' and '" + datet + "' order by tblcompliants.intid desc", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter ad = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                ad.Fill(dbc.oDt);

                dbc.con.Close();
                dbc.con.Open();
                cmd1 = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblcompliants.intId, tblcompliants.varSocietyId, tblcompliants.varPersonneId, tblcompliants.intPersonelRole, tblcompliants.varAssignToRoleId,date_format(tblcompliants.varDate,'%d-%m-%Y') as varDate, tblcompliants.varTime, tblcompliants.varSubject, tblcompliants.varDescription, tblcompliants.varStatus, tblcompliants.varRemark, tblcompliants.intIsActive, tblsocietypersonnel.intRole, rolesmaster.RoleId, CONCAT(rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName)  AS Name ,date_format(tblcompliants.varProceedDate,'%d-%m-%Y') as varProceedDate from  tblcompliants INNER JOIN      tblsocietypersonnel ON tblcompliants.varPersonneId = tblsocietypersonnel.intEmpCode INNER JOIN  rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE   tblcompliants.varDate  BETWEEN '" + datef + "' and '" + datet + "' and tblcompliants.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ORDER BY tblcompliants.intId DESC", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter ada = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd1);
                ada.Fill(dbc.oDt);

                lstRequests.DataSource = dbc.oDt;
                lstRequests.DataBind();
                dbc.con.Close();
                dbc.oDt.Dispose();
                cmd.Dispose();
                txtEndDate.Text = "";
                txtStartDate.Text = "";
            }
           
        }
        catch (Exception ex)
        {
            txtEndDate.Text = "";
            txtStartDate.Text = "";
            dbc.con.Close();
            string exp = ex.Message;

            Response.Write("<script>alert('" + ex.Message + "');</script>");
        }
    }
    public void getListViewMasterDataRadio(string wherecondition)
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblcompliants.intId, tblcompliants.varSocietyId, tblcompliants.varPersonneId, tblcompliants.intPersonelRole, tblcompliants.varAssignToRoleId,date_format(tblcompliants.varDate,'%d-%m-%Y') as varDate, tblcompliants.varTime, tblcompliants.varSubject, tblcompliants.varDescription, tblcompliants.varStatus, tblcompliants.varRemark, tblcompliants.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ') ', tblproperty.varName) AS Name,date_format(tblcompliants.varProceedDate,'%d-%m-%Y') as varProceedDate FROM tblcompliants INNER JOIN tblproperty ON tblcompliants.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblcompliants.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and "+wherecondition+" order by tblcompliants.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblcompliants.intId, tblcompliants.varSocietyId, tblcompliants.varPersonneId, tblcompliants.intPersonelRole, tblcompliants.varAssignToRoleId,date_format(tblcompliants.varDate,'%d-%m-%Y') as varDate, tblcompliants.varTime, tblcompliants.varSubject, tblcompliants.varDescription, tblcompliants.varStatus, tblcompliants.varRemark, tblcompliants.intIsActive, tblsocietypersonnel.intRole, rolesmaster.RoleId, CONCAT(rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName)  AS Name ,date_format(tblcompliants.varProceedDate,'%d-%m-%Y') as varProceedDate from  tblcompliants INNER JOIN      tblsocietypersonnel ON tblcompliants.varPersonneId = tblsocietypersonnel.intEmpCode INNER JOIN  rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE tblcompliants.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and  " + wherecondition + "  ORDER BY tblcompliants.intId DESC", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoce = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoce);
            adpdoce.Fill(dt);


            lstRequests.DataSource = dt;
            lstRequests.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void rgbNew_CheckedChanged(object sender, EventArgs e)
    {
        if (rgbNew.Checked == true)
        {
            divsearchdate.Visible = false;
            getListViewMasterDataRadio(" tblcompliants.varStatus = 'New' ");
        }
        else if (rgbResolved.Checked == true)
        {
            divsearchdate.Visible = false;
            getListViewMasterDataRadio("  tblcompliants.varStatus='Resolved' ");
        }
        else if (rgbProceed.Checked == true)
        {
            divsearchdate.Visible = false;
            getListViewMasterDataRadio("  tblcompliants.varStatus='Processed' ");
        }
        else if (rgbdate.Checked == true)
        {
            divsearchdate.Visible = true;
        }
        else
        {
            divsearchdate.Visible = false;
            getListViewMasterData();
        }

    }

    protected void lstRequests_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "viewprofile")
            {
                if (e.CommandArgument.ToString().Split('-')[1].Contains("SKSE"))
                {
                    if (e.CommandArgument.ToString().Split('-')[1].Equals(rex.DecryptString(Request.Cookies["LoggedEmpId"].Value)))
                    {
                        Response.Redirect("~/Society/Common/MyProfile.aspx", false);
                    }
                    else
                    {
                        Cache["EmployeeProfile"] = e.CommandArgument.ToString().Split('-')[1];
                        Response.Redirect("~/Society/Admin/Employee/ViewEmpFullProfile.aspx", false);
                    }
                }
                else
                {
                    Cache["PropertyProfile"] = e.CommandArgument.ToString().Split('-')[1];
                    Response.Redirect("~/Society/Admin/Property/ViewPropertyFullProfile.aspx", false);
                }
            }
           
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}