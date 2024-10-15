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

public partial class SK_View_ViewSupport : System.Web.UI.Page
{

    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    static string EditPersonalId = string.Empty;
    static string Employeid = string.Empty;
    static int EditTypeId = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
         if (!IsPostBack)
        {

            getSupportData();
        }
    }
    public void getSupportData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con1.Close();
            dbc.con1.Open();
            string queryEmp = "SELECT intId, varPersonneId, intPersonelRole,DATE_FORMAT( varDate,'%d-%m-%Y') as varDate, varName, varUsername, varMobile, varEmail, varSubject, varDescription, varStatus, varRemark, intIsActive, ex1, ex2, ex3, ex4, ex5 FROM tblsksupport";
          
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(queryEmp + "    order by tblsksupport.intId desc", dbc.con1);
            MySql.Data.MySqlClient.MySqlDataAdapter adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adpp.Fill(dt);
          

           
            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con1.Close();


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

        this.getSupportData();
    }
    protected void lstType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            int claasifiedintid = Convert.ToInt32(e.CommandArgument.ToString());

           if (e.CommandName == "Pending")
            {
                dbc.update_tblsksupportBySKAdmin(Convert.ToInt32(e.CommandArgument.ToString()), "Pending");
            }
            else if (e.CommandName == "Resolved")
            {
                dbc.update_tblsksupportBySKAdmin(Convert.ToInt32(e.CommandArgument.ToString()), "Resolved");
            }
           getSupportData();
        }
        catch (Exception ex)
        {
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
}