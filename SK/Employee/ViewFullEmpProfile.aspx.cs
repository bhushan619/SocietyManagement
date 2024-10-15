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

using System.Net.Mail;
using System.Net;

public partial class SK_Employee_ViewFullEmpProfile : System.Web.UI.Page
{
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Cache["EmployeeProfile"] == null)
        {
            Response.Redirect("~/SK/Employee/ViewEmpolyee.aspx", false);
        }
        else if(!IsPostBack)
        {
          
            getPersonalDetails();
        }
    }
    public void getPersonalDetails()
    {
        try
        {
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT        rolesmaster.RoleName, tblskdepartment.varDepartmentName, tblskpersonnel.intEmpCode, tblskpersonnel.intId, tblskpersonnel.varEmpName,     tblskpersonnel.varMaritalStatus, tblskpersonnel.varFatherHusband, tblskpersonnel.varDateOfJoin, tblskpersonnel.varDOB, tblskpersonnel.varGender,  tblskpersonnel.varMbPrimary, tblskpersonnel.varMbOther, tblskpersonnel.varEmailOther, tblskpersonnel.varPANNo, tblskpersonnel.varPFNo,    tblskpersonnel.varESINo, tblskpersonnel.varPin, tblskpersonnel.varAddress, tblskpersonnel.varPermanentAddress, tblskpersonnel.varPrimaryEmail,    tblskpersonnel.varUsername, tblskpersonnel.varPassword, tblskpersonnel.varMobile, tblskpersonnel.varImage, tblskpersonnel.intIsActive,      tblskpersonnel.intCreatedBy, tblskpersonnel.varCreatedDate, countrymaster.CountryName, statemaster.StateName, citymaster.CityName,    tblskpersonnel.intRole   FROM            tblskpersonnel INNER JOIN    tblskdepartment ON tblskpersonnel.intDeptId = tblskdepartment.intId INNER JOIN   countrymaster ON tblskpersonnel.intCountry = countrymaster.CountryId INNER JOIN      statemaster ON tblskpersonnel.intState = statemaster.StateId INNER JOIN        citymaster ON tblskpersonnel.intCity = citymaster.CityId INNER JOIN         rolesmaster ON tblskpersonnel.intRole = rolesmaster.intId  WHERE tblskpersonnel.intId = " + Cache["EmployeeProfile"].ToString() + "", dbc.con1);

            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblPName.Text = dbc.dr["varEmpName"].ToString();
                //lblDepartment.Text = dbc.dr["varDepartmentName"].ToString();
                lblRole.Text = dbc.dr["RoleName"].ToString();

                lbldept.Text = dbc.dr["varDepartmentName"].ToString();
                lblrol.Text = dbc.dr["RoleName"].ToString();

                txtUsername.Text = dbc.dr["varUsername"].ToString();
                txtowner.Text = dbc.dr["varEmpName"].ToString();

                txtmobile.Text = dbc.dr["varMbPrimary"].ToString();
                txtEmail.Text = dbc.dr["varPrimaryEmail"].ToString();
                txtAltMobileNos.Text = dbc.dr["varMbOther"].ToString();
                txtAltEmailIds.Text = dbc.dr["varEmailOther"].ToString();
                txtaddress.Text = dbc.dr["varAddress"].ToString();

                txtowner.Text = dbc.dr["varEmpName"].ToString();

                txtFatherHusband.Text = dbc.dr["varFatherHusband"].ToString();

                txtDOB.Text = dbc.dr["varDOB"].ToString();
                ddlCountry.Text = dbc.dr["CountryName"].ToString();

                ddlState.Text = dbc.dr["StateName"].ToString();

                ddlCity.Text = dbc.dr["CityName"].ToString();

                txtPANNo.Text = dbc.dr["varPANNo"].ToString();
                txtPFNo.Text = dbc.dr["varPFNo"].ToString();
                txtESINo.Text = dbc.dr["varESINo"].ToString();

                txtPinZip.Text = dbc.dr["varPin"].ToString();

                txtPermanentAddress.Text = dbc.dr["varPermanentAddress"].ToString();


                if (dbc.dr["varMaritalStatus"].ToString() == "Married")
                {
                    rgbMarried.Text = "Married";
                }
                else if (dbc.dr["varMaritalStatus"].ToString() == "Unmarried")
                {
                    rgbMarried.Text = "Unmarried";
                }
                if (dbc.dr["varGender"].ToString() == "Male")
                {
                    rgbMale.Text = "Male";
                }
                else if (dbc.dr["varGender"].ToString() == "Female")
                {
                    rgbMale.Text = "Female";
                }

                ImgProfile.ImageUrl = "~/SK/Media/ProfilePhoto/" + dbc.dr["varImage"].ToString();
                
            }
            dbc.con1.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con1.Close();

        }

    }
}