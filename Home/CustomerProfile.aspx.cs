using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_CustomerProfile : BaseClass
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();
    static int EditId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["CookieCustomerID"] == null)
        {
            Response.Redirect("~/Society/Logout.aspx", false);
        }
        else if (!IsPostBack)
        {
            getCountryData();
            getCustomerData();
        }
    }
    public void getCountryData()
    {
        try
        {
            ddlCountry.DataSource = dbc.GetCountryMasterData();
            ddlCountry.DataTextField = "CountryName";
            ddlCountry.DataValueField = "CountryId";
            ddlCountry.DataBind();
            ddlCountry.Items.Insert(0, new ListItem(":: Select Country ::", ""));

            
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlState.DataSource = dbc.GetstateMasterDataFromCountryId(Convert.ToInt32(ddlCountry.SelectedValue));
            ddlState.DataTextField = "StateName";
            ddlState.DataValueField = "StateId";
            ddlState.DataBind();
            ddlState.Items.Insert(0, new ListItem(":: Select State ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }

    }
    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlCity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(ddlState.SelectedValue));
            ddlCity.DataTextField = "CityName";
            ddlCity.DataValueField = "CityId";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem(":: Select City ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getCustomerData()
    {

        try
        {
            dbcs.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varName,        varMobile, varMobileVerify, varEmail, varEmailVerify, varAddress,   varPassword, varLandline, varLandmark, varCountry, varState, varCity,                varNeighbourhood, varStatus, imgImage FROM tblcustomer WHERE intId=" + Convert.ToInt32(rex.DecryptString(Request.Cookies["CookieCustomerID"].Value)) + " ", dbcs.con1);

            dbcs.dr = cmd.ExecuteReader();
            if (dbcs.dr.Read())
            {
                EditId = Convert.ToInt32(dbcs.dr["intId"].ToString());
                txtName.Text = (dbcs.dr["varName"].ToString());
                txtEmail.Text = dbcs.dr["varEmail"].ToString();
                txtMobile.Text = dbcs.dr["varMobile"].ToString();
                txtaddress.Text = dbcs.dr["varAddress"].ToString();
                txtlandline.Text = dbcs.dr["varLandline"].ToString();
               // txtPassword.Text = dbcs.dr["varPassword"].ToString();
                txtLandmark.Text = (dbcs.dr["varLandmark"].ToString());
              //  txtNeighbourhood.Text = (dbcs.dr["varNeighbourhood"].ToString());
                ImgProfilecust.ImageUrl = "~/Services/Customer/CustomerImages/" + dbcs.dr["imgImage"].ToString();

                ddlCountry.SelectedValue = dbcs.dr["varCountry"].ToString();
                ddlState.DataSource = dbc.GetstateMasterDataFromCountryId(Convert.ToInt32(dbcs.dr["varCountry"].ToString()));

                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "StateId"; ddlState.DataBind();
                ddlState.SelectedValue = dbcs.dr["varState"].ToString();
                ddlCity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(dbcs.dr["varState"].ToString()));

                ddlCity.DataTextField = "CityName";
                ddlCity.DataValueField = "CityId"; ddlCity.DataBind();

                ddlCity.SelectedValue = dbcs.dr["varCity"].ToString();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void btnupdate_Click(object sender, EventArgs e)
    {
        try
        {
            int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
            string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
            string fileName = rex.DecryptString(Request.Cookies["CookieCustomerID"].Value) + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;

            if (contentLength != 0)
            {
                string myStr = ImgProfilecust.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/Services/Customer/CustomerImages/") + fileName);
                dbcs.con.Close();
                dbcs.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblcustomer SET varName='"+txtName.Text+"',varMobile='"+txtMobile.Text+"',varAddress='"+txtaddress.Text+"',varLandline='"+txtlandline.Text+"',varLandmark='"+txtLandmark.Text+"',varCountry='"+ddlCountry.SelectedValue+"',varState='"+ddlState.SelectedValue+"',varCity='"+ddlCity.SelectedValue+"',imgImage='"+fileName+"' where intId = " + Convert.ToInt32(rex.DecryptString(Request.Cookies["CookieCustomerID"].Value)) + "", dbcs.con);
                int Update_ok = cmd1.ExecuteNonQuery();
                dbcs.con.Close();
                if (Update_ok == 1)
                {
                    MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                   // rex.DecryptString(Request.Cookies["CookieCustomerEmail"].Value) = txtEmail.Text;
                }
                else
                {
                    MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                }
            }
            else
            {
                string[] imgname = ImgProfilecust.ImageUrl.Split('/');
                dbcs.con.Close();
                dbcs.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblcustomer SET varName='" + txtName.Text.Replace("'", "\\'") +"',varMobile='" + txtMobile.Text.Replace("'", "\\'") +"',varAddress='" + txtaddress.Text.Replace("'", "\\'") +"',varLandline='" + txtlandline.Text.Replace("'", "\\'") +"',varLandmark='" + txtLandmark.Text.Replace("'", "\\'") +"',varCountry='" + ddlCountry.SelectedValue + "',varState='" + ddlState.SelectedValue + "',varCity='" + ddlCity.SelectedValue + "',imgImage='" + imgname[4] + "' where intId = " + Convert.ToInt32(rex.DecryptString(Request.Cookies["CookieCustomerID"].Value)) + "", dbcs.con);
                int Update_ok = cmd1.ExecuteNonQuery();
                dbcs.con.Close();
                if (Update_ok == 1)
                {
                    MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                   // rex.DecryptString(Request.Cookies["CookieCustomerEmail"].Value) = txtEmail.Text;
                }
                else
                {
                    MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                }
            }
            getCustomerData();

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }

    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
}