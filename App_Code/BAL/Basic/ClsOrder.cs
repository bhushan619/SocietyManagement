using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using SocietyKatta.DAL;
using System.Data;

namespace SocietyKatta.App_Code.BAL
{
    public class ClsOrder : System.Web.UI.Page
    {
        ClsDAL ObjDAL = new ClsDAL();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        public ClsOrder()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        //Order
        protected int intId { get; set; }
        protected int OrderId { get; set; }
         
    
        protected int CustId { get; set; }
        protected string Date { get; set; }
        protected string Time { get; set; }
        protected string Location { get; set; }

        protected string Service { get; set; }
        protected string TotalPrice { get; set; }
        protected string Coupen { get; set; }
        protected string CreatedDate { get; set; }

        protected string RemarkByCust { get; set; }
        protected string Completion { get; set; }
        protected string AssignTo { get; set; }
        protected string RemarkByAdmin { get; set; }
        protected string Status { get; set; }
        protected string AssignedBy { get; set; }
        protected bool IsActive { get; set; }

        //Customer
        protected string Name { get; set; }
        protected string Mobile { get; set; }
        protected string Email { get; set; }

        protected string Address { get; set; }
        protected string Landmark { get; set; }

        //   OrderId CustId Date Time Location Service TotalPrice Coupen RemarkByCust Completion AssignTo RemarkByAdmin Status AssignedBy IsActive
        protected bool AddOrderDetails(int OrderId,string name ,string mobile,string email,string address,string landmark, string Date, string Time, string Location, string Service, string TotalPrice, string Coupen, int IsActive)
        {
            string[] parameterNames = { "@spOrderId", "@spname", "@spmobile", "@spemail", "@spaddress", "@splandmark", "@spDate", "@spTime", "@spLocation", "@spService", "@spTotalPrice", "@spCoupen", "@spIsActive", "@rValue" };
            string[] parameterValues = { Convert.ToString(OrderId), name, mobile, email, address, landmark,Date, Time, Location, Service ,TotalPrice, Coupen, Convert.ToString(IsActive), Convert.ToString(1) };
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                return ObjDAL.ExecuteTransaction("sp_insert_Order_Customer", parameterNames, parameterValues);
            }
        }
        public DataTable FetchOrderDetails(Int16 isActive)
        {
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                return ObjDAL.GetData("sp_select_Order_Customer", "@spisActive", Convert.ToString(isActive));
            }
        }
    }
}