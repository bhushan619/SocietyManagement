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

public partial class SK_Employee_AssignRoleFeatures : ClsAssignUserFeatures
{
    DatabaseConnectionSKAdmin dbcsk = new DatabaseConnectionSKAdmin();
    RegexUtilities rex = new RegexUtilities();
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
               
                GetData();
            }

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //  Response.Redirect("~/EdmitraGuru/Login.aspx", false);
        }
    }
     
    public void GetData()
    {
        try
        {
            ddlFeature.Items.Clear();
            dbcsk.con.Close();
            dbcsk.con.Open();
            MySqlCommand das = new MySqlCommand("SELECT FeatureId, ParentId, varFeatureName, PageName, isSubMenu, CreatedDate, SortOrder, IsActive FROM featuresmaster WHERE IsActive=1 AND ParentId=0", dbcsk.con);//AND (FeatureId <> 3)
            dbcsk.dr1 = das.ExecuteReader();
            while (dbcsk.dr1.Read())
            {
                ddlFeature.Items.Add(new ListItem(dbcsk.dr1["varFeatureName"].ToString(), dbcsk.dr1["FeatureId"].ToString()));
                if (dbcsk.dr1["PageName"].ToString().Contains("~"))
                {

                }
                else
                {
                    ddlFeature.Items.FindByValue(dbcsk.dr1["FeatureId"].ToString()).Attributes.Add("disabled", "disabled");
                }
                dbcsk.con1.Close();
                dbcsk.con1.Open();
                MySqlCommand dass = new MySqlCommand("SELECT FeatureId, ParentId, varFeatureName, PageName, isSubMenu, CreatedDate, SortOrder, IsActive FROM featuresmaster WHERE  IsActive=1 AND ParentId=" + Convert.ToInt32(dbcsk.dr1["FeatureId"].ToString()) + " and ParentId!=0", dbcsk.con1);
                dbcsk.dr2 = dass.ExecuteReader();
                while (dbcsk.dr2.Read())
                {
                    ddlFeature.Items.Add(new ListItem(dbcsk.dr2["varFeatureName"].ToString(), dbcsk.dr2["FeatureId"].ToString()));
                }
                dbcsk.con1.Close();
            }
            ddlFeature.DataBind();
            dbcsk.con.Close();

            dbcsk.con.Open();
            DataTable dt = new DataTable();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT   concat(tblskpersonnel.varEmpName,'-',rolesmaster.RoleName) as names,  tblskpersonnel.intEmpCode, tblskpersonnel.intId,      tblskpersonnel.varMaritalStatus, tblskpersonnel.varFatherHusband, tblskpersonnel.varDateOfJoin, tblskpersonnel.varDOB, tblskpersonnel.varGender,  tblskpersonnel.varMbPrimary, tblskpersonnel.varMbOther, tblskpersonnel.varEmailOther, tblskpersonnel.varPANNo, tblskpersonnel.varPFNo,    tblskpersonnel.varESINo, tblskpersonnel.varPin, tblskpersonnel.varAddress, tblskpersonnel.varPermanentAddress, tblskpersonnel.varPrimaryEmail,    tblskpersonnel.varUsername, tblskpersonnel.varPassword, tblskpersonnel.varMobile, tblskpersonnel.varImage, tblskpersonnel.intIsActive,      tblskpersonnel.intCreatedBy, tblskpersonnel.varCreatedDate, countrymaster.CountryName, statemaster.StateName, citymaster.CityName,    tblskpersonnel.intRole   FROM            tblskpersonnel INNER JOIN    tblskdepartment ON tblskpersonnel.intDeptId = tblskdepartment.intId INNER JOIN   countrymaster ON tblskpersonnel.intCountry = countrymaster.CountryId INNER JOIN      statemaster ON tblskpersonnel.intState = statemaster.StateId INNER JOIN        citymaster ON tblskpersonnel.intCity = citymaster.CityId INNER JOIN         rolesmaster ON tblskpersonnel.intRole = rolesmaster.intId  WHERE intEmpCode !='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "' order by intId desc", dbcsk.con);// where intEmpCode !='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            ddlEmployee.DataTextField = "names";
            ddlEmployee.DataValueField = "intEmpCode";
            ddlEmployee.DataSource = dt;
            ddlEmployee.DataBind();
            dbcsk.con.Close();
        }
        catch (Exception ex)
        {
            dbcsk.con.Close();
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
                    if (dbcsk.CheckMenuinRoleFeatureMap(ddlEmployee.SelectedValue.ToString(), dbcsk.GetParentMenuFromSubMenu(ddlFeature.Items[i].Value)) == 0.ToString())
                    {
                        if (dbcsk.CheckMenuinRoleFeatureMap(ddlEmployee.SelectedValue.ToString(), ddlFeature.Items[i].Value) == 0.ToString())
                        {
                            AddRoleFeatureMapDetailsAdmin(Convert.ToInt16(7), Convert.ToInt16(dbcsk.GetParentMenuFromSubMenu(ddlFeature.Items[i].Value)), msgCreate, msgRead, msgUpdate, msgDelet, ddlEmployee.SelectedValue, Convert.ToInt16(ddlisActive.SelectedValue));
                            if (AddRoleFeatureMapDetailsAdmin(Convert.ToInt16(7), Convert.ToInt16(ddlFeature.Items[i].Value), msgCreate, msgRead, msgUpdate, msgDelet, ddlEmployee.SelectedValue, Convert.ToInt16(ddlisActive.SelectedValue)))
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
                        if (dbcsk.CheckMenuinRoleFeatureMap(ddlEmployee.SelectedValue.ToString(), ddlFeature.Items[i].Value) == 0.ToString())
                        {
                            if (AddRoleFeatureMapDetailsAdmin(Convert.ToInt16(7), Convert.ToInt16(ddlFeature.Items[i].Value), msgCreate, msgRead, msgUpdate, msgDelet, ddlEmployee.SelectedValue, Convert.ToInt16(ddlisActive.SelectedValue)))
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
            grdRolesAssigned.DataSource = FetchRoleFeatureMapListAdmin();
            grdRolesAssigned.DataBind();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void clear()
    {
      
        GetData();
       
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

  
}