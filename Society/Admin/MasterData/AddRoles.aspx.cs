using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SocietyKatta.App_Code.BAL;
using SocietyKatta.App_Code.BAL.Society.MasterData;

public partial class Society_Admin_MasterData_AddRoles :ClsRole
{
    static int EditTypeId = 0;
  
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    int isactive = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) == null)
        {
            Response.Redirect("~/Home/Login.aspx", false);
        }
        else
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
            ddlDepartment.DataSource = dbc.GetDepartmentMasterDataDropdownBySocietyIdForAddEmployee(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlDepartment.DataTextField = "varDepartmentName";
            ddlDepartment.DataValueField = "intId";
            ddlDepartment.DataBind();
            ddlDepartment.Items.Insert(0, new ListItem(":: Select Department ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (AddRoleDetails(Convert.ToInt32(ddlDepartment.SelectedValue), 1, txtrolename.Text.Replace("'", "\\'"), Convert.ToInt16(chkIsActive.Checked ? 1 : 0), Convert.ToInt16(1), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)))
            {
                MessageDisplay(Resources.Messages.Added, "alert alert-success");
                clear();
                
            }
            else
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    
    //public void getRole()
    //{
    //    try
    //    {
    //        grdRole.DataSource = FetchRoleList();
    //        grdRole.DataBind();
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}
    /// <summary>
    /// Clear Text Feild
    /// </summary>
    public void clear()
    {
        chkIsActive.Checked = false;
        txtrolename.Text = "";
        ddlDepartment.SelectedIndex = 0;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="message">Messagge Text</param>
    /// <param name="cssClass">CSS class name</param>
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
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

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int Update_ok = dbc.update_Role(Convert.ToInt32(EditTypeId), Convert.ToInt32(ddlDepartment.SelectedValue), txtrolename.Text.Replace("'", "\\'"), Convert.ToInt16(chkIsActive.Checked ? 1 : 0));

            if (Update_ok == 1)
            {
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
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT rolesmaster.CreatedDate, rolesmaster.CreatedBy, rolesmaster.IsActive, rolesmaster.RoleId, tblmasterdepartment.varDepartmentName AS Department, rolesmasterculturemap.RoleName FROM rolesmaster INNER JOIN tblmasterdepartment ON rolesmaster.DeptId = tblmasterdepartment.intId INNER JOIN rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId where rolesmasterculturemap.varSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' AND rolesmasterculturemap.RoleName!='Admin' AND rolesmasterculturemap.RoleName!='Property Owner'", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();
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
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT    rolesmaster.DeptId , rolesmasterculturemap.RoleName,  rolesmaster.CreatedDate, rolesmaster.CreatedBy, rolesmaster.IsActive, rolesmaster.RoleId,     rolesmasterculturemap.CultureId FROM      rolesmaster INNER JOIN         rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE rolesmaster.RoleId=" + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId = Convert.ToInt32(dbc.dr["RoleId"].ToString());
                    ddlDepartment.SelectedValue =(dbc.dr["DeptId"].ToString());

                    txtrolename.Text = dbc.dr["RoleName"].ToString();
               
                    if (Convert.ToInt32(dbc.dr["IsActive"].ToString()) == 1)
                    {
                        chkIsActive.Checked = true;
                    }
                    else
                    {
                        chkIsActive.Checked = false;
                    }

                }
                dbc.con.Close();
            }
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }
}