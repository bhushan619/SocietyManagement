using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_SVendorProfile : BaseClass
{

    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices(); 
    static string EditId = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getCountryData();
            getVendorData();
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
    public void getVendorData()
    {

        try
        {

            dbcs.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand(" SELECT tblvendor.intId as intId, tblvendor.intVendorCode as intVendorCode, tblvendor.varName, tblvendor.varContactPerson, tblvendor.varPhoneNo, tblvendor.varMobileNo, tblvendor.varEmailId,  tblvendor.varCountry, tblvendor.varState, tblvendor.varCity, tblvendor.varAddress, tblvendor.varNeighbourhood, tblvendor.varPincode, tblvendor.varUsername, tblvendor.varPassword, tblvendor.varCreatedDate, tblvendor.CreatedBy, tblvendor.varIsActive, tblvendorabout.varAbout, tblvendorabout.varImage,   tblvendordescription.varCharges, tblvendordescription.varDescription FROM            tblvendor INNER JOIN      tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN     tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId WHERE tblvendor.intId=" + Convert.ToInt32(Request.Cookies["CookieVendorID"].Value) + " ", dbcs.con1);

            dbcs.dr = cmd.ExecuteReader();
            if (dbcs.dr.Read())
            {
                EditId = (dbcs.dr["intVendorCode"].ToString());
                txtName.Text = (dbcs.dr["varName"].ToString());
                txtcPerson.Text = (dbcs.dr["varContactPerson"].ToString());

                txtEmail.Text = dbcs.dr["varEmailId"].ToString();
                txtMobile.Text = dbcs.dr["varMobileNo"].ToString();
                txtaddress.Text = dbcs.dr["varAddress"].ToString();
                txtlandline.Text = dbcs.dr["varPhoneNo"].ToString();
                txtpin.Text = dbcs.dr["varPincode"].ToString();
                
               // txtPassword.Text = dbcs.dr["varPassword"].ToString();
                txtusername.Text = (dbcs.dr["varUsername"].ToString());
                //  txtNeighbourhood.Text = (dbcs.dr["varNeighbourhood"].ToString());
                ImgProfilecust.ImageUrl = "~/Services/Vendor/VendorImages/" + dbcs.dr["varImage"].ToString();

                ddlCountry.SelectedValue = dbcs.dr["varCountry"].ToString();
                ddlState.DataSource = dbc.GetstateMasterDataFromCountryId(Convert.ToInt32(dbcs.dr["varCountry"].ToString()));

                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "StateId"; ddlState.DataBind();
                ddlState.SelectedValue = dbcs.dr["varState"].ToString();
                ddlCity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(dbcs.dr["varState"].ToString()));

                ddlCity.DataTextField = "CityName";
                ddlCity.DataValueField = "CityId"; ddlCity.DataBind();

                ddlCity.SelectedValue = dbcs.dr["varCity"].ToString();

                txtcharges.Text = dbcs.dr["varCharges"].ToString();
                txtabout.Text = dbcs.dr["varAbout"].ToString();
                txtdescription.Text = dbcs.dr["varDescription"].ToString();

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
            string fileName = Request.Cookies["CookieVendorID"].Value + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;

            dbcs.con.Close();
            dbcs.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblvendor SET varName='" + txtName.Text.Replace("'", "\\'") +"',varContactPerson='" + txtcPerson.Text.Replace("'", "\\'") +"',varPhoneNo='" + txtlandline.Text.Replace("'", "\\'") +"',varMobileNo='" + txtMobile.Text.Replace("'", "\\'") +"',varEmailId='" + txtEmail.Text.Replace("'", "\\'") +"',varCountry='" + ddlCountry.SelectedValue + "',varState='" + ddlState.SelectedValue + "',varCity='" + ddlCity.SelectedValue + "',varAddress='" + txtaddress.Text.Replace("'", "\\'") +"',varPincode='" + txtpin.Text.Replace("'", "\\'") +"'   where intId = " + Convert.ToInt32(Request.Cookies["CookieVendorID"].Value) + "", dbcs.con);
            cmd1.ExecuteNonQuery();
            dbcs.con.Close();

            dbcs.con.Close();
            dbcs.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdt = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblvendordescription SET varCharges='" + txtcharges.Text.Replace("'", "\\'") +"',varDescription='" + txtdescription.Text.Replace("'", "\\'") +"' where varVendorId = '" + EditId + "'", dbcs.con);
            cmdt.ExecuteNonQuery();
            dbcs.con.Close();

            if (contentLength != 0)
            {
                string myStr = ImgProfilecust.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/Services/Vendor/VendorImages/") + fileName);
            
                dbcs.con.Close();
                dbcs.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmdv = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblvendorabout SET varAbout='"+ txtabout.Text.Replace("'", "\\'") +"',varImage='"+fileName+"'  where varVendorId = '" + EditId + "'", dbcs.con);
                int Update_ok = cmdv.ExecuteNonQuery();
                dbcs.con.Close();

                if (Update_ok == 1)
                {
                    MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                   // Request.Cookies["CookieVendorEmail"].Value = txtEmail.Text;
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
                MySql.Data.MySqlClient.MySqlCommand cmdv = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblvendorabout SET varAbout='" + txtabout.Text.Replace("'", "\\'") +"',varImage='" + imgname[4] + "'  where varVendorId = '" + EditId + "'", dbcs.con);
                int Update_ok = cmdv.ExecuteNonQuery();
                dbcs.con.Close();
                if (Update_ok == 1)
                {
                    MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                   // Request.Cookies["CookieVendorEmail"].Value = txtEmail.Text;
                }
                else
                {
                    MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
                }
            }

            getVendorData();

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