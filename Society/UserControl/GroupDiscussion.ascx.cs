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

public partial class Society_UserControl_GroupDiscussion : System.Web.UI.UserControl
{
    public static int PageSize = 2; DataTable dt = new DataTable();
    DatabaseConnection dbc = new DatabaseConnection();
    RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["CookieSocietyId"] == null)
        {
            Response.Redirect("~/Home/Login.aspx", false);
        }
        else if (!IsPostBack)
        {
            getGDData(4);
            PageSize = 5;
        }

    }
    
    protected void btnGD_Click(object sender, EventArgs e)
    {
        if (txtGdEnter.Text == "")
        {
        }
        else
        {
            dbc.con3.Open();
            dbc.cmd1 = new MySqlCommand("INSERT INTO tblgroupdiscussion( varSocietyId, intRoleId, varPersonnelId, varMessage, varDateTime ) VALUES ('" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "', '" + rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) + "', '" + rex.DecryptString(Request.Cookies["CookiePropertyId"] == null ? Request.Cookies["LoggedEmpId"].Value : Request.Cookies["CookiePropertyId"].Value) + "', '" + txtGdEnter.Text + "', '" + DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd hh:mm:ss") + "' )", dbc.con3);
            dbc.cmd1.ExecuteNonQuery();
            dbc.con3.Close();
        }
        txtGdEnter.Text = "";
        txtGdEnter.Focus();

        getGDData(4);
    }
    protected void LoadMore_Click(object sender, EventArgs e)
    {
        PageSize += 10;
        getGDData(PageSize);
    }

    public void getGDData(int limits)
    {
        DataTable dtGd = new DataTable();

        dbc.con3.Open();
        dbc.dataAdapter = new MySqlDataAdapter("SELECT DISTINCT varMessage, varDateTime, if((SELECT varName FROM tblproperty WHERE varPropertyId =varPersonnelId) is null, (SELECT CONCAT(varEmpName,':',varImage) FROM tblsocietypersonnel WHERE intEmpCode = varPersonnelId), (SELECT CONCAT(varName,':',varImage) FROM tblproperty WHERE varPropertyId = varPersonnelId)) as Name FROM tblgroupdiscussion WHERE (varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') AND tblgroupdiscussion.intId>=(select max(tblgroupdiscussion.intId) from tblgroupdiscussion) - " + (limits - 1) + " order by tblgroupdiscussion.varDateTime asc LIMIT " + limits + "", dbc.con3);
        dbc.dataAdapter.Fill(dtGd);
        dbc.con3.Close();


        lstGd.DataSource = dtGd;
        lstGd.DataBind();
       
    }
    public DataTable RemoveDuplicateRows(DataTable dTable, string colName)
    {
        Hashtable hTable = new Hashtable();
        ArrayList duplicateList = new ArrayList();

        //Add list of all the unique item value to hashtable, which stores combination of key, value pair.
        //And add duplicate item value in arraylist.
        foreach (DataRow drow in dTable.Rows)
        {
            if (hTable.Contains(drow[colName]))
                duplicateList.Add(drow);
            else
                hTable.Add(drow[colName], string.Empty);
        }

        //Removing a list of duplicate items from datatable.
        foreach (DataRow dRow in duplicateList)
            dTable.Rows.Remove(dRow);

        /////////////////////randomise row
        int index;
        System.Random rnd = new Random();
        // Remove and throw to the end random rows until we have done so n*3 times (shuffles the dataset)
        for (int i = 0; i < 10; i++)
        {
            if (dTable.Rows.Count == 0)
            {

            }
            else
            {
                index = rnd.Next(0, dTable.Rows.Count - 1);
                dTable.Rows.Add(dTable.Rows[index].ItemArray);
                dTable.Rows.RemoveAt(index);
            }
        }

        //Datatable which contains unique records will be return as output.
        return dTable;
    }
}