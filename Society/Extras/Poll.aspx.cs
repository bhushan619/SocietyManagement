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

public partial class Society_Extras_Poll : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string Employeid = string.Empty;
    static int EditTypeId = 0;
    static string EditPersonalId = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getListViewMasterData();

        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int Update_ok = dbc.update_tblpoll(Convert.ToInt32(EditTypeId),txtQuestion.Text.Replace("'", "\\'"),txtOptionalText.Text.Replace("'", "\\'"),txtop1.Text.Replace("'", "\\'"),txtop2.Text.Replace("'", "\\'"),txtop3.Text.Replace("'", "\\'"),txtop4.Text.Replace("'", "\\'"),txtAnswer.Text.Replace("'", "\\'"),txtAnswer.Text.Replace("'", "\\'"),txtEMobile.Text.Replace("'", "\\'"),txtEEmail.Text.Replace("'", "\\'"), chkIsActive.Checked ? 1 : 0);

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
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId,  intRole, varQuestion, varOptionalText, varOption1, varOption2, varOption3, varOption4, varAnswer, varContactName, varMobile,  varEmail, varCreatedDate, varCreatedBy, intIsActive FROM tblpoll WHERE intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con1);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId = Convert.ToInt32(dbc.dr["intId"].ToString());
                    EditPersonalId = (dbc.dr["varPersonalId"].ToString());
                    txtQuestion.Text = dbc.dr["varQuestion"].ToString();
                    txtAnswer.Text = dbc.dr["varAnswer"].ToString();
                    txtOptionalText.Text = dbc.dr["varOptionalText"].ToString();
                    txtop1.Text = dbc.dr["varOption1"].ToString();
                   
                    txtop2.Text = dbc.dr["varOption2"].ToString();
                    txtop3.Text = dbc.dr["varOption3"].ToString();
                    txtop4.Text = dbc.dr["varOption4"].ToString();
                    txtEContactName.Text = dbc.dr["varContactName"].ToString();
                    txtEMobile.Text = dbc.dr["varMobile"].ToString();
                    txtEEmail.Text = dbc.dr["varEmail"].ToString();

                    if (Convert.ToInt32(dbc.dr["intIsActive"].ToString()) == 1)
                    {
                        chkIsActive.Checked = true;
                    }
                    else
                    {
                        chkIsActive.Checked = false;
                    }

                }
                dbc.con1.Close();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string personel = string.Empty;
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                personel = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);
            }
            else
            {
                personel = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value);
            }

            int insert_ok = dbc.insert_tblpoll(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), personel, Convert.ToInt32(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)), txtQuestion.Text.Replace("'", "\\'"), txtOptionalText.Text.Replace("'", "\\'"), txtop1.Text.Replace("'", "\\'"), txtop2.Text.Replace("'", "\\'"), txtop3.Text.Replace("'", "\\'"), txtop4.Text.Replace("'", "\\'"), txtAnswer.Text.Replace("'", "\\'"), txtEContactName.Text.Replace("'", "\\'"), txtEMobile.Text.Replace("'", "\\'"), txtEEmail.Text.Replace("'", "\\'"), DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd").ToString(), personel, Convert.ToInt32(chkIsActive.Checked ? 1 : 0));
            if (insert_ok == 1)
            {
                MessageDisplay(Resources.Messages.Added, "alert alert-success");
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
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varQuestion, varOptionalText, varOption1, varOption2, varOption3, varOption4, varAnswer, varContactName, varMobile, varEmail, varCreatedDate, varCreatedBy, intIsActive FROM tblpoll WHERE varPersonalId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "'", dbc.con);
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
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varQuestion, varOptionalText, varOption1, varOption2, varOption3, varOption4, varAnswer, varContactName, varMobile, varEmail, varCreatedDate, varCreatedBy, intIsActive FROM tblpoll WHERE varPersonalId='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adp.Fill(dt);

                lstType.DataSource = dt;
                lstType.DataBind();
                dbc.con.Close();

            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }

    public void clear()
    {
        chkIsActive.Checked = false;
        txtAnswer.Text = "";
        txtEContactName.Text = "";
        txtEEmail.Text = "";
        txtEMobile.Text = "";
        txtop1.Text = "";
        txtop2.Text = "";
        txtop3.Text = "";
        txtop4.Text = "";
        txtQuestion.Text = "";
        txtOptionalText.Text = "";

    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
}