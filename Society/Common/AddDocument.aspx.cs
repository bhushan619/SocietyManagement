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
using System.IO;
using System.Globalization;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;

public partial class Society_Common_AddDocument : System.Web.UI.Page
{
    static int EditTypeId = 0;
    static string EditPersonalId = string.Empty;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getListViewMasterData();
            getDocumentTypeMasterDataDropdownData();
        }
    }
    public void getDocumentTypeMasterDataDropdownData()
    {
        try
        {
            ddlDocumentType.DataSource = dbc.GetDocumentTypeMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlDocumentType.DataTextField = "varDocumentName";
            ddlDocumentType.DataValueField = "intId";
            ddlDocumentType.DataBind();
            ddlDocumentType.Items.Insert(0, new ListItem(":: Select Document Type ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
            string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
            string fileName = EditPersonalId + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;
            if (contentLength != 0)
            {
                string myStr = ImgProfile.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/Society/Media/Documents/") + fileName);
            }
            else
            {
                fileName = "NoProfile.png";
            }
            int insert_ok = 0;
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                insert_ok = dbc.insert_tbldocuments(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["CookiePropertyId"].Value), Convert.ToInt32(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)), Convert.ToInt32(ddlDocumentType.SelectedValue), txtDescription.Text.Replace("'", "\\'"), fileName, DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), rex.DecryptString(Request.Cookies["CookiePropertyId"].Value), 0, "Pending");
                dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["CookiePropertyId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[0], dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[1], "New Document Uploaded by " + dbc.get_PropertyOwnerName(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["CookiePropertyId"].Value)), "", "", "Unread", "");
            }
            else
            {
                if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Admin"))
                {
                    insert_ok = dbc.insert_tbldocuments(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), Convert.ToInt32(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)), Convert.ToInt32(ddlDocumentType.SelectedValue), txtDescription.Text.Replace("'", "\\'"), fileName, DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), 0, "Approved");
                }
                else
                {
                    insert_ok = dbc.insert_tbldocuments(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), Convert.ToInt32(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)), Convert.ToInt32(ddlDocumentType.SelectedValue), txtDescription.Text.Replace("'", "\\'"), fileName, DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), 0, "Pending");
                    dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[0], dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[1], "New Document Uploaded by " + dbc.get_EmployeeName(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value)), "", "", "Unread", "");
                }
            }
            if (insert_ok == 1)
            {
                MessageDisplay(Resources.ErrorMessages.DocumentApproval, "alert alert-success");
                clear();
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            }

            getListViewMasterData();
        }
        catch (Exception ex)
        {
            // MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
            string exp = ex.Message;
        }
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
                dbc.con.Close();
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonnelId, intRoleId, intDocumentType, varDescription, varDocument,intIsActive FROM tbldocuments WHERE intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId = Convert.ToInt32(dbc.dr["intId"].ToString());
                    EditPersonalId = (dbc.dr["varPersonnelId"].ToString());
                    txtDescription.Text = dbc.dr["varDescription"].ToString();
                   
                    ImgProfile.ImageUrl = "~/Society/Media/Documents/" + dbc.dr["varDocument"].ToString();
                    
                    ddlDocumentType.SelectedValue = (dbc.dr["intDocumentType"].ToString());

                    
                }
                dbc.con.Close();
            }
            else if (e.CommandName == "Delets")
            {
                dbc.con.Close();
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("DELETE FROM tbldocuments WHERE intId = " + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con);
                int i = cmd1.ExecuteNonQuery();
                dbc.con.Close();

                if (i == 1)
                {
                    MessageDisplay(Resources.Messages.Deleted, "alert alert-success");

                }
                else
                {
                    MessageDisplay(Resources.Messages.NotDeleted, "alert alert-danger");
                }
                getListViewMasterData();
            }
         
        }
        catch (Exception ex)
        {
            dbc.con.Close();
        }
    }
    public void getListViewMasterData()
    {
        try
        {
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                dbc.con.Close();
                DataTable dt = new DataTable();
                dbc.con.Open();
                EditPersonalId = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonnelId, intRoleId, (SELECT varDocumentName FROM tblmasterdocumenttype WHERE intId=intDocumentType) as Document, varDescription, varDocument,intIsActive,varStatus FROM tbldocuments WHERE varPersonnelId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "' ", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adp.Fill(dt);

                lstType.DataSource = dt;
                lstType.DataBind();
                dbc.con.Close();
            }
            else
            {
                dbc.con.Close();
                DataTable dt = new DataTable();
                dbc.con.Open();
                EditPersonalId = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value);
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonnelId, intRoleId, (SELECT varDocumentName FROM tblmasterdocumenttype WHERE intId=intDocumentType) as Document, varDescription, varDocument,intIsActive,varStatus FROM tbldocuments WHERE varPersonnelId='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "' ", dbc.con);
                MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
                adp.Fill(dt);

                lstType.DataSource = dt;
                lstType.DataBind();
                dbc.con.Close();
            }

        }
        catch (Exception ex)
        {
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
            string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
            string fileName = EditPersonalId + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;

            if (contentLength != 0)
            {
                string myStr = ImgProfile.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/Society/Media/Documents/") + fileName);
                int Update_ok = dbc.update_tbldocuments(Convert.ToInt32(EditTypeId), Convert.ToInt32(ddlDocumentType.SelectedValue), txtDescription.Text.Replace("'", "\\'"), fileName,0);
              //  dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", EditPersonalId, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[0], dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[1], "New Document Uploaded by ", "", "", "Unread", "");

                if (Update_ok == 1)
                {
                    MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                    clear();
                }
                else
                {
                    MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                }


            }
            else
            {
                string[] imgname = ImgProfile.ImageUrl.Split('/');
                int Update_ok = dbc.update_tbldocuments(Convert.ToInt32(EditTypeId), Convert.ToInt32(ddlDocumentType.SelectedValue), txtDescription.Text.Replace("'", "\\'"), imgname[4], 0);
               // dbc.insert_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "text", EditPersonalId, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value), dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[0], dbc.select_tblassignnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)).Split('-')[1], "New Document Uploaded by ", "", "", "Unread", "");

                if (Update_ok == 1)
                {
                    MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                    clear();
                }
                else
                {
                    MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                }



            }

            btnSubmit.Visible = true;
            btnUpdate.Visible = false;

            EditTypeId = 0;
            getListViewMasterData();
        }
        catch (Exception ex)
        {
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }

    public void clear()
    { 
        txtDescription.Text = "";
        ddlDocumentType.SelectedIndex = 0;
        ImgProfile.ImageUrl = "~/Society/Media/Documents/NoProfile.png";
    }

   
}