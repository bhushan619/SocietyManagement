using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Collections.Generic;
using System.IO;
using System.Globalization;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;
using System.Net.Mail;
using System.Net;


public partial class Society_Admin_Employee_ViewEmpFullProfile : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string oldUsername = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if ((string)Cache["EmployeeProfile"] == "")
            {
                Response.Redirect("~/Society/Admin/Employee/ViewEmpolyee.aspx", false);
            }
            else
            {
               // Label1.Text =(string)Cache["EmployeeProfile"];
                getPhotoAlbum();
              
                getPersonalDetails();
            }
        }
        if (this.IsPostBack)
        {
           TabName.Value = Request.Form[TabName.UniqueID];
        }
    }
    public void getPhotoAlbum()
    {
        try
        {

            string sid = rex.DecryptString(Request.Cookies["CookieSocietyId"].Value);

            if (rex.DecryptString(Request.Cookies["LoggedRoleId"].Value) == dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner"))
            {
                string pid = rex.DecryptString(Request.Cookies["CookiePropertyId"].Value);

                sqlGallery.SelectCommand = "SELECT   varGallaryImage FROM tblsocietygallary where  varSocietyId='" + sid + "'  and 	varPersonalId='" + pid + "' order by  intId desc ";
                LstGallary.DataBind();
            }
            else
            {
                string eid =(string)Cache["EmployeeProfile"];
                sqlGallery.SelectCommand = "SELECT   varGallaryImage FROM tblsocietygallary where  varSocietyId='" + sid + "'  and 	varPersonalId='" + (string)Cache["EmployeeProfile"] + "' order by  intId desc ";
                LstGallary.DataBind();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getPersonalDetails()
    {
        try
        {
            dbc.con1.Open();
            // dbc.dr.Dispose();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("sp_Select_SocietyPersonnelFullDetail_By_WhereCondi", dbc.con1);
            cmd.CommandType = CommandType.StoredProcedure;
            string whereemp = "tblsocietypersonnel.intSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblsocietypersonnel.intEmpCode ='" +(string)Cache["EmployeeProfile"] + "'";
            //string whereproperty = "tblproperty.intSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblproperty.varPropertyId ='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'";
            cmd.Parameters.Add(new MySqlParameter("spwhere", whereemp));
            //      MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);


            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblpFullName.Text = dbc.dr["EmpName"].ToString();
                lblPName.Text = dbc.dr["EmpName"].ToString();
                //  varEmpPoliceVerify varMaritalStatus varFatherHusband varSpouseName varDateOfJoin varDOB varPANNo, varPFNo, varESINo, intCountry, intState, intCity, varPin,
                //varPermanentAddress
                lblpGender.Text = dbc.dr["varGender"].ToString();
                lblpAddress.Text = dbc.dr["varAddress"].ToString();
                // lblpphone.Text = dbc.dr["varPhoneNo"].ToString();
                lblpPrimaryMobile.Text = dbc.dr["varMbPrimary"].ToString();
                lblpOtherMobile.Text = dbc.dr["varMbOther"].ToString();
                lblpPrimaryEmail.Text = dbc.dr["varPrimaryEmail"].ToString();
                lblpOtheremail.Text = dbc.dr["varEmailOther"].ToString();

                lblpUsername.Text = dbc.dr["varUsername"].ToString();
                oldUsername = dbc.dr["varUsername"].ToString();
                hpfb.NavigateUrl = Page.ResolveUrl(dbc.dr["varFBLink"].ToString());
                hppfb.NavigateUrl = Page.ResolveUrl(dbc.dr["varFBLink"].ToString());

                hpgoogle.NavigateUrl = dbc.dr["varGoogleLink"].ToString();
                hppgoogle.NavigateUrl = dbc.dr["varGoogleLink"].ToString();

                hptwitter.NavigateUrl = dbc.dr["varTwitterLink"].ToString();
                hpptwitter.NavigateUrl = dbc.dr["varTwitterLink"].ToString();

                txttwitter.Text = dbc.dr["varTwitterLink"].ToString();
                txtfb.Text = dbc.dr["varFBLink"].ToString();
                txtgoogle.Text = dbc.dr["varGoogleLink"].ToString();

                txtUsername.Text = dbc.dr["varUsername"].ToString();
                txtowner.Text = dbc.dr["EmpName"].ToString();
                // txtphone.Text = dbc.dr["varPhoneNo"].ToString();
                txtmobile.Text = dbc.dr["varMbPrimary"].ToString();
                txtEmail.Text = dbc.dr["varPrimaryEmail"].ToString();
                txtAltMobileNos.Text = dbc.dr["varMbOther"].ToString();
                txtAltEmailIds.Text = dbc.dr["varEmailOther"].ToString();
                txtaddress.Text = dbc.dr["varAddress"].ToString();

                ddlCountry.Text = dbc.dr["CountryName"].ToString();
                ddlState.Text = dbc.dr["StateName"].ToString();
                ddlCity.Text = dbc.dr["CityName"].ToString();
 
                txtowner.Text = dbc.dr["EmpName"].ToString();
                txtPoliceVerify.Text = dbc.dr["varEmpPoliceVerify"].ToString();
                txtFatherHusband.Text = dbc.dr["varFatherHusband"].ToString();
                txtSpouse.Text = dbc.dr["varSpouseName"].ToString();
                txtDOB.Text = Convert.ToDateTime(dbc.dr["varDOB"].ToString()).ToString("dd-MM-yyyy");
               
                txtPANNo.Text = dbc.dr["varPANNo"].ToString();
                txtPFNo.Text = dbc.dr["varPFNo"].ToString();
                txtESINo.Text = dbc.dr["varESINo"].ToString();

                txtPinZip.Text = dbc.dr["varPin"].ToString();

                txtPermanentAddress.Text = dbc.dr["varPermanentAddress"].ToString();


                if (dbc.dr["varMaritalStatus"].ToString() == "Married")
                {
                    rgbMarried.Checked = true;
                }
                else if (dbc.dr["varMaritalStatus"].ToString() == "Unmarried")
                {
                    rgbUnmarried.Checked = true;
                }
                if (dbc.dr["varGender"].ToString() == "Male")
                {
                    rgbMale.Checked = true;
                }
                else if (dbc.dr["varGender"].ToString() == "Female")
                {
                    rgbFemale.Checked = true;
                }

                ImgProfile.ImageUrl = "~/Society/Media/ProfilePhoto/" + dbc.dr["varImage"].ToString();
             
            }
            dbc.con1.Close();
        }
        catch (Exception ex)
        {
            dbc.con1.Close();
            string exp = ex.Message;
        }
    }

}