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

public partial class Society_Property_Notifications : System.Web.UI.Page
{
    static int EditTypeId = 0;
    static string personel = string.Empty;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                personel = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);
            }
            else
            {
                personel = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value);
            }
            SqlDataSourceNotifications.SelectCommand = "SELECT varNotType,varNotText, varLink,  varStatus, intId,varRemark,intNotFromId FROM tblnotifications where  varSocietyId ='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and varNotToRoleId='" + rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) + "' and (intNotToId = '" + personel + "') order by varStatus desc";
            SqlDataSourceNotifications.DataBind();
        }

    }
  
    protected void lstNotification_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });

            string id = commandArgs[0];
            string link = commandArgs[1];
            string empcustid = commandArgs[2];
            string sesson = commandArgs[3];
            string remark = commandArgs[4];
            string type = commandArgs[5];
            string textmatter = commandArgs[6];


            if (e.CommandName == "Views")
            {
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("update tblnotifications set varStatus='Read' WHERE intId=" + id + "", dbc.con);
                cmd.ExecuteReader();
                dbc.con.Close();
                if (type == "Text")
                {
                    Response.Write("<script>alert('" + textmatter + "');window.location='Notification.aspx';</script>");
                    //Response.Write("<script>alert('" + textmatter + "');</script>");
                }
                //else if (type == "Page")
                //{
                //    Response.Redirect(link);
                //}
                //else if (type == "Session")
                //{
                //    if (remark == "Order")
                //    {
                //        Session.Add("orderid", sesson);
                //        Session.Add("empcustid", empcustid);
                //        Response.Redirect(link);
                //    }
                //    else if (remark == "emp")
                //    {
                //        Session.Add("empid", sesson);
                //        Response.Redirect(link);
                //    }
                //    else if (remark == "cust")
                //    {
                //        Session.Add("custid", sesson);
                //        Response.Redirect(link);
                //    }
                //}
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstNotification_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            (lstNotification.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            SqlDataSourceNotifications.SelectCommand = "SELECT varNotType,varNotText, varLink,  varStatus, intId,varRemark,intNotFromId FROM tblnotifications where  varSocietyId ='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and varNotToRoleId='" + rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) + "' and (intNotToId = '" + personel + "') order by varStatus desc";
            SqlDataSourceNotifications.DataBind();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lnkDeleteAll_Click(object sender, EventArgs e)
    {
        try
        {
            dbc.deleteAll_Notification(personel);
            SqlDataSourceNotifications.SelectCommand = "SELECT varNotType,varNotText, varLink,  varStatus, intId,varRemark,intNotFromId FROM tblnotifications where  varSocietyId ='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and varNotToRoleId='" + rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) + "' and (intNotToId = '" + personel + "') order by varStatus desc";
            SqlDataSourceNotifications.DataBind();
            // Response.Redirect("~/Personnel/admin/Notification.aspx");
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void btnReadAll_Click(object sender, EventArgs e)
    {
        try
        {
            dbc.readAll_Notification(personel);
            SqlDataSourceNotifications.SelectCommand = "SELECT varNotType,varNotText, varLink,  varStatus, intId,varRemark,intNotFromId FROM tblnotifications where  varSocietyId ='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and varNotToRoleId='" + rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) + "' and (intNotToId = '" + personel + "') order by varStatus desc";
            SqlDataSourceNotifications.DataBind();
            // Response.Redirect("~/Personnel/admin/Notification.aspx");
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}