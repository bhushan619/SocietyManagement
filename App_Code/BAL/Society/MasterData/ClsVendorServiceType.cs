using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;

/// <summary>
/// Summary description for ClsVendorServiceType
/// </summary>
/// 
namespace SocietyKatta.App_Code.BAL.Society.MasterData
{
    public class ClsVendorServiceType : System.Web.UI.Page
    {
        ClsDALServices ObjDAL = new ClsDALServices();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        public ClsVendorServiceType()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        protected int intId { get; set; }
        protected int ServicetypeCode { get; set; }
        protected int ServiceCode { get; set; }
        

        protected string Name { get; set; }
        protected string Description { get; set; }
       

        protected string Remark { get; set; }

        protected DateTime CreatedDate { get; set; }
        protected int CreatedBy { get; set; }
        protected bool IsActive { get; set; }

        protected bool AddVendorServiceTypeDetails(int ServicetypeCode, int ServiceCode, string Name, string Description,  string Remark, int CreatedBy, int IsActive)
        {
            string[] parameterNames = { "@spServicetypeCode", "@spServiceCode", "@spName", "@spDescription",  "@spRemark", "@spCreatedBy", "@spIsActive", "@rValue" };
            string[] parameterValues = { Convert.ToString(ServicetypeCode), Convert.ToString(ServiceCode), Name, Description,  Remark, Convert.ToString(CreatedBy), Convert.ToString(IsActive), Convert.ToString(1) };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_insert_VendorServiceType", parameterNames, parameterValues);
            }
        }

        /// <summary>
        ///get list of Title 
        /// </summary>

        public DataTable FetchVendorServiceType()
        {
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.GetData("sp_select_VendorServiceType");
            }
        }
        public DataTable FetchVendorServiceTypeByService(Int64 spServiceCode)
        {
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.GetData("sp_select_VendorServiceTypeByService", "@spServiceCode", Convert.ToString(spServiceCode));
            }
        }
        protected bool DeleteVendorServiceTypeDetails(int spintServicetypeCode)
        {
            string[] parameterNames = { "@spintServicetypeCode" };
            string[] parameterValues = { Convert.ToString(spintServicetypeCode) };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_Delete_VendorServiceType", parameterNames, parameterValues);
            }
        }
        public DataTable GetVendorServiceTypeById(int spintServicetypeCode)
        {
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                // return ObjDAL.GetData("FetchUserDetailsById");
                dt1 = ObjDAL.GetData("sp_select_VendorServiceTypeById", "@spintServicetypeCode", Convert.ToString(spintServicetypeCode));
                if (dt1 != null)
                {
                    if (dt1.Rows.Count > 0)
                    {
                        ServicetypeCode = spintServicetypeCode;
                        //ServicetypeCode = Convert.ToInt32(dt1.Rows[0]["intServicetypeCode"].ToString());
                        ServiceCode = Convert.ToInt32(dt1.Rows[0]["intServiceCode"].ToString());
                        Name = dt1.Rows[0]["Type"].ToString();
                        Description = dt1.Rows[0]["varDescription"].ToString();
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


        public bool UpdateVendorServiceTypeById(int ServicetypeCode, int ServiceCode, string Name, string Description, string Remark,  int IsActive)
        {
            string[] parameterNames = { "@spServicetypeCode", "@spServiceCode", "@spName", "@spDescription", "@spRemark",  "@spIsActive" };
            string[] parameterValues = { Convert.ToString(ServicetypeCode), Convert.ToString(ServiceCode), Name, Description, Remark,  Convert.ToString(IsActive) };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_Update_VendorServiceType", parameterNames, parameterValues);
            }
        }
    }
}