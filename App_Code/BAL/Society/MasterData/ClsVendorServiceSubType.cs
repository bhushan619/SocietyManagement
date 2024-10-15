using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;

/// <summary>
/// Summary description for ClsVendorServiceSubType
/// </summary>
///
namespace SocietyKatta.App_Code.BAL.Society.MasterData
{
    public class ClsVendorServiceSubType : System.Web.UI.Page
    {
        ClsDALServices ObjDAL = new ClsDALServices();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        public ClsVendorServiceSubType()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        protected int intId { get; set; }
        protected int intServicesubtypeCode { get; set; }
        
        protected int ServicetypeCode { get; set; }
        protected int ServiceCode { get; set; }
        protected string Name { get; set; }
        protected string Description { get; set; }
        protected string varPrice { get; set; }        
        protected string Remark { get; set; }

        protected DateTime CreatedDate { get; set; }
        protected int CreatedBy { get; set; }
        protected bool IsActive { get; set; }
        protected bool AddVendorServiceSubTypeDetails(int intServicesubtypeCode, int SevicetypeCode, int ServiceCode, string Name, string Price, string Description, string Remark, int CreatedBy, int IsActive)
        {
            string[] parameterNames = { "@spintServicesubtypeCode", "@spSevicetypeCode", "@spServiceCode", "@spName", "@spPrice", "@spDescription", "@spRemark", "@spCreatedBy", "@spIsActive", "@rValue" };
            string[] parameterValues = { Convert.ToString(intServicesubtypeCode), Convert.ToString(SevicetypeCode), Convert.ToString(ServiceCode), Name, Price, Description, Remark, Convert.ToString(CreatedBy), Convert.ToString(IsActive), Convert.ToString(1) };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_insert_VendorServiceSubType", parameterNames, parameterValues);
            }
        }

        /// <summary>
        ///get list of Title 
        /// </summary>

        public DataTable FetchVendorServiceSubType()
        {
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.GetData("sp_select_VendorServiceSubType");
            }
        }

        protected bool DeleteVendorServiceTypeDetails(int spintServicesubtypeCode)
        {
            string[] parameterNames = { "@spintServicesubtypeCode" };
            string[] parameterValues = { Convert.ToString(spintServicesubtypeCode) };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_Delete_VendorServiceSubType", parameterNames, parameterValues);
            }
        }
        public DataTable GetVendorServiceTypeById(int spintServicesubtypeCode)
        {
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                // return ObjDAL.GetData("FetchUserDetailsById");
                dt1 = ObjDAL.GetData("sp_select_VendorServiceSubTypeById", "@spintServicesubtypeCode", Convert.ToString(spintServicesubtypeCode));
                if (dt1 != null)
                {
                    if (dt1.Rows.Count > 0)
                    {
                        intServicesubtypeCode = spintServicesubtypeCode;
                        ServicetypeCode = Convert.ToInt32(dt1.Rows[0]["intSevicetypeCode"].ToString());
                        ServiceCode = Convert.ToInt32(dt1.Rows[0]["intServiceCode"].ToString());
                        Name = dt1.Rows[0]["Type"].ToString();
                        Description = dt1.Rows[0]["varDescription"].ToString();
                        varPrice = dt1.Rows[0]["varPrice"].ToString();
                        Remark = dt1.Rows[0]["varRemark"].ToString();
                        CreatedDate = Convert.ToDateTime(dt1.Rows[0]["CreatedDate"].ToString());
                        CreatedBy = Convert.ToInt32(dt1.Rows[0]["CreatedBy"].ToString());
                        IsActive = Convert.ToBoolean(dt1.Rows[0]["varIsActive"].ToString());

                        return dt;
                    }
                }
                return dt;
            }
        }


        public bool UpdateVendorServiceSubTypeById(int ServicesubtypeCode, int ServiceCode, int ServicetypeCode, string Name, string Price, string Description, string Remark, int IsActive)
        {
            string[] parameterNames = { "@spServicesubtypeCode", "@spServiceCode", "@spServicetypeCode", "@spName", "@spPrice", "@spDescription", "@spRemark", "@spIsActive" };
            string[] parameterValues = { Convert.ToString(ServicesubtypeCode),Convert.ToString(ServiceCode), Convert.ToString(ServicetypeCode),  Name, Price, Description, Remark, Convert.ToString(IsActive) };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_Update_VendorServiceSubType", parameterNames, parameterValues);
            }
        }
    }
}