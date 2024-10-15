using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;

namespace SocietyKatta.App_Code.BAL.Society.MasterData
{

    /// <summary>
    /// Summary description for ClsRole
    /// </summary>
    public class ClsRole : System.Web.UI.Page
    {
        ClsDAL ObjDAL = new ClsDAL();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        public ClsRole()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        protected Int16 RoleId { get; set; }
        protected Int32 DeptId { get; set; }
        
        /// <summary>
        ///   role Master RoleId
        /// </summary>
        protected DateTime CreatedDate { get; set; }

        /// <summary>
        /// role Master CreatedDate
        /// </summary>
        protected int CreatedBy { get; set; }
        /// <summary>
        /// role Master CreatedBy
        /// </summary>
        protected string RoleName { get; set; }
        protected string SocietyId { get; set; }
        /// <summary>
        /// role master culture map  RoleName
        /// </summary>
        /// 

        protected int CultureId { get; set; }
        /// <summary>
        ///  role master culture map CultureId
        /// </summary>

        protected Int16 IsActive { get; set; }
        /// <summary>
        ///  role master IsActive
        /// </summary>
        /// <summary>
        ///Add role 
        /// </summary>
        /// 
        protected bool AddRoleDetails(int sDeptId, int sCreatedBy, string sRoleName, int sCultureId, Int16 sIsActive, string sSocietyId)
        {
            string[] parameterNames = { "@spDeptId", "@spCreatedBy", "@spRoleName", "@spCultureId", "@spIsActive", "@rValue", "@spSocietyId" };
            string[] parameterValues = { Convert.ToString(sDeptId), Convert.ToString(sCreatedBy), sRoleName, Convert.ToString(sCultureId), Convert.ToString(sIsActive), Convert.ToString(1), sSocietyId };
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                return ObjDAL.ExecuteTransaction("sp_insert_Role", parameterNames, parameterValues);
            }
        }
        /// <summary>
        ///get list of Country 
        /// </summary>

        public DataTable FetchRoleList(string spSocietyId)
        {
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                return ObjDAL.GetData("sp_select_Role", "@spSocietyId", Convert.ToString(spSocietyId));
            }
        }
        public DataTable FetchRoleListByDeptId(int spDeptId,string spAdminId)
        {
            string[] parameterNames = { "@spDeptId", "@spAdminId" };
            string[] parameterValues = { Convert.ToString(spDeptId), Convert.ToString(spAdminId) };

            using (ClsDAL ObjDAL = new ClsDAL())
            {
                dt1 = ObjDAL.GetData("sp_select_RoleByDepartmentId",parameterNames, parameterValues);
                if (dt1 != null)
                {
                    if (dt1.Rows.Count > 0)
                    {
                       // DeptId = Convert.ToInt16(dt1.Rows[0]["DeptId"].ToString());
                        return dt1;
                    }
                }
                return dt1;

            }
        }

    }
}