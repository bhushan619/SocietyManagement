using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;


namespace SocietyKatta.App_Code.BAL.Society.MasterData
{
    public class ClsVendorService : System.Web.UI.Page
    {
        ClsDALServices ObjDAL = new ClsDALServices();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        public ClsVendorService()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        protected int intId { get; set; }
        protected int ServiceCode { get; set; }

       
        protected string Name { get; set; }
        protected string Description { get; set; }
        protected string VisitingFee { get; set; }

        protected string Remark { get; set; }

        protected DateTime CreatedDate { get; set; }
        protected int CreatedBy { get; set; }
        protected bool IsActive { get; set; }
        protected string varImage { get; set; }
        

        protected bool AddVendorServiceDetails( int ServiceCode,  string Name, string Description, string VisitingFee, string Remark, int CreatedBy, int IsActive,string img)
        {
            string[] parameterNames = { "@spServiceCode", "@spName", "@spDescription", "@spVisitingFee", "@spRemark", "@spCreatedBy", "@spIsActive", "@spvarImage", "@rValue" };
            string[] parameterValues = { Convert.ToString(ServiceCode),  Name, Description, VisitingFee, Remark, Convert.ToString(CreatedBy), Convert.ToString(IsActive), img,  Convert.ToString(1) };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_insert_VendorService", parameterNames, parameterValues);
            }
        }

        /// <summary>
        ///get list of Title 
        /// </summary>

        public DataTable FetchVendorService(Int16 isActive)
        {
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.GetData("sp_select_VendorService", "@spisActive", Convert.ToString(isActive));
            }
        }
        protected bool DeleteVendorServiceDetails(int spintServiceCode)
        {
            string[] parameterNames = { "@spintServiceCode" };
            string[] parameterValues = { Convert.ToString(spintServiceCode) };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_Delete_VendorService", parameterNames, parameterValues);
            }
        }
        public DataTable GetVendorServiceeById(int spintServiceCode)
        {
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                // return ObjDAL.GetData("FetchUserDetailsById");
                dt1 = ObjDAL.GetData("sp_select_VendorServiceById", "@spintServiceCode", Convert.ToString(spintServiceCode));
                if (dt1 != null)
                {
                    if (dt1.Rows.Count > 0)
                    {
                        ServiceCode = spintServiceCode;
                        //ServicetypeCode = Convert.ToInt32(dt1.Rows[0]["intServicetypeCode"].ToString());
                        ServiceCode = Convert.ToInt32(dt1.Rows[0]["intServiceCode"].ToString());
                        Name = dt1.Rows[0]["varName"].ToString();
                        Description = dt1.Rows[0]["varDescription"].ToString();
                        Remark = dt1.Rows[0]["varRemark"].ToString();
                        CreatedDate = Convert.ToDateTime(dt1.Rows[0]["CreatedDate"].ToString());
                        CreatedBy = Convert.ToInt32(dt1.Rows[0]["CreatedBy"].ToString());
                       VisitingFee = dt1.Rows[0]["varVisitingFee"].ToString();
                        IsActive = Convert.ToBoolean(dt1.Rows[0]["varIsActive"].ToString());
                        varImage = dt1.Rows[0]["varImage"].ToString();
                        return dt;
                    }
                }
                return dt;
            }
        }


        public bool UpdateVendorServiceTypeById( int ServiceCode, string Name, string Description, string Remark, string VisitingFee, int IsActive, string img)
        {
            string[] parameterNames = {  "@spServiceCode", "@spName", "@spDescription", "@spRemark", "@spVisitingFee", "@spIsActive", "@spvarImage" };
            string[] parameterValues = {  Convert.ToString(ServiceCode), Name, Description, Remark, Convert.ToString(VisitingFee), Convert.ToString(IsActive),img };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_Update_VendorService", parameterNames, parameterValues);
            }
        }

    }
}