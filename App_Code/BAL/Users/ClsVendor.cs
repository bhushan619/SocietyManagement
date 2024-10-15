using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using SocietyKatta.DAL;
using System.Data;

namespace SocietyKatta.App_Code.BAL
{
    public class ClsVendor : System.Web.UI.Page
    {
        ClsDALServices ObjDAL = new ClsDALServices();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        public ClsVendor()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        protected int intId { get; set; }
        protected string VendorCode { get; set; }


        protected string FirstName { get; set; }

        protected string ContactPerson { get; set; }

        protected string PhoneNo { get; set; }
        protected string MobileNo { get; set; }
        protected string EmailId { get; set; }
        protected string Country { get; set; }

        protected string State { get; set; }
        protected string City { get; set; }
        protected string Pincode { get; set; }

        protected string varNeighbourhood { get; set; }
        protected string Address { get; set; }
        protected string Service { get; set; }

        protected string Username { get; set; }
        protected string Password { get; set; }
        protected string varImage { get; set; }
        protected DateTime varCreatedDate { get; set; }
        protected int CreatedBy { get; set; }
        protected string IsActive { get; set; }

        protected string SvarName { get; set; }
        protected string varDescription { get; set; }
        protected string varAbout { get; set; }
        protected string varCharges { get; set; }

        protected bool AddVendorSDetails(string varName, string varContactPerson, string varPhoneNo, string varMobileNo, string varEmailId, string varCountry, string varState, string varCity, string varAddress, string varNeighbourhood, string varPincode, string varUsername, string varPassword, string varCreatedDate, string CreatedBy, string varIsActive, string varAbout, string varImage, string varCharges, string varDescription, string intServiceId)
        {
            string[] parameterNames = { "@varName", "@varContactPerson", "@varPhoneNo", "@varMobileNo", "@varEmailId", "@varCountry", "@varState", "@varCity", "@varAddress", "@varNeighbourhood", "@varPincode", "@varUsername", "@varPassword", "@varCreatedDate", "@CreatedBy", "@varIsActive", "@varAbout", "@varImage", "@varCharges", "@varDescription", "@intServiceId" };
            string[] parameterValues = { varName, varContactPerson, varPhoneNo, varMobileNo, varEmailId, varCountry, varState, varCity, varAddress, varNeighbourhood, varPincode, varUsername, varPassword, varCreatedDate, CreatedBy, varIsActive, varAbout, varImage, varCharges, varDescription, intServiceId };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_insert_Vendor", parameterNames, parameterValues);
            }
        }

        /// <summary>
        ///get list of Title 
        /// </summary>

        public DataTable FetchVendor()
        {
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.GetData("sp_select_Vendor");
            }
        }

         
        public DataTable GetVendorDataById(string spintVendorCode)
        {
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                // return ObjDAL.GetData("FetchUserDetailsById");
                dt1 = ObjDAL.GetData("sp_select_VendorById", "@spintVendorCode", Convert.ToString(spintVendorCode));
                if (dt1 != null)
                {
                    if (dt1.Rows.Count > 0)
                    {
                        VendorCode = spintVendorCode;
                        //ServicetypeCode = Convert.ToInt32(dt1.Rows[0]["intServicetypeCode"].ToString());
                        VendorCode = dt1.Rows[0]["intVendorCode"].ToString();
                        FirstName = dt1.Rows[0]["varName"].ToString();

                        ContactPerson = dt1.Rows[0]["varContactPerson"].ToString();

                        PhoneNo = dt1.Rows[0]["varPhoneNo"].ToString();
                        MobileNo = dt1.Rows[0]["varMobileNo"].ToString();
                        EmailId = dt1.Rows[0]["varEmailId"].ToString();
                        Country = dt1.Rows[0]["varCountry"].ToString();
                        State = dt1.Rows[0]["varState"].ToString();
                        City = dt1.Rows[0]["varCity"].ToString();
                        Pincode = dt1.Rows[0]["varPincode"].ToString();

                        varNeighbourhood = dt1.Rows[0]["varNeighbourhood"].ToString();
                        Address = dt1.Rows[0]["varAddress"].ToString();

                        Username = dt1.Rows[0]["varUsername"].ToString();
                        Password = dt1.Rows[0]["varPassword"].ToString();
                        varCreatedDate = Convert.ToDateTime(dt1.Rows[0]["varCreatedDate"].ToString());
                        CreatedBy = Convert.ToInt32(dt1.Rows[0]["CreatedBy"].ToString());

                        IsActive = dt1.Rows[0]["varIsActive"].ToString();

                        varImage = dt1.Rows[0]["varImage"].ToString();
                        varDescription = dt1.Rows[0]["Description"].ToString();
                        varAbout = dt1.Rows[0]["varAbout"].ToString();
                        varCharges = dt1.Rows[0]["Charges"].ToString();
                        SvarName = dt1.Rows[0]["ServicevarName"].ToString();

                        return dt;
                    }
                }
                return dt;
            }
        }


        public bool UpdateVendorDataById(string VendorCode, string FirstName, string ContactPerson, string PhoneNo, string MobileNo, string EmailId, string Country, string State, string City, string Pincode, string Address, string varNeighbourhood, string Username, string Password, int IsActive, string varAbout, string varImage, string varCharges, string varDescription, string intServiceId)
        {
            string[] parameterNames = { "@spVendorCode", "@spFirstName", "@spContactPerson", "@spPhoneNo", "@spMobileNo", "@spEmailId", "@spCountry", "@spState", "@spCity", "@spPincode", "@spAddress", "@spNeighbourhood", "@spUsername", "@spPassword", "@spIsActive", "@varAbout", "@varImage", "@varCharges", "@varDescription", "@intServiceId" };
            string[] parameterValues = { Convert.ToString(VendorCode), FirstName, ContactPerson, PhoneNo, MobileNo, EmailId, Country, State, City, Pincode, Address, varNeighbourhood, Username, Password, Convert.ToString(IsActive), varAbout, varImage, varCharges, varDescription, intServiceId };
            using (ClsDALServices ObjDAL = new ClsDALServices())
            {
                return ObjDAL.ExecuteTransaction("sp_Update_Vendor", parameterNames, parameterValues);
            }
        }

    }
}