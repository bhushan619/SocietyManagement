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
using System.Net.Mail;
using System.Net;

public partial class Society_View_FullEvent : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if ((string)Cache["eventIntId"] == null)
            {
            }
            else
            {
                // Label1.Text = (string)Cache["PropertyProfile"];
                getEventData();
            }
        }
    }
    public void getEventData()
    {
        try
        {
            DataTable dt = new DataTable();
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
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " where tbleventannouncement.intId =" + (string)Cache["eventIntId"] + "", dbc.con1);
            MySql.Data.MySqlClient.MySqlDataAdapter adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adpp.Fill(dt);
            dbc.con1.Close();
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

            cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " where tbleventannouncement.intId =" + (string)Cache["eventIntId"] + "", dbc.con1);
            adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adpp.Fill(dt);

            lstreply.DataSource = dt;
            lstreply.DataBind();
            dbc.con1.Close();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con1.Close();
            dbc.con.Close(); string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
}