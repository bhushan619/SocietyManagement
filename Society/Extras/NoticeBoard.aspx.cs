﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;
using System.Data;


public partial class Society_Extras_NoticeBoard : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string EditPersonalId = string.Empty;
    static string Employeid = string.Empty;
    static int EditTypeId = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getListViewMasterData();

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string personel = string.Empty;  string notificationby = string.Empty;
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                personel = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);
                notificationby = dbc.get_PropertyOwnerName(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["CookiePropertyId"].Value));
            }
            else
            {
                personel = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value);
                notificationby = dbc.get_EmployeeName(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value));
            }

            int insert_ok = dbc.insert_tblsocietynoticeboard(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), personel, Convert.ToInt32(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)), txtTitle.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), personel, 0);
            if (insert_ok == 1)
            {
                dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", personel, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[0], dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[1], "New Noticeboard Entry Added by "+ notificationby, "", "", "Unread", "");
                   
                MessageDisplay(Resources.ErrorMessages.NoticeBoardApproval, "alert alert-success");
                //  dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value),"TEXT",rex.DecryptString(Request.Cookies["LoggedEmpId"].Value),rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) ,
           
                clear();
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            }
            clear();
            getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
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
            if (e.CommandName == "Edits")
            {
                btnUpdate.Visible = true;
                btnSubmit.Visible = false;
                dbc.con1.Close();
                dbc.con1.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varSubject, varDescription,  varCreatedDate, varCreatedBy, intIsActive FROM tblsocietynoticeboard where intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con1);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId = Convert.ToInt32(dbc.dr["intId"].ToString());
                    EditPersonalId = (dbc.dr["varPersonalId"].ToString());
                    txtTitle.Text = dbc.dr["varSubject"].ToString();
                    txtDescription.Text = dbc.dr["varDescription"].ToString(); 
                }
                dbc.con1.Close();
            }
            else if (e.CommandName == "Delets")
            {
                dbc.con.Close();
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("DELETE FROM tblsocietynoticeboard WHERE intId = " + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con);
                int i = cmd1.ExecuteNonQuery();
                dbc.con.Close();

                if (i == 1)
                {
                    MessageDisplay(Resources.Messages.Deleted, "alert alert-success");

                }
                else
                {
                    MessageDisplay(Resources.Messages.NotDeleted, "alert alert-danger");
                }
                getListViewMasterData();
            }

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
        }
    }
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                EditPersonalId = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varSubject, varDescription,  varCreatedDate, varCreatedBy, intIsActive,varStatus FROM tblsocietynoticeboard where varPersonalId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "'", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adp.Fill(dt);

                lstType.DataSource = dt;
                lstType.DataBind();
                dbc.con.Close();
            }
            else
            {
                EditPersonalId = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value);
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varSubject, varDescription,  varCreatedDate, varCreatedBy, intIsActive,varStatus FROM tblsocietynoticeboard where varPersonalId='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adp.Fill(dt);

                lstType.DataSource = dt;
                lstType.DataBind();
                dbc.con.Close();

            }
        }

        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    public void clear()
    {
        txtDescription.Text = "";
        txtTitle.Text = "";
       
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
           
                int Update_ok = dbc.update_tblsocietynoticeboard(Convert.ToInt32(EditTypeId), txtTitle.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"),  0);

                if (Update_ok == 1)
                {
                   //  dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", EditPersonalId, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[0], dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[1], "New Event & Ennouncement Uploaded by ", "", "", "Unread", "");
          MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                   
                    clear();
                }
                else
                {
                    MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                }
           
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;

            EditTypeId = 0;
            getListViewMasterData();
        }
        catch (Exception ex)
        {
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }
}