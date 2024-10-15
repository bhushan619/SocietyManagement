using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using System.IO;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;

public partial class SK_View_Viewsociety : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string Societyid = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
                       
            getSocietyListviewdata();
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getSocietyListviewdata();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getSocietyListviewdata()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,intSocietyCode,varName,varSAddress,varSEmail,varContactPerson,varContactMobile,varIsActive FROM tblsocietyinfo where 1", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstSocietyList.DataSource = dt;
            lstSocietyList.DataBind();
            dbc.con.Close();

            
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    void MessageDisplay(string message, string cssClass)
    {
        try
        {
            lblMessage.Text = message;
            divMessage.Attributes.Add("class", cssClass);
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void lstSocietyList_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
        
            string[] cmdArgs = e.CommandArgument.ToString().Split(':');
            string intid = cmdArgs[0].ToString();
            string intSocietyCode = cmdArgs[1].ToString(); 

            if (e.CommandName == "Views")
            {
                Cache["SocietyProfile"] = intSocietyCode;// e.CommandArgument.ToString();
                Response.Redirect("~/SK/View/fullSocietyDetails.aspx", false);
            }
            else if (e.CommandName == "Approve")
            {
                dbc.update_tblsocietypersonnelbySKadmin(intid, intSocietyCode, "1");
            }
            else if (e.CommandName == "Reject")
            {
                dbc.update_tblsocietypersonnelbySKadmin(intid, intSocietyCode, "0");
            }
            getSocietyListviewdata();
        }
        catch (Exception ex)
        {
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
}