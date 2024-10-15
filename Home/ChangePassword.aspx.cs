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

public partial class Home_ChangePassword : BaseClass
{
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();RegexUtilities rex = new RegexUtilities();

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Request.Cookies["CookieUser"] == null)
        {
            Response.Redirect("~/Society/Logout.aspx", false);
        }
        else
        {
            if (rex.DecryptString(Request.Cookies["CookieUser"].Value) == "Customer")
            {
                updateCustomerPassword();
            }
            else if(rex.DecryptString(Request.Cookies["CookieUser"].Value) == "Vendor")
            {
                updateVendorPassword();
            }
        }
    }
    string pass = string.Empty;
    public string getOldPassCustomer()
    {
        try
        {
            dbcs.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,varPassword FROM tblcustomer WHERE varEmail='" + rex.DecryptString(Request.Cookies["CookieCustomerEmail"].Value) + "'", dbcs.con);
            // cmd.ExecuteNonQuery(); 

            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                pass = reader["varPassword"].ToString();
            }

            dbcs.con.Close();
            return pass;

        }
        catch (Exception ex)
        {
            dbcs.con.Close();
            return "SKNA";
        }
    }
    public string getOldPassVendor()
    {
        try
        {
          
            dbcs.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,varPassword FROM tblvendor WHERE varEmailId='" + Request.Cookies["CookieVendorEmail"].Value + "'", dbcs.con);
            // cmd.ExecuteNonQuery();


            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                pass = reader["varPassword"].ToString();
            }

            dbcs.con.Close();
            return pass;

        }
        catch (Exception ex)
        {
            dbcs.con.Close();
            return "SKNA";
        }
    }

    public void updateCustomerPassword()
    {
        if (getOldPassCustomer().Equals(txtOldPass.Text))
        {
            if (txtNewPass.Text.Equals(txtConfNew.Text))
            {
                dbcs.con.Open();
                dbcs.cmd = new MySqlCommand("update tblcustomer set varPassword= '" + txtConfNew.Text.Replace("'", "\\'") +"' where varEmail='" + rex.DecryptString(Request.Cookies["CookieCustomerEmail"].Value) + "'", dbcs.con);
                dbcs.cmd.ExecuteNonQuery();
                dbcs.con.Close();

                MessageDisplay(Resources.ErrorMessages.OkPassword, "btn-success text-center");
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.SamePasswords, "btn-danger text-center");
            }
        }
        else
        {
            MessageDisplay(Resources.ErrorMessages.OldPassword, "btn-danger text-center");
        }
    }

    public void updateVendorPassword()
    {
        if (getOldPassVendor().Equals(txtOldPass.Text))
        {
            if (txtNewPass.Text.Equals(txtConfNew.Text))
            {
                dbcs.con.Open();
                dbcs.cmd = new MySqlCommand("update tblvendor set varPassword= '" + txtConfNew.Text.Replace("'", "\\'") +"' where varEmailId='" + Request.Cookies["CookieVendorEmail"].Value + "'", dbcs.con);
                dbcs.cmd.ExecuteNonQuery();
                dbcs.con.Close();

                MessageDisplay(Resources.ErrorMessages.OkPassword, "btn-success text-center");
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.SamePasswords, "btn-danger text-center");
            }
        }
        else
        {
            MessageDisplay(Resources.ErrorMessages.OldPassword, "btn-danger text-center");
        }
    }

    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
}