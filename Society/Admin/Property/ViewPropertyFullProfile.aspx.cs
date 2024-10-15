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
using System.IO;

public partial class Society_Admin_Property_ViewPropertyFullProfile : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string oldUsername = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if ((string)Cache["PropertyProfile"] == null)
            {
            }
            else
            {
                // Label1.Text = (string)Cache["PropertyProfile"];
              getPropertyOwnerDetails();
            getPhotoAlbum();
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
                string eid = (string)Cache["PropertyProfile"];
                sqlGallery.SelectCommand = "SELECT   varGallaryImage FROM tblsocietygallary where  varSocietyId='" + sid + "'  and 	varPersonalId='" + (string)Cache["PropertyProfile"] + "' order by  intId desc ";
                LstGallary.DataBind();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getPropertyOwnerDetails()
    {
        try
        {
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varPropertyId, varSocietyId, intRoleId, intWingId, intPremisesUnitId, intPremisesTypeId,     varPropertyCode, varName, varGender, varExtensionNo, varAlternateAddress, varPhoneNo, varMobile, varAlternateMobile, varEmail, varAlternateEmail, varUsername, varPassword, varCreatedDate, varCreatedBy, intIsActive,   varImage, varFBLink, varGoogleLink, varTwitterLink FROM tblproperty WHERE varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and  varPropertyId='" + (string)Cache["PropertyProfile"] + "'", dbc.con1);

            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {

                lblpFullName.Text = dbc.dr["varName"].ToString();
                lblPName.Text = dbc.dr["varName"].ToString();
                lblpGender.Text = dbc.dr["varGender"].ToString();
                lblpAddress.Text = dbc.dr["varAlternateAddress"].ToString();
                lblpphone.Text = dbc.dr["varPhoneNo"].ToString();
                lblpPrimaryMobile.Text = dbc.dr["varMobile"].ToString();
                lblpOtherMobile.Text = dbc.dr["varAlternateMobile"].ToString();
                lblpPrimaryEmail.Text = dbc.dr["varEmail"].ToString();
                lblpOtheremail.Text = dbc.dr["varAlternateEmail"].ToString();

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
                txtowner.Text = dbc.dr["varName"].ToString();
                txtphone.Text = dbc.dr["varPhoneNo"].ToString();
                txtmobile.Text = dbc.dr["varMobile"].ToString();
                txtEmail.Text = dbc.dr["varEmail"].ToString();
                txtAltMobileNos.Text = dbc.dr["varAlternateMobile"].ToString();
                txtAltEmailIds.Text = dbc.dr["varAlternateEmail"].ToString();
                txtaddress.Text = dbc.dr["varAlternateAddress"].ToString();

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