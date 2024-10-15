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

public partial class Society_Reports_RequestReport : System.Web.UI.Page
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
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblrequest.intId, tblrequest.varSocietyId, tblrequest.varPersonneId, tblrequest.intPersonelRole, tblrequest.varAssignToRoleId,date_format(tblrequest.varDate,'%d-%m-%Y') as varDate, tblrequest.varTime, tblrequest.varSubject, tblrequest.varDescription, tblrequest.varStatus, tblrequest.varRemark, tblrequest.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ') ', tblproperty.varName) AS Name FROM tblrequest INNER JOIN tblproperty ON tblrequest.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblrequest.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tblrequest.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblrequest.intId, tblrequest.varSocietyId, tblrequest.varPersonneId, tblrequest.intPersonelRole, tblrequest.varAssignToRoleId,date_format(tblrequest.varDate,'%d-%m-%Y') as varDate, tblrequest.varTime, tblrequest.varSubject, tblrequest.varDescription, tblrequest.varStatus, tblrequest.varRemark, tblrequest.intIsActive, tblsocietypersonnel.intRole, rolesmaster.RoleId, CONCAT(rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName)  AS Name  from  tblrequest INNER JOIN      tblsocietypersonnel ON tblrequest.varPersonneId = tblsocietypersonnel.intEmpCode INNER JOIN  rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE tblrequest.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  ORDER BY tblrequest.intId DESC", dbc.con);
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
            else
            {
                string temp = string.Empty;

                dbc.oDt = new System.Data.DataTable();
                datef = Convert.ToDateTime(DateTime.ParseExact(txtStartDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd");
                datet = Convert.ToDateTime(DateTime.ParseExact(txtEndDate.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd");

                //datef = Convert.ToDateTime(txtStartDate.Text).ToString("yyyy-MM-dd");
                //datet = Convert.ToDateTime(txtEndDate.Text).ToString("yyyy-MM-dd");


                dbc.con.Close();
                dbc.con.Open();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblrequest.intId, tblrequest.varSocietyId, tblrequest.varPersonneId, tblrequest.intPersonelRole, tblrequest.varAssignToRoleId,date_format(tblrequest.varDate,'%d-%m-%Y') as varDate, tblrequest.varTime, tblrequest.varSubject, tblrequest.varDescription, tblrequest.varStatus, tblrequest.varRemark, tblrequest.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ') ', tblproperty.varName) AS Name FROM tblrequest INNER JOIN tblproperty ON tblrequest.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblrequest.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  and  tblrequest.varDate BETWEEN '" + datef + "' and '" + datet + "' order by tblrequest.intid desc", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter ad = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                ad.Fill(dbc.oDt);

                dbc.con.Close();
                dbc.con.Open();
                cmd1 = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblrequest.intId, tblrequest.varSocietyId, tblrequest.varPersonneId, tblrequest.intPersonelRole, tblrequest.varAssignToRoleId,date_format(tblrequest.varDate,'%d-%m-%Y') as varDate, tblrequest.varTime, tblrequest.varSubject, tblrequest.varDescription, tblrequest.varStatus, tblrequest.varRemark, tblrequest.intIsActive, tblsocietypersonnel.intRole, rolesmaster.RoleId, CONCAT(rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName)  AS Name  from  tblrequest INNER JOIN      tblsocietypersonnel ON tblrequest.varPersonneId = tblsocietypersonnel.intEmpCode INNER JOIN  rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE   tblrequest.varDate  BETWEEN '" + datef + "' and '" + datet + "' and tblrequest.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ORDER BY tblrequest.intId DESC", dbc.con);
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
            dbc.con.Close();
            txtEndDate.Text = "";
            txtStartDate.Text = "";
            // cmd.Dispose();
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
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblrequest.intId, tblrequest.varSocietyId, tblrequest.varPersonneId, tblrequest.intPersonelRole, tblrequest.varAssignToRoleId,date_format(tblrequest.varDate,'%d-%m-%Y') as varDate, tblrequest.varTime, tblrequest.varSubject, tblrequest.varDescription, tblrequest.varStatus, tblrequest.varRemark, tblrequest.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ') ', tblproperty.varName) AS Name FROM tblrequest INNER JOIN tblproperty ON tblrequest.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblrequest.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and " + wherecondition + " order by tblrequest.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblrequest.intId, tblrequest.varSocietyId, tblrequest.varPersonneId, tblrequest.intPersonelRole, tblrequest.varAssignToRoleId,date_format(tblrequest.varDate,'%d-%m-%Y') as varDate, tblrequest.varTime, tblrequest.varSubject, tblrequest.varDescription, tblrequest.varStatus, tblrequest.varRemark, tblrequest.intIsActive, tblsocietypersonnel.intRole, rolesmaster.RoleId, CONCAT(rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName)  AS Name  from  tblrequest INNER JOIN      tblsocietypersonnel ON tblrequest.varPersonneId = tblsocietypersonnel.intEmpCode INNER JOIN  rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE tblrequest.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and  " + wherecondition + "  ORDER BY tblrequest.intId DESC", dbc.con);
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
            getListViewMasterDataRadio(" tblrequest.varStatus = 'Pending' ");
        }
        else if (rgbResolved.Checked == true)
        {
            divsearchdate.Visible = false;            getListViewMasterDataRadio("  tblrequest.varStatus='Rejected' ");
           
        }
        else if (rgbProceed.Checked == true)
        {
            divsearchdate.Visible = false;
 getListViewMasterDataRadio("  tblrequest.varStatus='Approved' ");
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