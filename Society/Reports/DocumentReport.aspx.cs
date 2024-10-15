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

public partial class Society_Reports_DocumentReport : System.Web.UI.Page
{
    string datef, datet;
    MySql.Data.MySqlClient.MySqlCommand cmd, cmd1;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.IsPostBack)
        {
          
            SubTab.Value = Request.Form[SubTab.UniqueID];
        }
        if (!IsPostBack)
        {
            getdocumentData();
        }

    }
    public void getdocumentData()
    {
        try
        {
            DataTable dtdoc = new DataTable();
            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoc = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoc = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT     tbldocuments.varSocietyId, tbldocuments.varPersonnelId, tbldocuments.intRoleId, CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) as wing, tblproperty.varName AS Name FROM            tbldocuments INNER JOIN tblmasterdocumenttype ON tbldocuments.intDocumentType = tblmasterdocumenttype.intId INNER JOIN      tblproperty ON tbldocuments.varPersonnelId = tblproperty.varPropertyId INNER JOIN  tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE      tbldocuments.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tbldocuments.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoc = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoc);
            adpdoc.Fill(dtdoc);

            lstDocument.DataSource = dtdoc;
            lstDocument.DataBind();
            dbc.con.Close();

            DataTable dtdoce = new DataTable();
            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT tbldocuments.varSocietyId, tbldocuments.varPersonnelId, tbldocuments.intRoleId, tblsocietypersonnel.varEmpName FROM     tbldocuments INNER JOIN  tblmasterdocumenttype ON tbldocuments.intDocumentType = tblmasterdocumenttype.intId INNER JOIN  tblsocietypersonnel ON tbldocuments.varPersonnelId = tblsocietypersonnel.intEmpCode whERE    tbldocuments.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tbldocuments.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoce = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoce);
            adpdoce.Fill(dtdoce);

            lstDocEmployee.DataSource = dtdoce;
            lstDocEmployee.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }

    protected void lstDocument_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            this.DataPagerDocument.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getdocumentData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstDocument_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "viewprofile")
            {
                Cache["PropertyProfile"] = e.CommandArgument.ToString().Split('-')[1];
                Response.Redirect("~/Society/Admin/Property/ViewPropertyFullProfile.aspx", false);
            }
                getdocumentData();
          
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstDocEmployee_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {

            this.DataPagerDocEmp.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getdocumentData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void lstDocEmployee_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "viewprofile")
            {
                if (e.CommandArgument.ToString().Split('-')[0].Contains("SKSE"))
                {
                    if (e.CommandArgument.ToString().Split('-')[0].Equals(rex.DecryptString(Request.Cookies["LoggedEmpId"].Value)))
                    {
                        Response.Redirect("~/Society/Common/MyProfile.aspx", false);
                    }
                    else
                    {
                        Cache["EmployeeProfile"] = e.CommandArgument.ToString().Split('-')[0];
                        Response.Redirect("~/Society/Admin/Employee/ViewEmpFullProfile.aspx", false);
                    }
                }
               
            }
            else
            {
                if (e.CommandName == "ViewFullDocumentList")
                {
                   
                }
                
                getdocumentData();
            }
        }

        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static List<string> GetCompletionList(string prefixText, int count, string contextKey)
    {
        String connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(connStr);
        con.Open();
        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT     tbldocuments.varSocietyId, tbldocuments.varPersonnelId, tbldocuments.intRoleId, CONCAT(tblproperty.varName, ' ( ' ,tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ' ) ') as varName  FROM            tbldocuments INNER JOIN tblmasterdocumenttype ON tbldocuments.intDocumentType = tblmasterdocumenttype.intId INNER JOIN      tblproperty ON tbldocuments.varPersonnelId = tblproperty.varPropertyId INNER JOIN  tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE varName like '%" + prefixText + "%'", con);
        //     cmd.Parameters.AddWithValue("@Name", prefixText);
        MySql.Data.MySqlClient.MySqlDataAdapter da = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        int j = 0;
        List<string> CompanyName = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            CompanyName.Add(dt.Rows[i][3].ToString());
            //  CompanyName[j++] =dt.Rows[i][0].ToString();
        }
        con.Close();
        return CompanyName;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try {
            if (txtPropertyName.Text == "")
            {
                ScriptManager.RegisterStartupScript(
                          this,
                          this.GetType(),
                          "MessageBox",
                           "alert('Please Enter  Name....');", true);
            }
            else
            {
                string name = txtPropertyName.Text;
                string[] spit = name.Split('(');
                getPropertydocumentData(spit[0]);
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getPropertydocumentData(string Name)
    {
        try
        {
            DataTable dtdoc = new DataTable();
            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoc = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoc = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT     tbldocuments.varSocietyId, tbldocuments.varPersonnelId, tbldocuments.intRoleId, CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode) as wing, tblproperty.varName AS Name FROM            tbldocuments INNER JOIN tblmasterdocumenttype ON tbldocuments.intDocumentType = tblmasterdocumenttype.intId INNER JOIN      tblproperty ON tbldocuments.varPersonnelId = tblproperty.varPropertyId INNER JOIN  tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE      tblproperty.varName='" + Name + "' ", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoc = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoc);
            adpdoc.Fill(dtdoc);

            lstDocument.DataSource = dtdoc;
            lstDocument.DataBind();
            dbc.con.Close();
         
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }

    //employee
    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static List<string> GetCompletionListemployee(string prefixText, int count, string contextKey)
    {
        String connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(connStr);
        con.Open();
        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT tbldocuments.varSocietyId, tbldocuments.varPersonnelId, tbldocuments.intRoleId, tblsocietypersonnel.varEmpName FROM     tbldocuments INNER JOIN  tblmasterdocumenttype ON tbldocuments.intDocumentType = tblmasterdocumenttype.intId INNER JOIN  tblsocietypersonnel ON tbldocuments.varPersonnelId = tblsocietypersonnel.intEmpCode whERE tblsocietypersonnel.varEmpName like '%" + prefixText + "%'", con);
        //     cmd.Parameters.AddWithValue("@Name", prefixText);
        MySql.Data.MySqlClient.MySqlDataAdapter da = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        int j = 0;
        List<string> CompanyName = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            CompanyName.Add(dt.Rows[i][3].ToString());
            //  CompanyName[j++] =dt.Rows[i][0].ToString();
        }
        con.Close();
        return CompanyName;
    }
    protected void btnSearchemployee_Click(object sender, EventArgs e)
    {
        try {
            if (txtemplyeeName.Text == "")
            {
                ScriptManager.RegisterStartupScript(
                          this,
                          this.GetType(),
                          "MessageBox",
                           "alert('Please Enter  Name....');", true);
            }
            else
            {
                getemployeedocumentData(txtemplyeeName.Text);
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getemployeedocumentData(string Name)
    {
        try
        {
            DataTable dtdoce = new DataTable();
            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT DISTINCT tbldocuments.varSocietyId, tbldocuments.varPersonnelId, tbldocuments.intRoleId, tblsocietypersonnel.varEmpName FROM     tbldocuments INNER JOIN  tblmasterdocumenttype ON tbldocuments.intDocumentType = tblmasterdocumenttype.intId INNER JOIN  tblsocietypersonnel ON tbldocuments.varPersonnelId = tblsocietypersonnel.intEmpCode whERE    tblsocietypersonnel.varEmpName='" + Name + "' ", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoce = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoce);
            adpdoce.Fill(dtdoce);

            lstDocEmployee.DataSource = dtdoce;
            lstDocEmployee.DataBind();
            dbc.con.Close();

        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }

}