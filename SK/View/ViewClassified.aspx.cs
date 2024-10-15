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
public partial class SK_View_ViewClassified : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string EditPersonalId = string.Empty;
    static string Employeid = string.Empty;
    static int EditTypeId = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
       
         if (!IsPostBack)
        {

            getClassifiedData();
        }
    }
    public void getClassifiedData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con1.Open();
            string queryEmp = "SELECT        tblclassified.intId, tblclassified.varSocietyId, tblclassified.intRole, tblclassified.varSubject, tblclassified.varDescription, tblclassified.varLocation, tblclassified.varPin,  ";
            queryEmp += "     tblclassified.varContactName, tblclassified.varMobile, tblclassified.varEmail, tblclassified.varClassifiedImage, DATE_FORMAT(tblclassified.varCreatedDate, '%d-%m-%Y') AS varCreatedDate, ";
            queryEmp += "  tblclassified.varCreatedBy, tblclassified.intIsActive,tblclassified.status, tblclassified.intCountry, tblclassified.intState, tblclassified.intCity, tblsocietypersonnel.varEmpName  as Name,";
            queryEmp += "    citymaster.CityName, statemaster.StateName, countrymaster.CountryName, rolesmasterculturemap.RoleName ";
            queryEmp += "  FROM            tblclassified INNER JOIN ";
            queryEmp += "     countrymaster ON tblclassified.intCountry = countrymaster.CountryId INNER JOIN ";
            queryEmp += "    statemaster ON tblclassified.intState = statemaster.StateId INNER JOIN ";
            queryEmp += "     citymaster ON tblclassified.intCity = citymaster.CityId INNER JOIN ";
            queryEmp += "     tblsocietypersonnel ON tblclassified.varPersonalId = tblsocietypersonnel.intEmpCode INNER JOIN ";
            queryEmp += "     rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId";


            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(queryEmp + "    order by tblclassified.intId desc", dbc.con1);
            MySql.Data.MySqlClient.MySqlDataAdapter adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adpp.Fill(dt);
            dbc.con1.Close();
            dbc.con.Close();
            dbc.con.Open();
            cmd = new MySql.Data.MySqlClient.MySqlCommand();

            string query = "SELECT tblclassified.intId, tblclassified.varSocietyId, tblclassified.intRole, tblclassified.varSubject, tblclassified.varDescription, tblclassified.varLocation, tblclassified.varPin,  ";
            query += "  tblclassified.varContactName, tblclassified.varMobile, tblclassified.varEmail, tblclassified.varClassifiedImage,DATE_FORMAT(tblclassified.varCreatedDate,'%d-%m-%Y') as varCreatedDate,  ";
            query += "  tblclassified.varCreatedBy, tblclassified.intIsActive,tblclassified.status, tblproperty.intWingId, tblproperty.varPropertyCode, tblproperty.varName, tblmastersocietywing.varWingName, ";
            query += "  tblclassified.intCountry, tblclassified.intState, tblclassified.intCity, citymaster.CityName, statemaster.StateName, countrymaster.CountryName ,";
            query += " CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name";
            query += "  FROM  tblclassified INNER JOIN ";
            query += " tblproperty ON tblclassified.varPersonalId = tblproperty.varPropertyId INNER JOIN ";
            query += " tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId INNER JOIN ";
            query += " countrymaster ON tblclassified.intCountry = countrymaster.CountryId INNER JOIN ";
            query += "  statemaster ON tblclassified.intState = statemaster.StateId INNER JOIN ";
            query += "citymaster ON tblclassified.intCity = citymaster.CityId";
            cmd = new MySql.Data.MySqlClient.MySqlCommand(query + "   order by tblclassified.intId desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con1.Close();
            dbc.con.Close();
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

        this.getClassifiedData();
    }
    protected void lstType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            int claasifiedintid = Convert.ToInt32(e.CommandArgument.ToString());

            if (e.CommandName == "Views")
            {
                Cache["claasifiedIntid"] = e.CommandArgument.ToString();
                Response.Redirect("~/SK/View/FullClassified.aspx", false);
            }
            else if (e.CommandName == "Approve")
            {
                dbc.update_tblclassifiedBySKAdmin(Convert.ToInt32(e.CommandArgument.ToString()), "Approve", 1);
            }
            else if (e.CommandName == "Reject")
            {
                dbc.update_tblclassifiedBySKAdmin(Convert.ToInt32(e.CommandArgument.ToString()), "Reject", 0);
            }
            getClassifiedData();
        }
        catch (Exception ex)
        {
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
}