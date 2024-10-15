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
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Net;
using System.IO;

public partial class Society_Admin_Property_Approvals : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();

    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (this.IsPostBack)
        {
            TabName.Value = Request.Form[TabName.UniqueID]; 
            SubTab.Value = Request.Form[SubTab.UniqueID];
        }
        if (!IsPostBack)
        {
            getListViewMasterData();
            getNoticeBoardData();
            getdocumentData();
        }
       

    }
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable(); 
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblrequest.intId, tblrequest.varSocietyId, tblrequest.varPersonneId, tblrequest.intPersonelRole, tblrequest.varAssignToRoleId, tblrequest.varDate, tblrequest.varTime, tblrequest.varSubject, tblrequest.varDescription, tblrequest.varStatus, tblrequest.varRemark, tblrequest.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')', tblproperty.varName) AS Property FROM tblrequest INNER JOIN tblproperty ON tblrequest.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblrequest.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tblrequest.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

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

    protected void lstRequests_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try {
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
                if (e.CommandName == "UnApprove")
                {
                    dbc.update_tblrequestStatus(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Pending");
                }
                else if (e.CommandName == "Approve")
                {
                    dbc.update_tblrequestStatus(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Approved");
                }
                else if (e.CommandName == "Reject")
                {
                    dbc.update_tblrequestStatus(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Rejected");
                }

                dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), e.CommandArgument.ToString().Split('-')[1], e.CommandArgument.ToString().Split('-')[2], "Request " + e.CommandName + "d", "", "", "Unread", "");

                getListViewMasterData();
                getNoticeBoardData();
                getdocumentData();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    
   
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    //Noticeboard

    public void getNoticeBoardData()
    {
        try
        {
            DataTable ndtu = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand ncmdu = new MySql.Data.MySqlClient.MySqlCommand();
            ncmdu = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblsocietynoticeboard.intId, tblsocietynoticeboard.varSocietyId, tblsocietynoticeboard.varPersonalId, tblsocietynoticeboard.intRole, tblsocietynoticeboard.varSubject, tblsocietynoticeboard.varDescription, tblsocietynoticeboard.varCreatedDate, tblsocietynoticeboard.varCreatedBy, tblsocietynoticeboard.varStatus, tblsocietynoticeboard.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')', tblproperty.varName) AS Name FROM tblsocietynoticeboard INNER JOIN tblproperty ON tblsocietynoticeboard.varPersonalId = tblproperty.varPropertyId INNER JOIN  tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblsocietynoticeboard.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tblsocietynoticeboard.intId desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter nadpu = new MySql.Data.MySqlClient.MySqlDataAdapter(ncmdu);
            nadpu.Fill(ndtu);

            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblsocietynoticeboard.intId,tblsocietynoticeboard.varPersonalId, tblsocietynoticeboard.varSocietyId, tblsocietynoticeboard.varSubject, tblsocietynoticeboard.varDescription, tblsocietynoticeboard.varCreatedDate, tblsocietynoticeboard.varCreatedBy, tblsocietynoticeboard.varStatus, tblsocietynoticeboard.intIsActive,  tblsocietypersonnel.intRole, rolesmaster.RoleId, CONCAT( rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName) as Name,  tblsocietynoticeboard.varPersonalId FROM    tblsocietynoticeboard INNER JOIN   tblsocietypersonnel ON tblsocietynoticeboard.varPersonalId = tblsocietypersonnel.intEmpCode INNER JOIN            rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN       rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE tblsocietynoticeboard.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tblsocietynoticeboard.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoce = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoce);
            adpdoce.Fill(ndtu);

            lstNoticeBoardUnapproved.DataSource = ndtu;
            lstNoticeBoardUnapproved.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void lstNoticeBoardUnapproved_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try {
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
                if (e.CommandName == "UnApprove")
                {
                    dbc.update_tblsocietynoticeboard(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Pending");
                }
                else if (e.CommandName == "Approve")
                {
                    dbc.update_tblsocietynoticeboard(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Approved");
                }
                else if (e.CommandName == "Reject")
                {
                    dbc.update_tblsocietynoticeboard(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Rejected");
                }
                dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), e.CommandArgument.ToString().Split('-')[1], e.CommandArgument.ToString().Split('-')[2], "Notice Board Entry " + e.CommandName + "d", "", "", "Unread", "");

                getListViewMasterData();
                getNoticeBoardData();
                getdocumentData();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstNoticeBoardUnapproved_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try {
            this.DataPagerNoticeBoardUnapproved.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getNoticeBoardData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    //Document

    public void getdocumentData()
    {
        try
        {
            DataTable dtdoc = new DataTable();
            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoc = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoc = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tbldocuments.intId, tbldocuments.varSocietyId, tbldocuments.varPersonnelId,tbldocuments.intRoleId, tbldocuments.varDescription, tbldocuments.varDocument,    tbldocuments.varCreatedDate, tbldocuments.varCreatedBy, tbldocuments.varStatus, tbldocuments.intIsActive, tblmasterdocumenttype.varDocumentName,   CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name FROM            tbldocuments INNER JOIN  tblmasterdocumenttype ON tbldocuments.intDocumentType = tblmasterdocumenttype.intId INNER JOIN  tblproperty ON tbldocuments.varPersonnelId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE        tbldocuments.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoc = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoc);
            adpdoc.Fill(dtdoc);

            lstDocument.DataSource = dtdoc;
            lstDocument.DataBind();
            dbc.con.Close();

            DataTable dtdoce = new DataTable();
            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tbldocuments.intId, tbldocuments.varSocietyId, tbldocuments.varPersonnelId, tbldocuments.intRoleId, tbldocuments.varDescription, tbldocuments.varDocument,         tbldocuments.varCreatedDate, tbldocuments.varCreatedBy, tbldocuments.varStatus, tbldocuments.intIsActive, tblmasterdocumenttype.varDocumentName,   tblsocietypersonnel.varEmpName FROM            tbldocuments INNER JOIN          tblmasterdocumenttype ON tbldocuments.intDocumentType = tblmasterdocumenttype.intId INNER JOIN    tblsocietypersonnel ON tbldocuments.varPersonnelId = tblsocietypersonnel.intEmpCode WHERE        tbldocuments.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoce = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoce);
            adpdoce.Fill(dtdoce);

            lstDocEmployee.DataSource = dtdoce;
            lstDocEmployee.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
  
    protected void lstDocument_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try {
            this.DataPagerDocument.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getdocumentData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstDocument_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try {
            if (e.CommandName == "viewprofile")
            {
                Cache["PropertyProfile"] = e.CommandArgument.ToString().Split('-')[1];
                Response.Redirect("~/Society/Admin/Property/ViewPropertyFullProfile.aspx", false);
            }
            else
            {
                if (e.CommandName == "UnApprove")
                {
                    dbc.update_tbldocuments(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Pending");
                }
                else if (e.CommandName == "Approve")
                {
                    dbc.update_tbldocuments(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Approved");
                }
                else if (e.CommandName == "Reject")
                {
                    dbc.update_tbldocuments(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Rejected");
                }
                dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), e.CommandArgument.ToString().Split('-')[1], e.CommandArgument.ToString().Split('-')[2], "Document Uploaded " + e.CommandName + "d", "", "", "Unread", "");

                //getListViewMasterData();
                //getNoticeBoardData();
                getdocumentData();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstDocEmployee_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try {

            this.DataPagerDocEmp.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getdocumentData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void lstDocEmployee_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "viewprofile")
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
                if (e.CommandName == "UnApprove")
                {
                    dbc.update_tbldocuments(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Pending");
                }
                else if (e.CommandName == "Approve")
                {
                    dbc.update_tbldocuments(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Approved");
                }
                else if (e.CommandName == "Reject")
                {
                    dbc.update_tbldocuments(Convert.ToInt64(e.CommandArgument.ToString().Split('-')[0]), "Rejected");
                }
                dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), e.CommandArgument.ToString().Split('-')[1], e.CommandArgument.ToString().Split('-')[2], "Document Uploaded " + e.CommandName + "d", "", "", "Unread", "");

                //getListViewMasterData();
                //getNoticeBoardData();
                getdocumentData();
            }
        }

        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}