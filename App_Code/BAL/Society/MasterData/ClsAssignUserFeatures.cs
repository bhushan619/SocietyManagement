using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using SocietyKatta.App_Code;
using System.Data;


namespace SocietyKatta.App_Code.BAL.Society.MasterData
{

    /// <summary>
    /// Summary description for ClsAssignUserFeatures
    /// </summary>
    public class ClsAssignUserFeatures : System.Web.UI.Page
    {
        DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
        ClsDAL ObjDAL = new ClsDAL();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        public ClsAssignUserFeatures()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        protected int RoleId { get; set; }
        protected int FeatureId { get; set; }
        protected Int16 IsCreate { get; set; }
        protected Int16 IsRead { get; set; }
        protected Int16 IsUpdate { get; set; }
        protected Int16 IsDelete { get; set; }
        protected int SortOrder { get; set; }
        protected Int16 IsActive { get; set; }
        /// <summary>
        /// Add Role Feature Map
        /// </summary>
        /// <param name="sStateId"></param>
        /// <param name="sCityCode"></param>
        /// <param name="sTimeZoneId"></param>
        /// <param name="sCreatedBy"></param>
        /// <param name="sIsActive"></param>
        /// <param name="sCityName"></param>
        /// <param name="sCultureId"></param>
        /// <returns></returns>
        protected bool AddRoleFeatureMapDetails(int spRoleId, int spFeatureId, Int16 spIsCreate, Int16 spIsRead, Int16 spIsUpdate, Int16 spIsDelete, string varSocietyId, Int16 spIsActive)
        {
            string[] parameterNames = { "@spRoleId", "@spFeatureId", "@spIsCreate", "@spIsRead", "@spIsUpdate", "@spIsDelete", "@varSocietyId", "@spIsActive" };
            string[] parameterValues = { Convert.ToString(spRoleId), Convert.ToString(spFeatureId), Convert.ToString(spIsCreate), Convert.ToString(spIsRead), Convert.ToString(spIsUpdate), Convert.ToString(spIsDelete), Convert.ToString(varSocietyId), Convert.ToString(spIsActive) };
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                return ObjDAL.ExecuteTransaction("sp_insert_RoleFeaturesMap", parameterNames, parameterValues);
            }
        }
        public DataTable FetchRoleFeatureMapList(string SocietyId)
        {
            string[] parameterNames = { "@spvarSocietyId", "@spAdminId", "@spPropertyId" };
            string[] parameterValues = { SocietyId, dbc.GetPropertyOwnerRoleIdBySocietyId(SocietyId, "Admin"), dbc.GetPropertyOwnerRoleIdBySocietyId(SocietyId, "Property Owner") };

            using (ClsDAL ObjDAL = new ClsDAL())
            {
                return ObjDAL.GetData("sp_select_RoleFeaturesMap", parameterNames, parameterValues);
            }
        }

        protected bool AddRoleFeatureMapDetailsAdmin(int spRoleId, int spFeatureId, Int16 spIsCreate, Int16 spIsRead, Int16 spIsUpdate, Int16 spIsDelete, string varSocietyId, Int16 spIsActive)
        {
            string[] parameterNames = { "@spRoleId", "@spFeatureId", "@spIsCreate", "@spIsRead", "@spIsUpdate", "@spIsDelete", "@varSocietyId", "@spIsActive" };
            string[] parameterValues = { Convert.ToString(spRoleId), Convert.ToString(spFeatureId), Convert.ToString(spIsCreate), Convert.ToString(spIsRead), Convert.ToString(spIsUpdate), Convert.ToString(spIsDelete), Convert.ToString(varSocietyId), Convert.ToString(spIsActive) };
            using (ClsDALSKAdmin ObjDAL = new ClsDALSKAdmin())
            {
                return ObjDAL.ExecuteTransaction("sp_insert_RoleFeaturesMap", parameterNames, parameterValues);
            }
        }
        public DataTable FetchRoleFeatureMapListAdmin()
        { 
            using (ClsDALSKAdmin ObjDAL = new ClsDALSKAdmin())
            {
                return ObjDAL.GetData("sp_select_RoleFeaturesMap");
            }
        }

    }
}