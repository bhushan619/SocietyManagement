using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;

/// <summary>
/// Summary description for ClsUsers
/// </summary>
namespace SocietyKatta.App_Code.BAL.Society.MasterData
{
    /// <summary>
    /// Summary description for ClsTitle
    /// </summary>
    public class ClsTitle : System.Web.UI.Page
    {
        ClsDAL ObjDAL = new ClsDAL();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        public ClsTitle()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        protected int TitleId { get; set; }
      
        protected DateTime CreatedDate { get; set; }
        protected int CreatedBy { get; set; }
        protected int IsActive { get; set; }
        protected string SocietyId { get; set; }
        protected string TitleName { get; set; }
        protected Int16 CultureId { get; set; }


        /// <summary>
        ///Add Title 
        /// </summary>
        /// 
        protected bool AddTitleDetails( string spsocietyid, int sCreatedBy , int sIsActive, string sTitleName, Int16 sCultureId)
        {
            string[] parameterNames = { "@spsocietyid", "@spCreatedBy", "@spIsActive", "@spTitleName", "@spCultureId", "@rValue" };
            string[] parameterValues = {spsocietyid, Convert.ToString(sCreatedBy),  Convert.ToString(sIsActive), sTitleName, Convert.ToString(sCultureId), Convert.ToString(1) };
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                return ObjDAL.ExecuteTransaction("sp_insert_Title", parameterNames, parameterValues);
            }
        }

        /// <summary>
        ///get list of Title 
        /// </summary>

        public DataTable FetchTitleListBySocietyId(string SocietyId)
        {
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                return ObjDAL.GetData("sp_select_Title", "@spSocietyId", Convert.ToString(SocietyId));
            }
        }
    }
}