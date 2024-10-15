using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;

public partial class MasterPages_SKAdminMaster : ClsMenus
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["LoggedRoleId"] == null)
        {
            Response.Redirect("~/SK/", false);
        }
        else if (!IsPostBack)
        {
            lblNav.Text = PopulateMenuAdmin(rex.DecryptString(Request.Cookies["LoggedEmpId"].Value));
        }
    }
}