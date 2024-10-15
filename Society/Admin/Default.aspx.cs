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
public partial class Society_Admin_Default : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static List<InvoiceChart> GetChartData()
    {
        List<InvoiceChart> dataList = new List<InvoiceChart>();
        try
        {

            RegexUtilities rex = new RegexUtilities();
            DataTable dt = new DataTable();
            using (MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT 'Recieved' AS Value ,  IFNULL(SUM(varRecieved),0)  as Amount  FROM tblinvoiceforpersonnels where varSocietyId='" + rex.DecryptString(HttpContext.Current.Request.Cookies["CookieSocietyId"].Value) + "'", con);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
                con.Close();

                con.Open();
                cmd = new MySqlCommand("SELECT   'Outstanding' AS Value ,  IFNULL(SUM(varOutstanding),0) as Amount  FROM tblinvoiceforpersonnels where varSocietyId='" + rex.DecryptString(HttpContext.Current.Request.Cookies["CookieSocietyId"].Value) + "'", con);
                da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
                con.Close();
            } 

            foreach (DataRow dtrow in dt.Rows)
            {
                InvoiceChart details = new InvoiceChart();
                details.Value = dtrow[0].ToString();
                details.Amount = Convert.ToInt32(dtrow[1]);
                dataList.Add(details);
            }
            return dataList;
        }
        catch (Exception ex)
        {
            return dataList;
        }
    }
}
public class InvoiceChart
{
    public string Value { get; set; }
    public int Amount { get; set; }
}