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
using System.Globalization;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;

public partial class Society_View_ViewSelfPoll : System.Web.UI.Page
{
    static string Employeid = string.Empty;
    static int EditTypeId = 0;
    static string EditPersonalId = string.Empty;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getListViewMasterData();
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

        this.getListViewMasterData();
    }

    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            string personel = string.Empty;
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                personel = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);
            }
            else
            {
                personel = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value);
            }
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdp = new MySql.Data.MySqlClient.MySqlCommand();
            cmdp = new MySql.Data.MySqlClient.MySqlCommand("SELECT        intId, varSocietyId, varPersonalId, intRole, varQuestion, varOptionalText, varOption1, varOption2, varOption3, varOption4, varAnswer, varContactName, varMobile, varEmail, varCreatedDate, varCreatedBy, intIsActive  FROM            tblpoll WHERE     tblpoll.varSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and  tblpoll.varPersonalId='" + personel + "' AND (tblpoll.intIsActive = 1) ORDER BY    tblpoll.varCreatedDate DESC", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmdp);
            adpp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
           
            dbc.con.Close();
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }


    protected void lstType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Views")
            {
                replydiv.Visible = true;
                DataTable dt = new DataTable();
                dbc.con1.Close();
                dbc.con1.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblsocietypersonnel.varEmpName as Name, tblpollanswer.varAnswer, DATE_FORMAT(tblpollanswer.varAnswerDate,'%d-%m-%Y') as varAnswerDate FROM tblpoll INNER JOIN tblpollanswer ON tblpoll.intId = tblpollanswer.intPollId INNER JOIN tblsocietypersonnel ON tblpollanswer.varPersonalId = tblsocietypersonnel.intEmpCode WHERE tblpoll.intId =" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con1);
                MySql.Data.MySqlClient.MySqlDataAdapter adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adpp.Fill(dt);
                dbc.con1.Close();
                dbc.con1.Open();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblproperty.varName as Name, tblpollanswer.varAnswer, DATE_FORMAT(tblpollanswer.varAnswerDate,'%d-%m-%Y') as varAnswerDate FROM tblpoll INNER JOIN tblpollanswer ON tblpoll.intId = tblpollanswer.intPollId INNER JOIN tblproperty ON tblpollanswer.varPersonalId = tblproperty.varPropertyId WHERE tblpoll.intId =" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con1);
                adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adpp.Fill(dt);
                dbc.con1.Close();
                lstreply.DataSource = dt;
                lstreply.DataBind();
                dbc.con1.Close();
          

            }
        }
        catch (Exception ex)
        {
            dbc.con1.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
}