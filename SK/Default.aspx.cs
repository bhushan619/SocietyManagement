using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SK_Default : BaseClass
{
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();
    RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    public void loginmethod()
    {
        try
        {
            string uname = txtUsername.Text;
            string pass = txtPassword.Text;

            MySql.Data.MySqlClient.MySqlCommand cmde = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intEmpCode, intDeptId, intRole, intEmpType, varEmpName, varFatherHusband, varDateOfJoin, varDOB, varGender, varMbPrimary, varMbOther, varEmailOther, varPANNo, varPFNo, varESINo, intCountry, intState, intCity, varPin, varAddress, varPermanentAddress, varPrimaryEmail, varUsername, varPassword, varMobile, varImage, intIsActive, intCreatedBy, varCreatedDate, ex1, ex2, ex3 FROM tblskpersonnel WHERE  varUsername='" + uname + "' and intIsActive=1", dbc.con);
            dbc.con.Open();
            dbc.dr = cmde.ExecuteReader();
            if (dbc.dr.Read())
            {
                if (dbc.dr["varPassword"].ToString() == pass)
                { 
                    HttpCookie LoggedEmpId = new HttpCookie("LoggedEmpId");
                    LoggedEmpId.Value = rex.EncryptString(dbc.dr["intEmpCode"].ToString());
                    Response.Cookies.Add(LoggedEmpId);

                    HttpCookie LoggedRoleId = new HttpCookie("LoggedRoleId");
                    LoggedRoleId.Value = rex.EncryptString(dbc.dr["intRole"].ToString());
                    Response.Cookies.Add(LoggedRoleId);
 
                    dbc.con.Close();
                    dbc.dr.Close();

                    Response.Redirect("~/SK/Dashboard.aspx", false);
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectLogin, "alert alert-danger");
                }

            }
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
}