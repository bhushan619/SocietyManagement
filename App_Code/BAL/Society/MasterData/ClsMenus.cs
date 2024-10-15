using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;

namespace SocietyKatta.App_Code.BAL.Society.MasterData
{
    /// <summary>
    /// Summary description for ClsMenus
    /// </summary>
    public class ClsMenus : System.Web.UI.MasterPage
    {
        public ClsMenus()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        ClsDAL ObjDAL = new ClsDAL();
        DataTable dtMenu = new DataTable();
        DataTable dtSubMenu = new DataTable();
        DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
        public DataTable FetchMenuWithParentId(string sParentId)
        {
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                string[] parameterNames = { "@spParentId" };
                string[] parameterValues = { Convert.ToString(sParentId) };

                dtMenu = ObjDAL.GetData("sp_select_MenuFromFeature", parameterNames, parameterValues);
                if (dtMenu != null)
                {
                    if (dtMenu.Rows.Count > 0)
                    {
                        return dtMenu;
                    }
                }
                return dtMenu;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sParentId"></param>
        /// <param name="sCultureId"></param>
        /// <returns></returns>
        public DataTable FetchSubMenuWithParentId(int sParentId, string spintRoleId)
        {
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                string[] parameterNames = { "@spintRoleId", "@spParentMenuId" };
                string[] parameterValues = { Convert.ToString(spintRoleId), Convert.ToString(sParentId) };

                dtSubMenu = ObjDAL.GetData("sp_select_SubMenuFromFeature", parameterNames, parameterValues);
                if (dtSubMenu != null)
                {
                    if (dtSubMenu.Rows.Count > 0)
                    {
                        return dtSubMenu;
                    }
                }
                return dtSubMenu;
            }
        }
        /// <summary>
        /// Fetch Feature Name With CultureId
        /// </summary>
        /// <param name="sCultureId"></param>
        /// <returns></returns>
        private DataTable FetchFeatureWithSocietyId(string spintRoleId)
        {
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                dtMenu = ObjDAL.GetData("sp_select_Feature", "@spintRoleId", Convert.ToString(spintRoleId));
                if (dtMenu != null)
                {
                    if (dtMenu.Rows.Count > 0)
                    {
                        return dtMenu;
                    }
                }
                return dtMenu;
            }

        }

        public string PopulateMenu(string spintRoleId)
        {
            dtMenu = FetchFeatureWithSocietyId(spintRoleId);
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            if (dtMenu.Rows.Count > 0)
            {
                foreach (DataRow row in dtMenu.Rows)
                {
                    if (Convert.ToInt32(row["isSubMenu"].ToString()) != 1)
                    {
                        dtSubMenu = FetchSubMenuWithParentId(Convert.ToInt32(row["FeatureId"].ToString()), spintRoleId);
                        if (dtSubMenu.Rows.Count > 0)
                        {
                            sb.Append(@"<li><a href='javascript:;'><i class='" + row["varIcon"].ToString() + "'></i><span>" + row["varFeatureName"].ToString() + "</span></a>");
                            sb.Append(@"<ul class='acc-menu'>");
                            foreach (DataRow subrow in dtSubMenu.Rows)
                            {
                                sb.Append(@"<li><a runat=" + "server" + " href='" + Page.ResolveUrl(Convert.ToString(subrow["PageName"].ToString())) + "'>" + subrow["varFeatureName"].ToString() + "</a></li>");
                            }
                            sb.Append(@"</ul></li>");
                        }
                        else
                        {
                            if (row["varFeatureName"].ToString().Contains("Vendors"))
                            {
                                sb.Append(@"<li><a target='_blank' runat=" + "server" + " href='" + Page.ResolveUrl(Convert.ToString(row["PageName"].ToString())) + "'><i class='" + row["varIcon"].ToString() + "'></i><span>" + row["varFeatureName"].ToString() + "</span></a>");
                            }
                            else
                            {
                                sb.Append(@"<li><a runat=" + "server" + " href='" + Page.ResolveUrl(Convert.ToString(row["PageName"].ToString())) + "'><i class='" + row["varIcon"].ToString() + "'></i><span>" + row["varFeatureName"].ToString() + "</span></a>");
                            }
                        }
                    } 
                }
            }
            return sb.ToString();
        }


        public string get_tblnotifications(string societyId, string toid, string roleId)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            try
            {

                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varNotType, intNotFromId, varNotFromRoleId, intNotToId, varNotToRoleId, varNotText, varLink, varCache, varStatus, varRemark,DATE_FORMAT(varDateTime,'%d-%m-%Y') AS varDateTime, ex1, ex2 FROM tblnotifications WHERE  varStatus='Unread' and varSocietyId='" + societyId + "'  and varNotToRoleId='" + roleId + "' and intNotToId='" + toid + "' order by varDateTime DESC,intId DESC", dbc.con2);
                dbc.con2.Open();
                dbc.dr = cmd.ExecuteReader();
                while (dbc.dr.Read())
                { 
                    sb.Append(@"<li class='media notification-success'><a> <div class='media-left'><span class='notification-icon'><i class='ti ti-pencil'></i></span> </div><div class='media-body'><h4 class='notification-heading'>");
                    sb.Append(dbc.dr["varNotText"].ToString());
                    sb.Append(@"</h4><span class='notification-time'>");
                    sb.Append(dbc.dr["varDateTime"].ToString());
                    sb.Append(@"</span>");
                }
                dbc.con2.Close();
                return sb.ToString();
            }
            catch (Exception ex)
            {
                string exp = ex.Message;
                dbc.con2.Close();
                return sb.ToString();
            }
        }
        public int count_tblsunotifications(string societyId, string toid, string roleId)
        {
            int not = 0;
            try
            {
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select count(intId) as newid from tblnotifications where varStatus='Unread' and varSocietyId='" + societyId + "'and varNotToRoleId='" + roleId + "'  and intNotToId='" + toid + "' ", dbc.con2);
                dbc.con2.Open();
                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    not = Convert.ToInt32(dbc.dr["newid"].ToString());
                }
                dbc.con2.Close();
                return not;
            }
            catch (Exception ex)
            {
                string exp = ex.Message;
                dbc.con2.Close();
                return not;
            }
        }

        public string PopulateMenuAdmin(string spintRoleId)
        {
            dtMenu = FetchFeatureAdmin(spintRoleId);
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            if (dtMenu.Rows.Count > 0)
            {
                foreach (DataRow row in dtMenu.Rows)
                {
                    if (Convert.ToInt32(row["isSubMenu"].ToString()) != 1)
                    {
                        dtSubMenu = FetchSubMenuWithParentIdAdmin(Convert.ToInt32(row["FeatureId"].ToString()), spintRoleId);
                        if (dtSubMenu.Rows.Count > 0)
                        {
                            sb.Append(@"<li><a href='javascript:;'><i class='" + row["varIcon"].ToString() + "'></i><span>" + row["varFeatureName"].ToString() + "</span></a>");
                            sb.Append(@"<ul class='acc-menu'>");
                            foreach (DataRow subrow in dtSubMenu.Rows)
                            {
                                sb.Append(@"<li><a runat=" + "server" + " href='" + Page.ResolveUrl(Convert.ToString(subrow["PageName"].ToString())) + "'>" + subrow["varFeatureName"].ToString() + "</a></li>");
                            }
                            sb.Append(@"</ul></li>");
                        }
                        else
                        {
                            sb.Append(@"<li><a runat=" + "server" + " href='" + Page.ResolveUrl(Convert.ToString(row["PageName"].ToString())) + "'><i class='" + row["varIcon"].ToString() + "'></i><span>" + row["varFeatureName"].ToString() + "</span></a>");
                        }
                    }
                }
            }
            return sb.ToString();
        }

        private DataTable FetchFeatureAdmin(string spintRoleId)
        {
            using (ClsDALSKAdmin ObjDAL = new ClsDALSKAdmin())
            {
                dtMenu = ObjDAL.GetData("sp_select_FeatureAdmin", "@spintEmpId", Convert.ToString(spintRoleId));
                if (dtMenu != null)
                {
                    if (dtMenu.Rows.Count > 0)
                    {
                        return dtMenu;
                    }
                }
                return dtMenu;
            }

        }

        public DataTable FetchSubMenuWithParentIdAdmin(int sParentId, string spintRoleId)
        {
            using (ClsDALSKAdmin ObjDAL = new ClsDALSKAdmin())
            {
                string[] parameterNames = { "@varEmpId", "@spParentMenuId" };
                string[] parameterValues = { Convert.ToString(spintRoleId), Convert.ToString(sParentId) };

                dtSubMenu = ObjDAL.GetData("sp_select_SubMenuFromFeatureAdmin", parameterNames, parameterValues);
                if (dtSubMenu != null)
                {
                    if (dtSubMenu.Rows.Count > 0)
                    {
                        return dtSubMenu;
                    }
                }
                return dtSubMenu;
            }
        }
    }
}