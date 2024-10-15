using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Society_Admin_Accounts_AddAccountName : System.Web.UI.Page
{
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    static string EditAcNo = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getListViewMasterData();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (dbc.check_alreadyAccountName(txtAccountName.Text))
        {
            MessageDisplay(Resources.ErrorMessages.RecordAlreadyExist, "alert alert-danger");
        }
        else
        {
            if (dbc.insert_tblaccountdetails( txtAccountName.Text.Replace("'", "\\'"), txtAccountDesc.Text))
            {
                MessageDisplay(Resources.Messages.Added, "alert alert-success");
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }
        }
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);

        txtAccountDesc.Text = "";
        txtAccountName.Text = "";

        btnSubmit.Visible = true;
        btnUpdate.Visible = false;

        EditAcNo = string.Empty;

        getListViewMasterData();
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (dbc.update_tblaccountdetails(EditAcNo, txtAccountName.Text.Replace("'", "\\'"), txtAccountDesc.Text))
        {
            MessageDisplay(Resources.Messages.Added, "alert alert-success");
        }
        else
        {
            MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
        }
    }
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,  varAccountNo, varAccountName, varDescription, ex1, ex2, ex3, ex4 FROM tblaccountdetails  order by intId desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstAccountNames.DataSource = dt;
            lstAccountNames.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
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
    protected void lstAccountNames_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            string[] cmdArgs = e.CommandArgument.ToString().Split(':');
            EditAcNo = cmdArgs[0];
            txtAccountName.Text = cmdArgs[1];
            txtAccountDesc.Text = cmdArgs[2];

            btnSubmit.Visible = false;
            btnUpdate.Visible = true;
        }
        catch (Exception ex)
        {
            string d = ex.Message;
        }
    }
}