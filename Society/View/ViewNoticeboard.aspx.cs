using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Configuration;
using MySql.Data.MySqlClient;
using System.Web.Services;

public partial class Society_View_ViewNoticeboard : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getNoticeBoardData();
        }
      

    }
    public void getNoticeBoardData()
    {
        try
        {
            DataTable ndtu = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand ncmdu = new MySql.Data.MySqlClient.MySqlCommand();
            ncmdu = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblsocietynoticeboard.intId, tblsocietynoticeboard.varSocietyId, tblsocietynoticeboard.varPersonalId, tblsocietynoticeboard.intRole, tblsocietynoticeboard.varSubject, tblsocietynoticeboard.varDescription,DATE_FORMAT(tblsocietynoticeboard.varCreatedDate,'%d-%m-%Y') varCreatedDate, tblsocietynoticeboard.varCreatedBy, tblsocietynoticeboard.varStatus, tblsocietynoticeboard.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')', tblproperty.varName) AS Name FROM tblsocietynoticeboard INNER JOIN tblproperty ON tblsocietynoticeboard.varPersonalId = tblproperty.varPropertyId INNER JOIN  tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblsocietynoticeboard.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tblsocietynoticeboard.intId desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter nadpu = new MySql.Data.MySqlClient.MySqlDataAdapter(ncmdu);
            nadpu.Fill(ndtu);

            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblsocietynoticeboard.intId,tblsocietynoticeboard.varPersonalId, tblsocietynoticeboard.varSocietyId, tblsocietynoticeboard.varSubject, tblsocietynoticeboard.varDescription, DATE_FORMAT(tblsocietynoticeboard.varCreatedDate,'%d-%m-%Y') varCreatedDate, tblsocietynoticeboard.varCreatedBy, tblsocietynoticeboard.varStatus, tblsocietynoticeboard.intIsActive,  tblsocietypersonnel.intRole, rolesmaster.RoleId, CONCAT( rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName) as Name,  tblsocietynoticeboard.varPersonalId FROM    tblsocietynoticeboard INNER JOIN   tblsocietypersonnel ON tblsocietynoticeboard.varPersonalId = tblsocietypersonnel.intEmpCode INNER JOIN            rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN       rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE tblsocietynoticeboard.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tblsocietynoticeboard.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoce = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoce);
            adpdoce.Fill(ndtu);

            lstNoticeboard.DataSource = ndtu;
            lstNoticeboard.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getNoticeBoardData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}