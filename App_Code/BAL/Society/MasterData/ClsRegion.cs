using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;

namespace SocietyKatta.App_Code.BAL.SocietyKatta.MasterData
{

    /// <summary>
    /// Summary description for ClsRegion
    /// </summary>
    public class ClsRegion : System.Web.UI.Page
{
    ClsDAL ObjDAL = new ClsDAL();
    DataTable dt = new DataTable();
    DataTable dt1 = new DataTable();

    public ClsRegion()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    protected Int64 RegionId { get; set; }
    /// <summary>
    ///   Region Master RegionId
    /// </summary>

    protected string Region { get; set; }

    protected Int16 CreatedBy { get; set; }
    /// <summary>
    /// Region Master CreatedBy
    /// </summary>
    protected DateTime CreatedDate { get; set; }
    /// <summary>
    /// Region Master CreatedDate
    /// </summary>
    protected Int16 CultureId { get; set; }




    /// <summary>
    /// Add Region Details
    /// </summary>
    /// <param name="sRegion"></param>
    /// <param name="sCreatedBy"></param>
    /// <param name="sCultureId"></param>
    /// <returns></returns>
    protected bool AddRegionDetails(string sRegion, Int16 sCreatedBy, Int16 sCultureId)
    {
        string[] parameterNames = { "@spRegion", "@spCreatedBy",  "@spCultureId", "@rValue" };
        string[] parameterValues = { sRegion, Convert.ToString(sCreatedBy),  Convert.ToString(sCultureId), Convert.ToString(1) };
        using (ClsDAL ObjDAL = new ClsDAL())
        {
            return ObjDAL.ExecuteTransaction("sp_insert_Region", parameterNames, parameterValues);
        }
    }
    /// <summary>
    /// Fetch Region Details By CultureId
    /// </summary>
    /// <param name="cultureId"></param>
    /// <returns></returns>
    public DataTable FetchRegionByCultureId(int cultureId)
    {
        using (ClsDAL ObjDAL = new ClsDAL())
        {
            // return ObjDAL.GetData("FetchUserDetailsById");
            dt1 = ObjDAL.GetData("sp_Select_RegionByCultureId", "@spCultureId", Convert.ToString(cultureId));
            if (dt1 != null)
            {
                if (dt1.Rows.Count > 0)
                {
                    Region = dt1.Rows[0]["Region"].ToString();
                    //
                    RegionId = Convert.ToInt64(dt1.Rows[0]["RegionId"]);
                }
            }
            return dt1;
        }
    }
}
}