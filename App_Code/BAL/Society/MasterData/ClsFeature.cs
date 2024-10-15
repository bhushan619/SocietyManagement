using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;

namespace SocietyKatta.App_Code.BAL.Society.MasterData
{
    /// <summary>
    /// Summary description for ClsFeature
    /// </summary>
    public class ClsFeature : System.Web.UI.Page
    {
        ClsDAL ObjDAL = new ClsDAL();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        public ClsFeature()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        protected Int64 FeatureId { get; set; }
        /// <summary>
        ///   Feature Master FeatureId
        /// </summary>
        protected Int64 ParentId { get; set; }
        protected Int64 isSubMenu { get; set; }
        
        /// <summary>
        /// Feature Master ParentId
        /// </summary>spSocietyId
        protected string PageName { get; set; }
        protected string SocietyId { get; set; }
        
        protected Int16 CreatedBy { get; set; }
        /// <summary>
        /// Feature Master CreatedBy
        /// </summary>
        protected DateTime CreatedDate { get; set; }
        /// <summary>
        /// Feature Master CreatedDate
        /// </summary>
        /// 

        protected string FeatureName { get; set; }
        /// <summary>
        ///  Feature master culture map FeatureName
        /// </summary>

        protected int IsActive { get; set; }
        /// <summary>
        ///  Feature master culture map IsActive
        /// </summary>
        protected Int16 CultureId { get; set; }
        /// <summary>
        /// Feature master culture map CultureId
        /// </summary>
        /// 

        /// <summary>
        ///Add Feature 
        /// </summary>
        /// 
        protected bool AddFeatureDetails(Int64 sParentId, string sPageName, Int16 sCreatedBy, string sFeatureName, string spisSubMenu, Int16 sIsActive, Int16 sCultureId)
        {
            string[] parameterNames = { "@spParentId", "@spPageName", "@spCreatedBy", "@spFeatureName", "@spisSubMenu", "@spIsActive", "@spCultureId", "@rValue" };
            string[] parameterValues = { Convert.ToString(sParentId), sPageName, Convert.ToString(sCreatedBy), sFeatureName, spisSubMenu,Convert.ToString(sIsActive), Convert.ToString(sCultureId), Convert.ToString(1) };
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                return ObjDAL.ExecuteTransaction("sp_Insert_Feature", parameterNames, parameterValues);
            }
        }
        /// <summary>
        ///get list of Feature 
        /// </summary>
        //protected DataTable FetchCountryNameWithId()
        //{
        //    using (ClsDAL ObjDAL = new ClsDAL())
        //    {
        //        return ObjDAL.GetData("sp_select_CountryNameWithId");
        //    }
        //}
        /// <summary>
        /// Fetch Feature Name With CultureId
        /// </summary>
        /// <param name="sCultureId"></param>
        /// <returns></returns>
        public DataTable FetchFeatureWithsCultureId(int sCultureId)
        {
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                dt1 = ObjDAL.GetData("sp_select_Feature", "@spCultureId", Convert.ToString(sCultureId));
                if (dt1 != null)
                {
                    if (dt1.Rows.Count > 0)
                    {
                        FeatureId = Convert.ToInt16(dt1.Rows[0]["FeatureId"].ToString());
                        return dt1;
                    }
                }
                return dt1;

            }
      
        }
        /// <summary>
        /// Fetch Feature Name With CultureId
        /// </summary>
        /// <param name="sCultureId"></param>
        /// <returns></returns>

        public DataTable FetchMenuWithsSocietyId()
        {
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                dt1 = ObjDAL.GetData("sp_select_MenuFromFeature");
                if (dt1 != null)
                {
                    if (dt1.Rows.Count > 0)
                    {
                        FeatureId = Convert.ToInt16(dt1.Rows[0]["FeatureId"].ToString());
                        return dt1;
                    }
                }
                return dt1;

            }
        }

      
    }
}