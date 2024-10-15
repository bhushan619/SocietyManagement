using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;


namespace SocietyKatta.App_Code.BAL.Admission
{
    /// <summary>
    /// Summary description for ClsAdmissionUserLogin
    /// </summary>
    public class ClsAdmissionUserLogin : System.Web.UI.Page
    {
        public ClsAdmissionUserLogin()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        /// <summary>
        /// 
        /// </summary>
        public string UserId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string SocietyId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string TitleId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string FirstName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string MiddleName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string FamilyName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string DisplayName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Username { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Password { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string UserImage { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string EmailAddress { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string Fax { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string CountryCode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string PhoneNumber { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string RoleId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string DefaultCultureId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string LicenceKey { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string DeviceType { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string IsBlocked { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string FirstLoginDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string LastLoginDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string LoginExpiryDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string RegisteredDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string IsLoggedIn { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string CreatedDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string CreatedBy { get; set; }
        /// <summary>
        /// 
        /// </summary>
        protected string IsActive { get; set; }

        /// <summary>
        /// 
        /// </summary>        
        DataTable dt = new DataTable();

        /// <summary>
        /// 
        /// </summary>
        /// <param name="paramaters"></param>
        /// <param name="paramaterValues"></param>
        /// <returns></returns>
        protected bool getAdmissionUserDetails(string[] paramaters, string[] paramaterValues)
        {
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                dt = ObjDAL.GetData("sp_select_UserOfSystem", paramaters, paramaterValues);
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        UserId = dt.Rows[0]["UserId"].ToString();
                        RoleId = dt.Rows[0]["RoleId"].ToString();
                        DisplayName = dt.Rows[0]["DisplayName"].ToString();
                        DefaultCultureId = dt.Rows[0]["DefaultCultureId"].ToString();
                        return true;
                    }
                }
                return false;
            }
        }
        /// <summary>
        /// forget Password
        /// </summary>
        /// <param name="paramaters"></param>
        /// <param name="paramaterValues"></param>
        /// <returns></returns>
        /// 
        protected DataTable getPasswordByEmail_UserID(string spUsername)
        {
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                dt = ObjDAL.GetData("sp_SelectPasswordFromEmailID", "@spUsername", Convert.ToString(spUsername));
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        Username = dt.Rows[0]["Username"].ToString();
                        Password = dt.Rows[0]["Password"].ToString();
                        UserId = dt.Rows[0]["UserId"].ToString();
                        return dt;
                    }
                }
                return dt;
            }
        }
        public bool UpdateChangePassword(int spUserId, string spPassword)
        {
            string[] parameterNames = { "@spUserId", "@spPassword" };
            string[] parameterValues = { Convert.ToString(spUserId), spPassword };
            using (ClsDAL ObjDAL = new ClsDAL())
            {
                return ObjDAL.ExecuteTransaction("sp_Update_ChangePassword", parameterNames, parameterValues);
            }
        }
        // sp_Update_ChangePassword

    }
}