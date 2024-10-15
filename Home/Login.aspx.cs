using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_Login : BaseClass
{
    DatabaseConnection dbc = new DatabaseConnection(); 
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();
    RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["vid"] == null)
        {
        }
        else
        {
            verifymethod();
        }
    }
    public void loginmethod()
    {
        try
        {
            string uname = txtUsername.Text;
            string pass = txtPassword.Text;
            
            #region society
            if (ddlUserType.SelectedValue == "1")
            {
                MySql.Data.MySqlClient.MySqlCommand cmde = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intSocietyId,intEmpCode,intRole,varPassword FROM tblsocietypersonnel WHERE varUsername='" + uname + "' and intIsActive=1", dbc.con);
                dbc.con.Open();
                dbc.dr = cmde.ExecuteReader();
                if (dbc.dr.Read())
                {
                    if (dbc.dr["varPassword"].ToString() == pass)
                    {
                        HttpCookie CookieSocietyId = new HttpCookie("CookieSocietyId");
                        CookieSocietyId.Value = rex.EncryptString(dbc.dr["intSocietyId"].ToString());
                        Response.Cookies.Add(CookieSocietyId);

                        HttpCookie LoggedEmpId = new HttpCookie("LoggedEmpId");
                        LoggedEmpId.Value = rex.EncryptString(dbc.dr["intEmpCode"].ToString());
                        Response.Cookies.Add(LoggedEmpId);

                        HttpCookie LoggedRoleId = new HttpCookie("LoggedRoleId");
                        LoggedRoleId.Value = rex.EncryptString(dbc.dr["intRole"].ToString());
                        Response.Cookies.Add(LoggedRoleId);
                        string sid = dbc.dr["intSocietyId"].ToString();
                        string rid = dbc.dr["intRole"].ToString();
                        dbc.con.Close();
                        dbc.dr.Close();
                        if (dbc.GetPropertyOwnerRoleIdBySocietyId(sid, "Admin").Equals(rid))
                        {
                            Response.Redirect("../Society/Admin/Dashbord.aspx", false);
                        }
                        else
                        {
                            Response.Redirect("../Society/Admin/Employee/Dashbord.aspx", false);
                        }

                    }
                    else
                    {
                        MessageDisplay(Resources.ErrorMessages.IncorrectLogin, "alert alert-danger");
                    }
                }
                else
                {
                    dbc.con.Close();
                    MySql.Data.MySqlClient.MySqlCommand cmdej = new MySql.Data.MySqlClient.MySqlCommand("SELECT        intId, varPropertyId, varSocietyId, intRoleId, varUsername, varPassword FROM            tblproperty  WHERE  varUsername = '" + uname + "' and intIsActive=1", dbc.con);
                    dbc.con.Open();
                    dbc.dr = cmdej.ExecuteReader();
                    if (dbc.dr.Read())
                    {
                        if (dbc.dr["varPassword"].ToString() == pass)
                        {
                            HttpCookie CookieSocietyId = new HttpCookie("CookieSocietyId");
                            CookieSocietyId.Value = rex.EncryptString(dbc.dr["varSocietyId"].ToString());
                            Response.Cookies.Add(CookieSocietyId);

                            HttpCookie CookiePropertyId = new HttpCookie("CookiePropertyId");
                            CookiePropertyId.Value = rex.EncryptString(dbc.dr["varPropertyId"].ToString());
                            Response.Cookies.Add(CookiePropertyId);

                            HttpCookie LoggedRoleId = new HttpCookie("LoggedRoleId");
                            LoggedRoleId.Value = rex.EncryptString(dbc.dr["intRoleId"].ToString());
                            Response.Cookies.Add(LoggedRoleId);

                            Response.Redirect("../Society/Property/Dashbord.aspx", false);

                            dbc.dr.Close(); dbc.con.Close();
                        }
                        else
                        {
                            MessageDisplay(Resources.ErrorMessages.IncorrectLogin, "btn-danger text-center");
                        }
                    }
                    MessageDisplay(Resources.ErrorMessages.IncorrectLogin, "btn-danger text-center");
                }
            }
            #endregion
            #region customer
            else if (ddlUserType.SelectedValue == "2")
            {

                dbcs.con.Close();
                MySql.Data.MySqlClient.MySqlCommand cmdej = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varName, varMobile, varMobileVerify, varEmail, varEmailVerify,varPassword, varAddress, varLandline, varLandmark, varCountry, varState, varCity, varNeighbourhood, varStatus, imgImage, ex1, ex2, ex3 FROM tblcustomer WHERE varEmail='" + txtUsername.Text.Replace("'", "\\'") +"' and varStatus='1'", dbcs.con);
                dbcs.con.Open();
                dbcs.dr = cmdej.ExecuteReader();
                if (dbcs.dr.Read())
                {
                    if (dbcs.dr["varPassword"].ToString() == pass)
                    {
                        HttpCookie CookieCustomerEmail = new HttpCookie("CookieCustomerEmail");
                        CookieCustomerEmail.Value = rex.EncryptString(dbcs.dr["varEmail"].ToString());
                        Response.Cookies.Add(CookieCustomerEmail);

                        HttpCookie CookieCustomerID = new HttpCookie("CookieCustomerID");
                        CookieCustomerID.Value = rex.EncryptString(dbcs.dr["intId"].ToString());
                        Response.Cookies.Add(CookieCustomerID);

                        HttpCookie CookieUser = new HttpCookie("CookieUser");
                        CookieUser.Value = rex.EncryptString("Customer");
                        Response.Cookies.Add(CookieUser);

                        Response.Redirect("~/Home/ViewOrders.aspx", false);

                        dbcs.dr.Close(); dbc.con.Close();
                    }
                    else
                    {
                        MessageDisplay(Resources.ErrorMessages.IncorrectLogin, "btn-danger text-center");
                    }
                }
            }
            #endregion
            #region vendor
            else if (ddlUserType.SelectedValue == "3")
            {
                dbcs.con.Close();
                MySql.Data.MySqlClient.MySqlCommand cmdej = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intVendorCode, varName, varContactPerson, varPhoneNo, varMobileNo, varEmailId, varCountry, varState, varCity, varAddress, varNeighbourhood, varPincode, varUsername, varPassword, varCreatedDate, CreatedBy, varIsActive, ex2, ex3 FROM tblvendor WHERE varUsername='" + txtUsername.Text.Replace("'", "\\'") +"' and varIsActive=1", dbcs.con);
                dbcs.con.Open();
                dbcs.dr = cmdej.ExecuteReader();
                if (dbcs.dr.Read())
                {
                    if (dbcs.dr["varPassword"].ToString() == pass)
                    {
                        HttpCookie CookieVendorEmail = new HttpCookie("CookieVendorEmail");
                        CookieVendorEmail.Value = rex.EncryptString(dbcs.dr["varEmailId"].ToString());
                        Response.Cookies.Add(CookieVendorEmail);

                        HttpCookie CookieVendorID = new HttpCookie("CookieVendorID");
                        CookieVendorID.Value = rex.EncryptString(dbcs.dr["intId"].ToString());
                        Response.Cookies.Add(CookieVendorID);

                        HttpCookie CookieUser = new HttpCookie("CookieUser");
                        CookieUser.Value = rex.EncryptString("Vendor");
                        Response.Cookies.Add(CookieUser);

                        Response.Redirect("~/Home/ViewOrders.aspx", false);

                        dbcs.dr.Close(); dbc.con.Close();
                    }
                    else
                    {
                        MessageDisplay(Resources.ErrorMessages.IncorrectLogin, "btn-danger text-center");
                    }
                }
            }
            #endregion
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            Response.Write("<script>alert('" + ex.Message + "')</script>");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (txtUsername.Text == "")
        {
            MessageDisplay(Resources.GlobalResource.EmptyField, "btn-danger text-center");
        }
        else if (txtPassword.Text == "")
        {
            MessageDisplay(Resources.GlobalResource.EmptyField, "btn-danger text-center");
        }
        else if (rex.IsValidEmail(txtUsername.Text))
        {
            loginmethod();
        }
        else
        {
            loginmethod();
            // loginmethodbyuserid();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="message">Messagge Text</param>
    /// <param name="cssClass">CSS class name</param>
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
    protected void aa_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home/SignUp.aspx", false); ;
    }

    public void verifymethod()
    {
        try
        {
            dbcs.con.Close();
            dbcs.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select intId, varName, varMobile, varEmail, varEmailVerify ,varPassword, varStatus, imgImage from tblcustomer where varEmailVerify='" + Request.QueryString["vid"].ToString() + "'", dbcs.con);
            dbcs.dr = cmd.ExecuteReader();
            if (dbcs.dr.Read())
            {
                string ids = dbcs.dr["intId"].ToString();
                dbcs.con.Close();
                dbcs.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblcustomer SET varEmailVerify='true', varStatus='1' where intId=" + ids + "", dbcs.con);
                cmd1.ExecuteNonQuery();
                dbcs.con.Close();

                MessageDisplay(Resources.Messages.Verified, "btn-success text-center");
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.IncorrectDetails, "btn-danger text-center");
            }
        }
        catch (Exception s)
        {
            string ss = s.Message;
            MessageDisplay(Resources.ErrorMessages.IncorrectDetails, "btn-danger text-center");
        }
    }
}