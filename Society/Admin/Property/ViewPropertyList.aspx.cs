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
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;

public partial class Society_Admin_Property_ViewPropertyList : System.Web.UI.Page
{

    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string Employeid = string.Empty;
    static string EditEmpId = string.Empty;
    static int EditId = 0;
    string gen = string.Empty;
    string Maritalstatus = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getListViewMasterData();
        }
    }


    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("sp_select_PropertyDetailsByWhere", dbc.con);
            cmd.CommandType = CommandType.StoredProcedure;
            /// string whereproperty = "tblproperty.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblproperty.varPropertyId ='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'";
            string whereproperty = "tblproperty.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tblproperty.intid desc";
           cmd.Parameters.Add(new MySqlParameter("spwhere", whereproperty));
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
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
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
    protected void lstType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            string lstempintid = e.CommandArgument.ToString();

            if (e.CommandName == "View")
            {
                Cache["PropertyProfile"] = e.CommandArgument.ToString();
                Response.Redirect("~/Society/Admin/Property/ViewPropertyFullProfile.aspx", false);
            }
            //else if (e.CommandName == "Delets")
            //{
            //    dbc.con.Close();
            //    dbc.con.Open();
            //    MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblsocietypersonnel SET intIsActive =0  WHERE intId = " + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con);
            //    int i = cmd1.ExecuteNonQuery();
            //    dbc.con.Close();

            //    if (i == 1)
            //    {
            //        MessageDisplay(Resources.Messages.Deleted, "alert alert-success");

            //    }
            //    else
            //    {
            //        MessageDisplay(Resources.Messages.NotDeleted, "alert alert-danger");
            //    }
            //    getListViewMasterData();
            //}
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}