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

public partial class SK_View_ViewEnquiry : System.Web.UI.Page
{
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    static string EditPersonalId = string.Empty;
    static string Employeid = string.Empty;
    static int EditTypeId = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) == null)
        //{
        //    Response.Redirect("~/Home/Login.aspx", false);
        //}
        //else
        
        if (!IsPostBack)
        {

            getEnqiryData();
        }
    }
    public void getEnqiryData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con1.Open();
            string queryEmp = "SELECT intId, varName, varMobile, varEmail, varServiceName, varDescription, adhar, pan,DATE_FORMAT(createdDate,'%d-%m-%Y') as createdDate , ex4 FROM tblenquiry ";
        

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(queryEmp + "    order by tblenquiry.intId desc", dbc.con1);
            MySql.Data.MySqlClient.MySqlDataAdapter adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adpp.Fill(dt);
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

        this.getEnqiryData();
    }
}