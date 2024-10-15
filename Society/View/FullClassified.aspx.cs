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

public partial class Society_View_FullClassified : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if ( (string)Cache["claasifiedIntid"] ==null)
            {
            }
            else
            {
                // Label1.Text = (string)Cache["PropertyProfile"];
                getClassifiedData();
            }
        }
    }
    public void getClassifiedData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con1.Close();
            dbc.con1.Open();
            string queryEmp = "SELECT        tblclassified.intId, tblclassified.varSocietyId, tblclassified.intRole, tblclassified.varSubject, tblclassified.varDescription, tblclassified.varLocation, tblclassified.varPin,  ";
            queryEmp += "     tblclassified.varContactName, tblclassified.varMobile, tblclassified.varEmail, tblclassified.varClassifiedImage, DATE_FORMAT(tblclassified.varCreatedDate, '%d-%m-%Y') AS varCreatedDate, ";
            queryEmp += "  tblclassified.varCreatedBy, tblclassified.intIsActive, tblclassified.intCountry, tblclassified.intState, tblclassified.intCity, tblsocietypersonnel.varEmpName  as Name,";
            queryEmp += "    citymaster.CityName, statemaster.StateName, countrymaster.CountryName, rolesmasterculturemap.RoleName ";
            queryEmp += "  FROM            tblclassified INNER JOIN ";
            queryEmp += "     countrymaster ON tblclassified.intCountry = countrymaster.CountryId INNER JOIN ";
            queryEmp += "    statemaster ON tblclassified.intState = statemaster.StateId INNER JOIN ";
            queryEmp += "     citymaster ON tblclassified.intCity = citymaster.CityId INNER JOIN ";
            queryEmp += "     tblsocietypersonnel ON tblclassified.varPersonalId = tblsocietypersonnel.intEmpCode INNER JOIN ";
            queryEmp += "     rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId";


            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(queryEmp + " where tblclassified.intId =" + (string)Cache["claasifiedIntid"] + "", dbc.con1);
            MySql.Data.MySqlClient.MySqlDataAdapter adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adpp.Fill(dt);
            dbc.con1.Close();

            string query = "SELECT tblclassified.intId, tblclassified.varSocietyId, tblclassified.intRole, tblclassified.varSubject, tblclassified.varDescription, tblclassified.varLocation, tblclassified.varPin,  ";
            query += "  tblclassified.varContactName, tblclassified.varMobile, tblclassified.varEmail, tblclassified.varClassifiedImage, tblclassified.varCreatedDate,  ";
            query += "  tblclassified.varCreatedBy, tblclassified.intIsActive, tblproperty.intWingId, tblproperty.varPropertyCode, tblproperty.varName, tblmastersocietywing.varWingName, ";
            query += "  tblclassified.intCountry, tblclassified.intState, tblclassified.intCity, citymaster.CityName, statemaster.StateName, countrymaster.CountryName, ";
            query += " CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name";
            query += "  FROM  tblclassified INNER JOIN ";

            query += " tblproperty ON tblclassified.varPersonalId = tblproperty.varPropertyId INNER JOIN ";
            query += " tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId INNER JOIN ";
            query += " countrymaster ON tblclassified.intCountry = countrymaster.CountryId INNER JOIN ";
            query += "  statemaster ON tblclassified.intState = statemaster.StateId INNER JOIN ";
            query += "citymaster ON tblclassified.intCity = citymaster.CityId";
            dbc.con1.Open();
            cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " where tblclassified.intId =" + (string)Cache["claasifiedIntid"] + "", dbc.con1);
            adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adpp.Fill(dt);
            dbc.con1.Close();
            lstreply.DataSource = dt;
            lstreply.DataBind();
        }
        catch (Exception ex)
        {
            dbc.con1.Close();
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
}