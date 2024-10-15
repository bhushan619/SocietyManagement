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

public partial class Society_View_ViewEventEnnouncement : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string EditPersonalId = string.Empty;
    static string Employeid = string.Empty;
    static int EditTypeId = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) == null)
        {
            Response.Redirect("~/Home/Login.aspx", false);
        }
        else if (!IsPostBack)
        {
            getEventEnnouncementData();
        }
    }
    public void getEventEnnouncementData()
    {
        try
        {
            DataTable dt = new DataTable();

            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            string query = "SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole, ";
            query += "  tbleventannouncement.varSubject, tbleventannouncement.varDescription,DATE_FORMAT(tbleventannouncement.varStartDate,'%d-%m-%Y') as varStartDate, ";
            query += " DATE_FORMAT(tbleventannouncement.varEndDate,'%d-%m-%Y') as varEndDate , tbleventannouncement.varStartTime, tbleventannouncement.varEndTime, tbleventannouncement.varLocation, ";
            query += " tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, tbleventannouncement.varContactName, tbleventannouncement.varMobile, ";
            query += " tbleventannouncement.varEmail, tbleventannouncement.varEventImage, tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy, ";
            query += " tbleventannouncement.intIsActive, countrymaster.CountryName, statemaster.StateName, citymaster.CityName, ";
            query += " CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name";
            query += " FROM tbleventannouncement INNER JOIN";
            query += " countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN";
            query += " statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN";
            query += " citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN";
            query += " tblproperty ON tbleventannouncement.varPersonalId = tblproperty.varPropertyId INNER JOIN";
            query += " tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId ";
             cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " WHERE tbleventannouncement.intIsActive =1 and tbleventannouncement.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  order by tbleventannouncement.intId desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            dbc.con.Close();
            query = string.Empty;
            query += "SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole, ";
            query += " tbleventannouncement.varSubject, tbleventannouncement.varDescription, DATE_FORMAT(tbleventannouncement.varStartDate, ";
            query += " '%d-%m-%Y') AS varStartDate, DATE_FORMAT(tbleventannouncement.varEndDate, '%d-%m-%Y') AS varEndDate, tbleventannouncement.varStartTime, ";
            query += " tbleventannouncement.varEndTime, tbleventannouncement.varLocation, tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, ";
            query += " tbleventannouncement.varContactName, tbleventannouncement.varMobile, tbleventannouncement.varEmail, tbleventannouncement.varEventImage, ";
            query += " tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy, tbleventannouncement.intIsActive, countrymaster.CountryName, ";
            query += " statemaster.StateName, citymaster.CityName, concat(rolesmasterculturemap.RoleName,'-' ,tblsocietypersonnel.varEmpName) as Name";
            query += " FROM tbleventannouncement INNER JOIN";
            query += " countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN";
            query += " statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN";
            query += " citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN";
              query += " tblsocietypersonnel ON tbleventannouncement.varPersonalId = tblsocietypersonnel.intEmpCode INNER JOIN";
            query += " rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId";

            MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand(query + " WHERE tbleventannouncement.intIsActive =1 and tbleventannouncement.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  order by tbleventannouncement.intId desc", dbc.con);
            adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd1);
            adp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
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
        this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

        this.getEventEnnouncementData();
    }

    protected void lstType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {


            int eventIntId = Convert.ToInt32(e.CommandArgument.ToString());

            if (e.CommandName == "Views")
            {
                Cache["eventIntId"] = e.CommandArgument.ToString();
                Response.Redirect("~/Society/View/FullEvent.aspx", false);
            }
            //if (e.CommandName == "Views")
            //{
            //    replydiv.Visible = true;
            //    DataTable dt = new DataTable();
            //    string query = "SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole, ";
            //    query += " tbleventannouncement.intEventType, tbleventannouncement.varSubject, tbleventannouncement.varDescription,DATE_FORMAT(tbleventannouncement.varStartDate,'%d-%m-%Y') as varStartDate, ";
            //    query += " DATE_FORMAT(tbleventannouncement.varEndDate,'%d-%m-%Y') as varEndDate , tbleventannouncement.varStartTime, tbleventannouncement.varEndTime, tbleventannouncement.varLocation, ";
            //    query += " tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, tbleventannouncement.varContactName, tbleventannouncement.varMobile, ";
            //    query += " tbleventannouncement.varEmail, tbleventannouncement.varEventImage, tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy, ";
            //    query += " tbleventannouncement.intIsActive, countrymaster.CountryName, statemaster.StateName, citymaster.CityName, tblmastereventtype.varEventTypeName,";
            //    query += " CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name";
            //    query += " FROM tbleventannouncement INNER JOIN";
            //    query += " countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN";
            //    query += " statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN";
            //    query += " citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN";
            //    query += " tblproperty ON tbleventannouncement.varPersonalId = tblproperty.varPropertyId INNER JOIN";
            //    query += " tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId  INNER JOIN";
            //    query += " tblmastereventtype ON tbleventannouncement.intEventType = tblmastereventtype.intId";
            //    dbc.con1.Open();
            //    MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " where tbleventannouncement.intId =" + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con1);
            //    MySql.Data.MySqlClient.MySqlDataAdapter adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            //    adpp.Fill(dt);
            //    dbc.con1.Close();
            //    dbc.con.Close();
            //    query = string.Empty;
            //    query += "SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole, ";
            //    query += " tbleventannouncement.intEventType, tbleventannouncement.varSubject, tbleventannouncement.varDescription, DATE_FORMAT(tbleventannouncement.varStartDate, ";
            //    query += " '%d-%m-%Y') AS varStartDate, DATE_FORMAT(tbleventannouncement.varEndDate, '%d-%m-%Y') AS varEndDate, tbleventannouncement.varStartTime, ";
            //    query += " tbleventannouncement.varEndTime, tbleventannouncement.varLocation, tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, ";
            //    query += " tbleventannouncement.varContactName, tbleventannouncement.varMobile, tbleventannouncement.varEmail, tbleventannouncement.varEventImage, ";
            //    query += " tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy, tbleventannouncement.intIsActive, countrymaster.CountryName, ";
            //    query += " statemaster.StateName, citymaster.CityName, tblmastereventtype.varEventTypeName,concat(rolesmasterculturemap.RoleName,'-' ,tblsocietypersonnel.varEmpName) as Name";
            //    query += " FROM tbleventannouncement INNER JOIN";
            //    query += " countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN";
            //    query += " statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN";
            //    query += " citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN";
            //    query += " tblmastereventtype ON tbleventannouncement.intEventType = tblmastereventtype.intId INNER JOIN";
            //    query += " tblsocietypersonnel ON tbleventannouncement.varPersonalId = tblsocietypersonnel.intEmpCode INNER JOIN";
            //    query += " rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId";

            //    cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " where tbleventannouncement.intId =" + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con1);
            //    adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            //    adpp.Fill(dt);

            //    lstreply.DataSource = dt;
            //    lstreply.DataBind();

            //}
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
}