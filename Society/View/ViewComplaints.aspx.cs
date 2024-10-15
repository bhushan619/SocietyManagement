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

public partial class Society_View_ViewComplaints : System.Web.UI.Page
{
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
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblcompliants.intId, tblcompliants.varSocietyId, tblcompliants.varPersonneId, tblcompliants.intPersonelRole, tblcompliants.varAssignToRoleId,date_format(tblcompliants.varDate,'%d-%m-%Y') as varDate, tblcompliants.varTime, tblcompliants.varSubject, tblcompliants.varDescription, tblcompliants.varStatus, tblcompliants.varRemark, tblcompliants.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')', tblproperty.varName) AS Name,date_format(tblcompliants.varProceedDate,'%d-%m-%Y') as varProceedDate FROM tblcompliants INNER JOIN tblproperty ON tblcompliants.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblcompliants.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tblcompliants.intid desc", dbc.con);
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
            else
            {
                //if (e.CommandName == "New")
                //{
                //    dbc.update_tblcompliantsStatus(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "New");
                //}
                //else 
                if (e.CommandName == "Processed")
                {
                    dbc.update_tblcompliantsStatus(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Processed");
                }
                else if (e.CommandName == "Resolved")
                {
                    dbc.update_tblcompliantsStatus(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Resolved");
                }

                dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), e.CommandArgument.ToString().Split('-')[1], e.CommandArgument.ToString().Split('-')[2], "Your Complaint  " + e.CommandName , "", "", "Unread", "");

                getListViewMasterData();
             
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

}