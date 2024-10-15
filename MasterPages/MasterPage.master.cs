using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;

public partial class MasterPages_MasterPage : ClsMenus
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["CookieSocietyId"] == null || Request.Cookies["LoggedRoleId"] == null)
        {
            Response.Redirect("~/Home/Login.aspx", false);
        }
        else if (!IsPostBack)
        {
            lblNav.Text = PopulateMenu(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value));
            string personel = string.Empty;
            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                personel = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);
                adminemp.NavigateUrl = "~/Society/Property/Dashbord.aspx";
                Notify.NavigateUrl = "~/Society/Property/Notifications.aspx";
                profile.NavigateUrl = "~/Society/Property/MyProfile.aspx";
            }
            else
            {
                personel = rex.DecryptString(Request.Cookies["LoggedEmpId"].Value);

                Notify.NavigateUrl = "~/Society/Common/Notifications.aspx";
                profile.NavigateUrl = "~/Society/Common/MyProfile.aspx";
                if (dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Admin").Equals(rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)))
                {
                    adminemp.NavigateUrl = "~/Society/Admin/Dashbord.aspx";
                }
                else
                {
                    adminemp.NavigateUrl = "~/Society/Admin/Employee/Dashbord.aspx";
                }
            }
            lblNotifications.Text = get_tblnotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), personel, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value));
            lblNotificationCount.Text = count_tblsunotifications(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), personel, rex.DecryptString(Request.Cookies["LoggedRoleId"].Value)).ToString();

        }
    }
}
