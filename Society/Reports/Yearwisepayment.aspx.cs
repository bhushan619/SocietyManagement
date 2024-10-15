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

public partial class Society_Reports_Yearwisepayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static List<InvoiceChart> GetChartData()
    {
        RegexUtilities rex = new RegexUtilities();
        DataTable dt = new DataTable();
        using (MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        {
            con.Open();
            MySqlCommand cmd = new MySqlCommand("SELECT        DATE_FORMAT(varDateTime,'%Y') as year ,   sum(tblinvoiceforpersonnels.varRecieved) as amount ,   sum(tblinvoiceforpersonnels.varOutstanding) as outamount  fROM    tblinvoice INNER JOIN     tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId WHERE  (tblinvoice.intFromSocietyId = '" + rex.DecryptString(HttpContext.Current.Request.Cookies["CookieSocietyId"].Value) + "') GROUP by  DATE_FORMAT(varDateTime, '%Y')", con);
            MySqlDataAdapter da = new MySqlDataAdapter(cmd);
            da.Fill(dt);
            con.Close();


        }

        List<InvoiceChart> dataList = new List<InvoiceChart>();


        foreach (DataRow dtrow in dt.Rows)
        {
            InvoiceChart details = new InvoiceChart();
            details.year = dtrow[0].ToString();
            details.amount = Convert.ToInt32(dtrow[1]);
            details.outamount = Convert.ToInt32(dtrow[2]);
            dataList.Add(details);
        }
        return dataList;
    }
}
public class InvoiceChart
{
    public string year { get; set; }
    public int amount { get; set; }
    public int outamount { get; set; }
}

