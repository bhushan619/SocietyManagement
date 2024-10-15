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
using SocietyKatta.App_Code.BAL;
using SocietyKatta.App_Code.BAL.Society.MasterData;

public partial class Society_Admin_MasterData_AddFeature : ClsFeature
{

    static int EditTypeId = 0;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) == null)
        //{
        //    Response.Redirect("~/Home/Login.aspx", false);
        //}
        //else
        if (!IsPostBack)
        {
            getListViewMasterData();
            getFeatureDropDownData();
        }

    }
    /// <summary>
    /// get Feature Data in dropdown for Parent Menu ghg
    /// </summary>
    public void getFeatureDropDownData()
    {
        try
        {
            ddlparentFeatureName.Items.Clear(); 
            ddlparentFeatureName.Items.Add(":: Select Parent Menu ::");
            dbc.con.Close();
            dbc.con.Open();
            MySqlCommand das = new MySqlCommand("SELECT FeatureId, ParentId, varFeatureName, PageName, isSubMenu, CreatedDate, CreatedBy, IsActive FROM featuresmaster WHERE ParentId=0", dbc.con);
            dbc.dr1 = das.ExecuteReader();
            while (dbc.dr1.Read())
            {
                ddlparentFeatureName.Items.Add(new ListItem(dbc.dr1["varFeatureName"].ToString(), dbc.dr1["FeatureId"].ToString())); 
                ddlparentFeatureName.DataTextField = "varFeatureName";
                ddlparentFeatureName.DataValueField = "FeatureId";
                ddlparentFeatureName.DataBind();
            }
            ddlparentFeatureName.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }
    /// <summary>
    /// get Features Data
    /// </summary>
   
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            //Add Feature details
            if (ddlparentFeatureName.SelectedValue == ":: Select Parent Menu ::")
            {
                if (AddFeatureDetails(0, txtPageName.Text.Replace("'", "\\'"), Convert.ToInt16(1), txtFeaturesName.Text.Replace("'", "\\'"), ddlisSubMenu.SelectedValue,Convert.ToInt16(chkIsActive.Checked ? 1 : 0), Convert.ToInt16(1)))
                {
                    MessageDisplay(Resources.Messages.Added, "alert alert-success");
                }
                else
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            }
            else
            {
                if (AddFeatureDetails(Convert.ToInt64(ddlparentFeatureName.SelectedValue), txtPageName.Text.Replace("'", "\\'"), Convert.ToInt16(1), txtFeaturesName.Text.Replace("'", "\\'"), ddlisSubMenu.SelectedValue, Convert.ToInt16(chkIsActive.Checked ? 1 : 0), Convert.ToInt16(1)))
                {
                    MessageDisplay(Resources.Messages.Added, "alert alert-success");

                }
                else
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            }
            clear();
            getFeatureDropDownData();
            getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;

        }
    }

    /// <summary>
    /// clear text Field
    /// </summary>
    public void clear()
    {
        chkIsActive.Checked = false;
        txtFeaturesName.Text = "";
        txtPageName.Text = "";
        ddlparentFeatureName.SelectedIndex = 0;
        ddlisSubMenu.SelectedIndex = 0;
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

        this.getListViewMasterData();
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int Update_ok = dbc.update_feature(Convert.ToInt32(EditTypeId), Convert.ToInt32(ddlparentFeatureName.SelectedValue), txtPageName.Text.Replace("'", "\\'"), Convert.ToInt32(ddlisSubMenu.SelectedValue), txtFeaturesName.Text.Replace("'", "\\'"), Convert.ToInt16(chkIsActive.Checked ? 1 : 0));

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
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT featuresmaster.FeatureId, featuresmaster.ParentId, featuresmaster.PageName, featuresmaster.CreatedDate, featuresmaster.CreatedBy, featuresmaster.isSubMenu, featuresmaster.varFeatureName, featuresmaster.IsActive FROM featuresmaster", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }
    protected void lstType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edits")
            {
                getFeatureDropDownData();
                btnUpdate.Visible = true;
                btnSubmit.Visible = false;
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT        featuresmaster.FeatureId, featuresmaster.ParentId, featuresmaster.PageName, featuresmaster.CreatedDate, featuresmaster.CreatedBy, featuresmaster.isSubMenu,  featuresmaster.varFeatureName,  featuresmaster.IsActive FROM      featuresmaster WHERE featuresmaster.FeatureId=" + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId = Convert.ToInt32(dbc.dr["FeatureId"].ToString());
                    ddlparentFeatureName.SelectedValue =(dbc.dr["ParentId"].ToString());
                    ddlisSubMenu.SelectedValue =(dbc.dr["isSubMenu"].ToString());
                    txtPageName.Text = dbc.dr["PageName"].ToString();
                    txtFeaturesName.Text = dbc.dr["varFeatureName"].ToString();
                    if (Convert.ToInt32(dbc.dr["IsActive"].ToString()) == 1)
                    {
                        chkIsActive.Checked = true;
                    }
                    else
                    {
                        chkIsActive.Checked = false;
                    }

                } dbc.con.Close();
            }
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }

    //protected void grdFeatures_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    grdFeatures.PageIndex = e.NewPageIndex;
    //    getFeaturesData();
    //} 
    //public void getFeaturesData()
    //{
    //    try
    //    {
    //        grdFeatures.DataSource = FetchFeatureWithsCultureId(1);
    //        grdFeatures.DataBind();
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}

}