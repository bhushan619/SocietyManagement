using System;
using SocietyKatta.DAL;
using System.Data;
using System.Web;

/// <summary>
/// Summary description for ClsLoginAccess
/// </summary>
namespace SocietyKatta.App_Code.BAL.Users
{
    public class ClsLoginAccess
    {
        public bool IsCreate { get; set; }
        public bool IsRead { get; set; }
        public bool IsUpdate { get; set; }
        public bool IsDelete { get; set; }

        public ClsLoginAccess()
        {

        }

        public bool CheckLoginUserAccess(string loginUserId, string pageName)
        {
            DataTable dt = new DataTable();
            dt = new ClsDAL().GetData("CheckLoginUserAccess", new string[] { "@inUserId", "@inPageName" }, new string[] { loginUserId, pageName });
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    IsCreate = Convert.ToBoolean(dt.Rows[0]["IsCreate"].ToString());
                    IsRead = Convert.ToBoolean(dt.Rows[0]["IsRead"].ToString());
                    IsUpdate = Convert.ToBoolean(dt.Rows[0]["IsUpdate"].ToString());
                    IsCreate = Convert.ToBoolean(dt.Rows[0]["IsDelete"].ToString());
                    return true;
                }
            }
            return false;
        }
    }
}