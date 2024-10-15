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
using MySql.Data.MySqlClient;

public partial class Society_Admin_Employee_AssignRoleFeatures : ClsAssignUserFeatures
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    Int16 msgCreate = 0;
    Int16 msgRead = 0;
    Int16 msgUpdate = 0;
    Int16 msgDelet = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                GetGridData();
                getDepartmentData();
                GetData();
            }

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //  Response.Redirect("~/EdmitraGuru/Login.aspx", false);
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
    public void GetData()
    {
        try
        {
            ddlFeature.Items.Clear();
            dbc.con.Close();
            dbc.con.Open();
            MySqlCommand das = new MySqlCommand("SELECT FeatureId, ParentId, varFeatureName, PageName, isSubMenu, CreatedDate, SortOrder, IsActive FROM featuresmaster WHERE IsActive=1 AND ParentId=0", dbc.con);//AND (FeatureId <> 3)
            dbc.dr1 = das.ExecuteReader();
            while (dbc.dr1.Read())
            {
                ddlFeature.Items.Add(new ListItem(dbc.dr1["varFeatureName"].ToString(), dbc.dr1["FeatureId"].ToString()));
                if (dbc.dr1["PageName"].ToString().Contains("~"))
                {

                }
                else
                {
                    ddlFeature.Items.FindByValue(dbc.dr1["FeatureId"].ToString()).Attributes.Add("disabled", "disabled");
                }
                dbc.con1.Close();
                dbc.con1.Open();
                MySqlCommand dass = new MySqlCommand("SELECT FeatureId, ParentId, varFeatureName, PageName, isSubMenu, CreatedDate, SortOrder, IsActive FROM featuresmaster WHERE  IsActive=1 AND ParentId=" + Convert.ToInt32(dbc.dr1["FeatureId"].ToString()) + " and ParentId!=0", dbc.con1);
                dbc.dr2 = dass.ExecuteReader();
                while (dbc.dr2.Read())
                {
                    ddlFeature.Items.Add(new ListItem(dbc.dr2["varFeatureName"].ToString(), dbc.dr2["FeatureId"].ToString()));
                }
                dbc.con1.Close();
            }
            ddlFeature.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }



    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            //string sss = string.Empty;
            //sss += ":" + ddlFeature.Items[i].Text + "|" + ddlFeature.Items[i].Value + ":";
            // GET SELECTED ITEMS
            for (int i = 0; i <= ddlFeature.Items.Count - 1; i++)
            {
                if (ddlFeature.Items[i].Selected)
                {
                    if (dbc.CheckMenuinRoleFeatureMap(ddlRole.SelectedValue.ToString(), dbc.GetParentMenuFromSubMenu(ddlFeature.Items[i].Value)) == 0.ToString())
                    {
                        if (dbc.CheckMenuinRoleFeatureMap(ddlRole.SelectedValue.ToString(), ddlFeature.Items[i].Value) == 0.ToString())
                        {
                            AddRoleFeatureMapDetails(Convert.ToInt16(ddlRole.SelectedValue), Convert.ToInt16(dbc.GetParentMenuFromSubMenu(ddlFeature.Items[i].Value)), msgCreate, msgRead, msgUpdate, msgDelet, rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), Convert.ToInt16(ddlisActive.SelectedValue));
                            if (AddRoleFeatureMapDetails(Convert.ToInt16(ddlRole.SelectedValue), Convert.ToInt16(ddlFeature.Items[i].Value), msgCreate, msgRead, msgUpdate, msgDelet, rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), Convert.ToInt16(ddlisActive.SelectedValue)))
                            {
                                MessageDisplay(Resources.Messages.Added, "alert alert-success");
                            }
                            else
                            {
                                MessageDisplay(Resources.ErrorMessages.AlreadyExist, "alert alert-danger");
                            }
                        }
                    }
                    else
                    {
                        if (dbc.CheckMenuinRoleFeatureMap(ddlRole.SelectedValue.ToString(), ddlFeature.Items[i].Value) == 0.ToString())
                        {
                            if (AddRoleFeatureMapDetails(Convert.ToInt16(ddlRole.SelectedValue), Convert.ToInt16(ddlFeature.Items[i].Value), msgCreate, msgRead, msgUpdate, msgDelet, rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), Convert.ToInt16(ddlisActive.SelectedValue)))
                            {
                                MessageDisplay(Resources.Messages.Added, "alert alert-success");
                            }
                            else
                            {
                                MessageDisplay(Resources.ErrorMessages.AlreadyExist, "alert alert-danger");
                            }
                        }
                    }
                }
            }
            clear();
            GetGridData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }

        //......
    }
    public void GetGridData()
    {
        try
        {
            grdRolesAssigned.DataSource = FetchRoleFeatureMapList(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            grdRolesAssigned.DataBind();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void clear()
    {
        ddlRole.SelectedIndex = 0;
        GetData();
        ddlDepartment.SelectedIndex = 0;
        ddlisActive.SelectedIndex = 0;
    }


    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }

    protected void grdRolesAssigned_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdRolesAssigned.PageIndex = e.NewPageIndex;
            GetGridData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlRole.Items.Clear();
            ddlRole.Items.Add(":: Select Role ::");
            ddlRole.Items[0].Value = "";
            using (ClsRole cProvider = new ClsRole())
            {
                ddlRole.DataSource = cProvider.FetchRoleListByDeptId(Convert.ToInt32(ddlDepartment.SelectedValue),dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Admin"));
                ddlRole.DataTextField = "RoleName";
                ddlRole.DataValueField = "RoleId";
                ddlRole.DataBind();
            }

            GetData();
        }

        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}