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


public partial class Society_Admin_MasterData_AddTitle : ClsTitle
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
            getTitleData();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (AddTitleDetails(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value),1, Convert.ToInt32(chkIsActive.Checked ? 1 : 0), txtTitle.Text.Replace("'", "\\'"), Convert.ToInt16(1)))
            {
                MessageDisplay(Resources.Messages.Added, "alert alert-success");
                clear();
                getTitleData();

            }
            else
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }

    }

    /// <summary>
    /// get Timezone Data
    /// </summary>
    public void getTitleData()
    {
        try
        {

            lstType.DataSource = FetchTitleListBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            lstType.DataBind();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    /// <summary>
    /// clear text feild
    /// </summary>
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getTitleData();
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
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT        titlemaster.TitleId, titlemaster.CreatedDate, titlemaster.CreatedBy, titlemaster.IsActive, titlemasterculturemap.TitleName FROM            titlemaster INNER JOIN   titlemasterculturemap ON titlemaster.TitleId = titlemasterculturemap.TitleId WHERE        (titlemasterculturemap.CultureId = 1) and titlemaster.TitleId=" + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId = Convert.ToInt32(dbc.dr["TitleId"].ToString());
                    txtTitle.Text = dbc.dr["TitleName"].ToString();
                 
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
    
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int Update_ok = dbc.update_Title(Convert.ToInt32(EditTypeId),txtTitle.Text.Replace("'", "\\'"),Convert.ToInt16( chkIsActive.Checked ? 1 : 0));

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
            getTitleData();
        }
        catch (Exception ex)
        {
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }
    public void clear()
    {
        chkIsActive.Checked = false;
        txtTitle.Text = "";
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
    //protected void grdTitle_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    grdTitle.PageIndex = e.NewPageIndex;
    //    getTitleData();
    //}
}