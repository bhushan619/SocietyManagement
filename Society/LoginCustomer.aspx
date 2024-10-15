<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["CookiePropertyId"] == null)
        {
            if (Request.Cookies["LoggedRoleId"] == null)
            {
                Response.Redirect("~/Home/", false);
            }
            else
            {
                dbc.con.Close();
                MySql.Data.MySqlClient.MySqlCommand cmdej = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varPrimaryEmail FROM  tblsocietypersonnel  WHERE  intEmpCode = '" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "' and intIsActive=1", dbc.con);
                dbc.con.Open();
                dbc.dr = cmdej.ExecuteReader();
                if (dbc.dr.Read())
                {
                    dbcs.con.Close();
                    MySql.Data.MySqlClient.MySqlCommand cmde = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varName, varMobile, varMobileVerify, varEmail, varEmailVerify,varPassword, varAddress, varLandline, varLandmark, varCountry, varState, varCity, varNeighbourhood, varStatus, imgImage, ex1, ex2, ex3 FROM tblcustomer WHERE varEmail='" + dbc.dr["varPrimaryEmail"].ToString() + "' and varStatus='1'", dbcs.con);
                    dbcs.con.Open();
                    dbcs.dr = cmde.ExecuteReader();
                    if (dbcs.dr.Read())
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

                        dbcs.dr.Close();
                    }
                }
                dbc.con.Close();
            }
        }
        else
        {
            Response.Redirect("~/Society/Logout.aspx", false);
        }
    }
    
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
