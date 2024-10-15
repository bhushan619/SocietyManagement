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

public partial class Society_View_ViewBankDetails : System.Web.UI.Page
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
            cmd = new MySql.Data.MySqlClient.MySqlCommand("  SELECT   tblbankdetails.intid,      tblproperty.intWingId, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')', tblproperty.varName) AS Name,      tblbankdetails.varPersonnelId, tblbankdetails.intRoleId, tblbankdetails.varAccountHolderName, tblbankdetails.varAccountNo, tblbankdetails.varBankName,tblbankdetails.intAccountType, tblbankdetails.varIFSCCode, tblbankdetails.varMCIRCode, tblbankdetails.varBranchAddress, tblbankdetails.varBranchName,  tblbankdetails.varCreatedDate, tblbankdetails.varCreatedBy, tblbankdetails.intIsActive, tblbankdetails.varSocietyId FROM            tblbankdetails INNER JOIN  tblproperty ON tblbankdetails.varPersonnelId = tblproperty.varPropertyId INNER JOIN   tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblbankdetails.varSocietyId= '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'and tblbankdetails.intIsActive=1  order by tblbankdetails .intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT   tblbankdetails.intid,     tblbankdetails.varSocietyId, tblsocietypersonnel.intRole, tblsocietypersonnel.varEmpName, rolesmasterculturemap.RoleName, tblbankdetails.varPersonnelId,    tblbankdetails.intRoleId, tblbankdetails.varAccountHolderName, tblbankdetails.varAccountNo, tblbankdetails.varBankName, tblbankdetails.intAccountType,                          tblbankdetails.varIFSCCode, tblbankdetails.varMCIRCode, tblbankdetails.varBranchAddress, tblbankdetails.varBranchName, tblbankdetails.varCreatedDate,                          tblbankdetails.varCreatedBy, tblbankdetails.intIsActive, CONCAT(rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName) AS Name FROM            tblbankdetails INNER JOIN        tblsocietypersonnel ON tblbankdetails.varPersonnelId = tblsocietypersonnel.intEmpCode INNER JOIN       rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE        tblbankdetails.varSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  and tblbankdetails.intIsActive=1  ORDER BY tblbankdetails.intId DESC", dbc.con);
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
                //if (e.CommandName == "view")
                //{
                //    Response.Redirect("~/View/ViewBankDetails.aspx", false);

                //}
            }
            
                getListViewMasterData();

           
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

}