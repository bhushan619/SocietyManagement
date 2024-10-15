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

public partial class Society_Property_ViewNotices : System.Web.UI.Page
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
        try
        {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
   
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdp = new MySql.Data.MySqlClient.MySqlCommand();
            cmdp = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblnotice.intId, tblnotice.varSocietyId, tblnotice.varPersonalId, tblnotice.intRole, tblnotice.intNoticeType, tblnotice.varAssignType, tblnotice.varNoticeTitle,       tblnotice.varValueDate, tblnotice.varDescription, tblnotice.varReportTo, tblnotice.varImage, tblproperty.varName  as namse,tblnotice.varName as Name, tblnotice.intIsActive FROM            tblnotice INNER JOIN     tblproperty ON tblnotice.varReportTo = tblproperty.varPropertyId WHERE        tblnotice.varSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblnotice.varReportTo='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "' ORDER BY tblnotice.varValueDate DESC", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmdp);
            adpp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }


    
}