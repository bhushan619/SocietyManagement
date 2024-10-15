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

public partial class Society_Extras_Notice : System.Web.UI.Page
{
    static string Employeid = string.Empty;
    static int EditTypeId = 0;
    static string EditPersonalId = string.Empty;
    DateTime datestart, dateend;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getListViewMasterData();
            getNoticeType();
        }
    }
    public void GetData()
    {
        try
        {
            ddlReportto.Disabled = false;
            ddlReportto.Items.Clear();
            dbc.con.Close();
            dbc.con.Open();

            MySqlCommand das = new MySqlCommand("SELECT  tblsocietypersonnel.intId, tblsocietypersonnel.intSocietyId, concat(tblsocietypersonnel.intEmpCode, ' - ',    tblsocietypersonnel.intRole) as intEmpCode, tblsocietypersonnel.intEmpType,concat( tblsocietypersonnel.varEmpName,' ( ',tblmasterdepartment.varDepartmentName, ' - ',    rolesmasterculturemap.RoleName,' )') as Name,  tblsocietypersonnel.varMbPrimary, tblsocietypersonnel.varMobile, tblsocietypersonnel.intIsActive,  tblsocietypersonnel.varPrimaryEmail FROM            tblsocietypersonnel INNER JOIN  tblmasterdepartment ON tblsocietypersonnel.intDeptId = tblmasterdepartment.intId INNER JOIN  rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE        (tblsocietypersonnel.intIsActive = 1) AND (tblsocietypersonnel.intSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "') AND (tblsocietypersonnel.intEmpCode != '" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "')", dbc.con);
            dbc.dr1 = das.ExecuteReader();
            while (dbc.dr1.Read())
            {
                ddlReportto.Items.Add(new ListItem(dbc.dr1["Name"].ToString(), dbc.dr1["intEmpCode"].ToString()));
                //ddlReportto.Items.FindByValue(dbc.dr1["intEmpCode"].ToString()).Selected = true;
            }
            ddlReportto.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void ddlAssignTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlAssignTo.SelectedValue == "1")
            {
                wing.Visible = false;
                GetData();
            }
            else if (ddlAssignTo.SelectedValue == "2")
            {
                wing.Visible = true;
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int insert_ok = 0;
        try
        {
            datestart = DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture);

            if (datestart > DateTime.UtcNow)
            {
                for (int i = 0; i <= ddlReportto.Items.Count - 1; i++)
                {
                    if (ddlReportto.Items[i].Selected)
                    {

                        insert_ok = dbc.insert_tblnotice(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), Convert.ToInt32(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)), Convert.ToInt32(0), Convert.ToInt32(ddlAssignTo.SelectedValue), txtTitle.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), txtDescription.Text.Replace("'", "\\'"), ddlReportto.Items[i].Value.ToString().Split('-')[0], DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), ddlReportto.Items[i].Text.ToString());
                        dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), ddlReportto.Items[i].Value.ToString().Split('-')[0], ddlReportto.Items[i].Value.ToString().Split('-')[1], "New Notice For You ", "", "", "Unread", "");

                        //  insert_ok = dbc.update_tblmasterparkinglevelslot(1, Convert.ToInt32(ddlParkingSlots.Items[i].Value.ToString()));

                    }   // sendmail(txtowner.Text.Replace("'", "\\'"), txtPassword.Text.Replace("'", "\\'"), Propertyid, txtEmail.Text);
                }
                if (insert_ok == 1)
                {
                    MessageDisplay(Resources.Messages.Added, "alert alert-success");
                    clear();
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");

                }
                getListViewMasterData();
            }
            else if (datestart.ToString("dd-MM-yyyy").Equals(DateTime.UtcNow.ToString("dd-MM-yyyy")))
            {
                for (int i = 0; i <= ddlReportto.Items.Count - 1; i++)
                {
                    if (ddlReportto.Items[i].Selected)
                    {

                        insert_ok = dbc.insert_tblnotice(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), Convert.ToInt32(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)), Convert.ToInt32(0), Convert.ToInt32(ddlAssignTo.SelectedValue), txtTitle.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), txtDescription.Text.Replace("'", "\\'"), ddlReportto.Items[i].Value.ToString().Split('-')[0], DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), ddlReportto.Items[i].Text.ToString());
                        dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), ddlReportto.Items[i].Value.ToString().Split('-')[0], ddlReportto.Items[i].Value.ToString().Split('-')[1], "New Notice For You ", "", "", "Unread", "");

                        //  insert_ok = dbc.update_tblmasterparkinglevelslot(1, Convert.ToInt32(ddlParkingSlots.Items[i].Value.ToString()));

                    }   // sendmail(txtowner.Text.Replace("'", "\\'"), txtPassword.Text.Replace("'", "\\'"), Propertyid, txtEmail.Text);
                }
                if (insert_ok == 1)
                {
                    MessageDisplay(Resources.Messages.Added, "alert alert-success");
                    clear();
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");

                }
                getListViewMasterData();
            }

            else
            {
                MessageDisplay(Resources.ErrorMessages.CurrectDate, "alert alert-danger");
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            // MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int Update_ok = dbc.update_tblnotice(Convert.ToInt32(EditTypeId), Convert.ToInt32(0), Convert.ToInt32(ddlAssignTo.SelectedValue), txtTitle.Text.Replace("'", "\\'"), Convert.ToDateTime(DateTime.ParseExact(txtDOB.Text.Replace("'", "\\'"), "dd-MM-yyyy", CultureInfo.InvariantCulture)).ToString("yyyy-MM-dd"), txtDescription.Text);

            if (Update_ok == 1)
            {
                MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                clear();
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }

            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
            EditTypeId = 0;
            clear();

            getListViewMasterData();

        }
        catch (Exception ex)
        {
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }


    }
    public void getNoticeType()
    {
        try
        {
            ddlWing.DataSource = dbc.GetSocietyWingMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlWing.DataTextField = "varWingName";
            ddlWing.DataValueField = "intId";
            ddlWing.DataBind();
            ddlWing.Items.Insert(0, new ListItem(":: Select Wing ::", ""));

            //ddlNoticeType.DataSource = dbc.GetNoticeTypeMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            //ddlNoticeType.DataTextField = "varNoticeTypeName";
            //ddlNoticeType.DataValueField = "intId";
            //ddlNoticeType.DataBind();
            //ddlNoticeType.Items.Insert(0, new ListItem(":: Select Notice Type ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void clear()
    {

        txtDescription.Text = "";
        txtTitle.Text = "";
        txtDOB.Text = "";
        ddlAssignTo.SelectedIndex = 0;
        //ddlNoticeType.SelectedIndex = 0;
        ddlReportto.SelectedIndex = 0;
        ddlReportto.Items.Clear();
        getNoticeType();
        //ddlNoticeType.SelectedIndex = 0;
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
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
    protected void lstType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edits")
            {

                btnUpdate.Visible = true;
                btnSubmit.Visible = false;
                dbc.con1.Close();
                dbc.con1.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varAssignType,           intNoticeType, varNoticeTitle, varValueDate, varDescription, varReportTo, varImage, varCreatedDate, varCreatedBy, intIsActive FROM tblnotice WHERE  intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con1);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId = Convert.ToInt32(dbc.dr["intId"].ToString());
                    EditPersonalId = (dbc.dr["varPersonalId"].ToString());
                    txtTitle.Text = dbc.dr["varNoticeTitle"].ToString();
                    txtDescription.Text = dbc.dr["varDescription"].ToString();
            
                    ddlAssignTo.SelectedValue = dbc.dr["varAssignType"].ToString();
                    txtDOB.Text = Convert.ToDateTime(dbc.dr["varValueDate"].ToString()).ToString("dd-MM-yyyy");
                    string sss = dbc.dr["varReportTo"].ToString();
                 

                    if (dbc.dr["varAssignType"].ToString().Equals("1"))
                    {

                        wing.Visible = false; 
                      
                        ddlReportto.Items.Clear();
                        dbc.con2.Close();
                        dbc.con2.Open();
                        MySqlCommand das = new MySqlCommand("SELECT  tblsocietypersonnel.intId, tblsocietypersonnel.intSocietyId,tblsocietypersonnel.intEmpCode as pid, concat(tblsocietypersonnel.intEmpCode, ' - ',    tblsocietypersonnel.intRole) as intEmpCode, tblsocietypersonnel.intEmpType,concat( tblsocietypersonnel.varEmpName,' ( ',tblmasterdepartment.varDepartmentName, ' - ',    rolesmasterculturemap.RoleName,' )') as Name,  tblsocietypersonnel.varMbPrimary, tblsocietypersonnel.varMobile, tblsocietypersonnel.intIsActive,  tblsocietypersonnel.varPrimaryEmail FROM            tblsocietypersonnel INNER JOIN  tblmasterdepartment ON tblsocietypersonnel.intDeptId = tblmasterdepartment.intId INNER JOIN  rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE        (tblsocietypersonnel.intIsActive = 1) AND tblsocietypersonnel.intSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  and tblsocietypersonnel.intEmpCode='" + sss + "'", dbc.con2);
                        dbc.dr2 = das.ExecuteReader();
                        if (dbc.dr2.Read())
                        { 
                            ddlReportto.Items.Add(new ListItem(dbc.dr2["Name"].ToString(), dbc.dr2["pid"].ToString()));
                            ddlReportto.Items.FindByText(dbc.dr2["Name"].ToString()).Selected = true;
                        }

                        dbc.con2.Close(); 
                    }
                    else
                    {
                        wing.Visible = true;
 
                        ddlReportto.Items.Clear();
                        dbc.con2.Close();
                        dbc.con2.Open();
                        MySqlCommand das = new MySqlCommand("SELECT tblproperty.intId, tblproperty.varPropertyCode as pid,tblproperty.intWingId,concat(tblproperty.varPropertyId,  ' - ',    tblproperty.intRoleId) as varPropertyId, tblproperty.intRoleId, CONCAT(tblproperty.varName,' ( ', tblmastersocietywing.varWingName,' - ', tblproperty.varPropertyCode,' )')   AS Name, tblproperty.varMobile, tblproperty.varEmail, tblproperty.intIsActive, tblproperty.varSocietyId FROM tblproperty INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE (tblproperty.intIsActive = 1) AND tblproperty.varSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  and tblproperty.varPropertyId='" + sss + "'", dbc.con2);
                        dbc.dr2 = das.ExecuteReader();
                        if (dbc.dr2.Read())
                        {
                            ddlWing.SelectedValue = dbc.dr2["intWingId"].ToString(); 
                           
                            ddlReportto.Items.Add(new ListItem(dbc.dr2["Name"].ToString(), dbc.dr2["pid"].ToString()));
                            ddlReportto.Items.FindByText(dbc.dr2["Name"].ToString()).Selected = true;
                        }
                       
                        dbc.con2.Close(); 

                    }
                     
                }
                dbc.con1.Close();
            }
            else if (e.CommandName == "Delets")
            {
                dbc.con1.Close();
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("delete from tblnotice where intId='" + e.CommandArgument + "'", dbc.con);
                int insert_ok = cmd.ExecuteNonQuery();
                dbc.con.Close();

                if (insert_ok == 1)
                {
                    MessageDisplay(Resources.Messages.Deleted, "alert alert-success");
                    clear();
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
                }
                getListViewMasterData();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con1.Close();
            dbc.con.Close();
        }
    }
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblnotice.intId, tblnotice.varSocietyId, tblnotice.intNoticeType, tblnotice.varNoticeTitle, tblnotice.varValueDate, tblnotice.varPersonalId,tblnotice.varAssignType, tblnotice.intRole,    tblnotice.varDescription, tblnotice.varReportTo, tblnotice.varCreatedDate, tblnotice.varCreatedBy, tblsocietypersonnel.intEmpCode, tblnotice.varName as Name,   tblsocietypersonnel.varEmpName as namse FROM            tblsocietypersonnel INNER JOIN    tblnotice ON tblsocietypersonnel.intEmpCode = tblnotice.varReportTo WHERE        tblnotice.varSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            dbc.con.Close();

            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdp = new MySql.Data.MySqlClient.MySqlCommand();
            cmdp = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblnotice.intId, tblnotice.varSocietyId, tblnotice.varPersonalId, tblnotice.intRole, tblnotice.intNoticeType, tblnotice.varAssignType, tblnotice.varNoticeTitle,       tblnotice.varValueDate, tblnotice.varDescription, tblnotice.varReportTo, tblnotice.varImage, tblproperty.varName  as namse,tblnotice.varName as Name, tblnotice.intIsActive FROM            tblnotice INNER JOIN     tblproperty ON tblnotice.varReportTo = tblproperty.varPropertyId WHERE        tblnotice.varSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'", dbc.con);
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


    protected void ddlWing_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlReportto.Disabled = false;
            ddlReportto.Items.Clear();
            dbc.con.Close();
            dbc.con.Open();
            MySqlCommand das = new MySqlCommand("SELECT tblproperty.intId, concat(tblproperty.varPropertyId,  ' - ',    tblproperty.intRoleId) as varPropertyId, tblproperty.intRoleId, CONCAT(tblproperty.varName,' ( ', tblmastersocietywing.varWingName,' - ', tblproperty.varPropertyCode,' )')   AS Name, tblproperty.varMobile, tblproperty.varEmail, tblproperty.intIsActive, tblproperty.varSocietyId FROM tblproperty INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE (tblproperty.intIsActive = 1) AND tblproperty.varSocietyId  = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblproperty.intWingId=" + Convert.ToInt32(ddlWing.SelectedValue) + "", dbc.con);
            dbc.dr1 = das.ExecuteReader();
            while (dbc.dr1.Read())
            {
                ddlReportto.Items.Add(new ListItem(dbc.dr1["Name"].ToString(), dbc.dr1["varPropertyId"].ToString()));
            }
            ddlReportto.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }
}