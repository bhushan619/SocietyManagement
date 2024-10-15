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
using System.Net.Mail;
using System.Net;
using System.IO;
using System.Globalization;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;

public partial class Society_Common_AddBankDetails : System.Web.UI.Page
{
    static int EditTypeId = 0;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getAccountTypeMasterDataDropdownData();
            getListViewMasterData();
        }
    }
    public void getAccountTypeMasterDataDropdownData()
    {
        //try
        //{

        //    ddlaccountype.DataSource = dbc.GetAccountTypeMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
        //    ddlaccountype.DataTextField = "varAccountName";
        //    ddlaccountype.DataValueField = "intId";
        //    ddlaccountype.DataBind();
        //    ddlaccountype.Items.Insert(0, new ListItem(":: Select Department ::", ""));
        //}
        //catch (Exception ex)
        //{
        //    string exp = ex.Message;
        //}
    }

    

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int insert_ok = 0;
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                insert_ok = dbc.insert_tblbankdetails(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["CookiePropertyId"].Value), Convert.ToInt32(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)), txtAcholder.Text.Replace("'", "\\'"), txtaccountno.Text.Replace("'", "\\'"), txtbankname.Text.Replace("'", "\\'"), Convert.ToInt32(ddlaccountype.SelectedValue), txtifsc.Text.Replace("'", "\\'"), txtmcir.Text.Replace("'", "\\'"), txtbranchaddress.Text.Replace("'", "\\'"), txtBranchName.Text.Replace("'", "\\'"), DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), rex.DecryptString(Request.Cookies["CookiePropertyId"].Value), Convert.ToInt32(chkIsActive.Checked ? 1 : 0));
            }
            else
            {
                insert_ok = dbc.insert_tblbankdetails(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), Convert.ToInt32(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)), txtAcholder.Text.Replace("'", "\\'"), txtaccountno.Text.Replace("'", "\\'"), txtbankname.Text.Replace("'", "\\'"), Convert.ToInt32(ddlaccountype.SelectedValue), txtifsc.Text.Replace("'", "\\'"), txtmcir.Text.Replace("'", "\\'"), txtbranchaddress.Text.Replace("'", "\\'"), txtBranchName.Text.Replace("'", "\\'"), DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), Convert.ToInt32(chkIsActive.Checked ? 1 : 0));
             
            }
            if (insert_ok == 1)
            {
                MessageDisplay(Resources.Messages.Added, "alert alert-success");
                clear();
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            }

            getListViewMasterData();
        }
        catch (Exception ex)
        {
            // MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }
  
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
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
                dbc.con.Close();
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonnelId,  intRoleId, varAccountHolderName,  varAccountNo, varBankName, intAccountType, varIFSCCode, varMCIRCode, varBranchAddress, varBranchName, intIsActive FROM tblbankdetails WHERE intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId = Convert.ToInt32(dbc.dr["intId"].ToString());

                    txtaccountno.Text = dbc.dr["varAccountNo"].ToString();
                    txtAcholder.Text = dbc.dr["varAccountHolderName"].ToString();
                    txtBranchName.Text = dbc.dr["varBranchName"].ToString();
                    txtbranchaddress.Text = dbc.dr["varBranchAddress"].ToString();
                    txtbankname.Text = dbc.dr["varBankName"].ToString();
                    txtifsc.Text = dbc.dr["varIFSCCode"].ToString();
                    txtmcir.Text = dbc.dr["varMCIRCode"].ToString();
                    ddlaccountype.SelectedValue = (dbc.dr["intAccountType"].ToString());

                    if (Convert.ToInt32(dbc.dr["intIsActive"].ToString()) == 1)
                    {
                        chkIsActive.Checked = true;
                    }
                    else
                    {
                        chkIsActive.Checked = false;
                    }
                 
                }   dbc.con.Close();
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
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                dbc.con.Close();
                DataTable dt = new DataTable();
                dbc.con.Open();

                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonnelId,  intRoleId, varAccountHolderName, varAccountNo, varBankName, intAccountType, varIFSCCode, varMCIRCode, varBranchAddress, varBranchName,intIsActive FROM tblbankdetails WHERE varPersonnelId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "' ", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adp.Fill(dt);

                lstType.DataSource = dt;
                lstType.DataBind();
                dbc.con.Close();
            }
            else
            {
                dbc.con.Close();
                DataTable dt = new DataTable();
                dbc.con.Open();

                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonnelId,  intRoleId, varAccountHolderName, varAccountNo, varBankName, intAccountType, varIFSCCode, varMCIRCode, varBranchAddress, varBranchName,intIsActive FROM tblbankdetails WHERE varPersonnelId='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "' ", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adp.Fill(dt);

                lstType.DataSource = dt;
                lstType.DataBind();
                dbc.con.Close();
            }
          
        }
        catch (Exception ex)
        {
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            int Update_ok = dbc.update_tblbankdetails(Convert.ToInt32(EditTypeId),txtAcholder.Text.Replace("'", "\\'"),txtaccountno.Text.Replace("'", "\\'"),txtbankname.Text.Replace("'", "\\'"),Convert.ToInt32(ddlaccountype.SelectedValue),txtifsc.Text.Replace("'", "\\'"),txtmcir.Text.Replace("'", "\\'"),txtbranchaddress.Text.Replace("'", "\\'"),txtBranchName.Text.Replace("'", "\\'"), chkIsActive.Checked ? 1 : 0);

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

    public void clear()
    {
        chkIsActive.Checked = false;
        txtaccountno.Text = "";
        txtAcholder.Text = "";
        txtBranchName.Text = "";
        txtbankname.Text = "";
        txtbranchaddress.Text = "";
        txtifsc.Text = "";
         txtmcir.Text = "";
        ddlaccountype.SelectedIndex = 0;
    }
}