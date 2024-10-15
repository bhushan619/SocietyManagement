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

public partial class Society_Admin_MasterData_AddDocumentType : System.Web.UI.Page
{
    static int EditTypeId = 0;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) == null)
        {
            Response.Redirect("~/Home/Login.aspx", false);
        }
        else 
        if (!IsPostBack)
        {
            getListViewMasterData();

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int Update_ok = dbc.update_tblmasterdocumenttype(Convert.ToInt32(EditTypeId), txtType.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), txtRemark.Text.Replace("'", "\\'"), chkIsActive.Checked ? 1 : 0);

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
            lblMessage.Text = "";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (dbc.Get_tblmasterdocumenttypeByName(txtType.Text.Replace("'", "\\'"), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)) == "")
            {
                int insert_ok = dbc.insert_tblmasterdocumenttype(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value),txtType.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), txtRemark.Text.Replace("'", "\\'"), DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), chkIsActive.Checked ? 1 : 0);

                if (insert_ok == 1)
                {
                    MessageDisplay(Resources.Messages.Added, "alert alert-success");
                    clear();

                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
                }
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.RecordAlreadyExist, "alert alert-danger");
            }

            getListViewMasterData();
        }
        catch (Exception ex)
        {
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
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
    protected void lstDocumentType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edits")
            {
                btnUpdate.Visible = true;
                btnSubmit.Visible = false;
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId as ID,  varDocumentName  as Type,varDescription as Description,varRemark as Remark,intIsActive as IsActive FROM tblmasterdocumenttype WHERE intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId = Convert.ToInt32(dbc.dr["ID"].ToString());
                    txtType.Text = dbc.dr["Type"].ToString();
                    txtDescription.Text = dbc.dr["Description"].ToString();
                    txtRemark.Text = dbc.dr["Remark"].ToString();
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
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId as ID,  varDocumentName  as Type,varDescription as Description,varRemark as Remark,intIsActive as IsActive FROM tblmasterdocumenttype WHERE varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstDocumentType.DataSource = dt;
            lstDocumentType.DataBind();
            dbc.con.Close();
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
        chkIsActive.Checked = false;
        txtDescription.Text = "";
        txtType.Text = "";
        txtRemark.Text = "";

    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
}