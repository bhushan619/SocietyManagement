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
using System.Net.Mail;
using System.Net; 
using System.Globalization;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;

public partial class Society_Admin_Property_AddProperty : System.Web.UI.Page
{
    static string EditTypeId = string.Empty;
    static string Propertyid = string.Empty;
    
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    DatabaseConnectionServices dbcs = new DatabaseConnectionServices();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
           // txtUsername.Text = Propertyid;
            getPremisesData();
            getListViewMasterData();
        }

    }
    public void getPremisesData()
    {
        try {
            ddlWing.DataSource = dbc.GetSocietyWingMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlWing.DataTextField = "varWingName";
            ddlWing.DataValueField = "intId";
            ddlWing.DataBind();
            ddlWing.Items.Insert(0, new ListItem(":: Select Wing ::", ""));

            ddlPremises.DataSource = dbc.GetUnitTypeMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlPremises.DataTextField = "varUnitTypeName";
            ddlPremises.DataValueField = "intId";
            ddlPremises.DataBind();
            ddlPremises.Items.Insert(0, new ListItem(":: Select Premises ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }


    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            Propertyid = string.Concat("SKSP", dbc.CreateRandomMemberId(7));

            if (dbc.check_already_SocietyPropertyId(Propertyid) == 1)
            {
                Propertyid = string.Concat("SKSP", dbc.CreateRandomMemberId(7));
            }

            int insert_ok = dbc.insert_tblproperty(Propertyid, rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), Convert.ToInt32(dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Property Owner")), Convert.ToInt32(ddlWing.SelectedValue), Convert.ToInt32(ddlPremises.SelectedValue), Convert.ToInt32(ddlPremisesType.SelectedValue), txtflatno.Text.Replace("'", "\\'"), txtowner.Text.Replace("'", "\\'"), rgbMale.Checked ? "Male" : "Female", txtPropertyExtensionNumber.Text.Replace("'", "\\'"), "", txtphone.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtAltMobileNos.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), txtAltEmailIds.Text.Replace("'", "\\'"), Propertyid, txtPassword.Text.Replace("'", "\\'"), DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), Convert.ToInt32(chkIsActive.Checked ? 1 : 0));

            if (insert_ok == 1)
            {
                insertCustomer();
                sendmail(txtowner.Text.Replace("'", "\\'"), txtPassword.Text.Replace("'", "\\'"), Propertyid, txtEmail.Text);
                MessageDisplay(Resources.Messages.Added, "alert alert-success");
                clear();

            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            }

            getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            // MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }

    }
    public void insertCustomer()
    {
        if (dbcs.check_AlreadyCustomer(txtEmail.Text))
        {

        }
        else
        {
            dbcs.con.Open();
            dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblcustomer( varName, varMobile, varEmail, varEmailVerify ,varPassword, varStatus, imgImage ) VALUES ( '" + txtowner.Text.Replace("'", "\\'") +"', '" + txtmobile.Text.Replace("'", "\\'") +"','" + txtEmail.Text.Replace("'", "\\'") +"','true', '" + txtPassword.Text.Replace("'", "\\'") +"' , '1', 'Noprofile.png')", dbcs.con);
            dbcs.cmd.ExecuteNonQuery();
            dbcs.con.Close();
        }
    }

    public void clear()
    {
       
        txtPassword.Text = "";
        txtEmail.Text = "";
        txtflatno.Text = "";
        txtmobile.Text = "";
        txtowner.Text = "";
        txtphone.Text = "";
       // txtUsername.Text = "";
        txtAltEmailIds.Text = "";
        txtAltMobileNos.Text = "";
        txtPropertyExtensionNumber.Text = "";
        ddlPremises.SelectedIndex = 0;
        ddlPremisesType.SelectedIndex = 0;
        ddlWing.SelectedIndex = 0;

        chkIsActive.Checked = false;
        
        rgbMale.Checked = false;
        rgbFemale.Checked = false;
    }
   
    protected void ddlPremises_SelectedIndexChanged(object sender, EventArgs e)
    {
        try {
            ddlPremisesType.DataSource = dbc.GetFlatPremisesTypeMasterDataDropdown(Convert.ToInt32(ddlPremises.SelectedValue), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlPremisesType.DataTextField = "varFlatPremisesName";
            ddlPremisesType.DataValueField = "intId";
            ddlPremisesType.DataBind();
            ddlPremisesType.Items.Insert(0, new ListItem(":: Select Premises Type ::", ""));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getListViewMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edits")
            {

                btnUpdate.Visible = true;
                btnSubmit.Visible = false;
                myproerty.Visible = false;
                txtPassword.Enabled = false;
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varUsername,varPropertyId, varSocietyId, intRoleId, intWingId, intPremisesUnitId, intPremisesTypeId, varName,varGender,  varPhoneNo, varMobile, varEmail,varAlternateEmail,varAlternateMobile,varExtensionNo,  intIsActive FROM tblproperty WHERE intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditTypeId =  dbc.dr["varUsername"].ToString();
                    txtowner.Text = dbc.dr["varName"].ToString();
                    txtphone.Text = dbc.dr["varPhoneNo"].ToString();
                    txtmobile.Text = dbc.dr["varMobile"].ToString();
                    txtEmail.Text = dbc.dr["varEmail"].ToString();
                    txtAltMobileNos.Text = dbc.dr["varAlternateMobile"].ToString();
                    txtAltEmailIds.Text = dbc.dr["varAlternateEmail"].ToString();
                    txtPropertyExtensionNumber.Text = dbc.dr["varExtensionNo"].ToString();
                    if (dbc.dr["varGender"].ToString() == "Male")
                    {
                        rgbMale.Checked = true;
                    }
                    else if (dbc.dr["varGender"].ToString() == "Female")
                    {
                        rgbFemale.Checked = true;
                    }

                    if (Convert.ToInt32(dbc.dr["intIsActive"].ToString()) == 1)
                    {
                        chkIsActive.Checked = true;
                    }
                    else
                    {
                        chkIsActive.Checked = false;
                    }
                }
                dbc.con.Close();
            }
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId ,varPropertyCode,varName, varMobile ,	intIsActive FROM tblproperty WHERE varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  order by intId desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            int Update_ok = dbc.update_tblproperty(EditTypeId, txtowner.Text.Replace("'", "\\'"), rgbMale.Checked ? "Male" : "Female", txtPropertyExtensionNumber.Text.Replace("'", "\\'"), txtphone.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), txtAltMobileNos.Text.Replace("'", "\\'"), txtAltEmailIds.Text.Replace("'", "\\'"), chkIsActive.Checked ? 1 : 0);

            if (Update_ok == 1)
            {
                MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                clear();
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
            myproerty.Visible = true;
            txtPassword.Enabled = true;
            EditTypeId = string.Empty;
            getListViewMasterData();
        }
        catch (Exception ex)
        {
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }

    private string PopulateBody(string Name, string EmailId, string Propertyid, string pass)
    {
        try {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/LoginDetails.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{Name}", Name);
            body = body.Replace("{EmailId}", EmailId);
            body = body.Replace("{id}", Propertyid);
            body = body.Replace("{pass}", pass);
            return body;
        }
        catch (Exception ex)
        {
            return "1";
            string exp = ex.Message;
        }
    }
    protected void sendmail(string name, string pass, string Propertyid, string email)
    {
        try
        {
            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <support@societykatta.com>"), new MailAddress(email)))
            {
                mm.Subject = " Your SocietyKatta Login Details";

                mm.Body = PopulateBody(name, email, Propertyid, pass);

                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                //for server

                smtp.Host = "relay-hosting.secureserver.net";
                smtp.EnableSsl = false;

                //for local 

                //smtp.Host = "smtp.rediffmailpro.com";
               // smtp.EnableSsl = true;


                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                NetworkCredential NetworkCred = new NetworkCredential("support@societykatta.com", "support@2016");
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = NetworkCred;
                //for server
               smtp.Port = 25;
                //for local
                //smtp.Port = 587;
                smtp.Send(mm);

            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //ScriptManager.RegisterStartupScript(
            //             this,
            //             this.GetType(),
            //             "MessageBox",
            //              "alert('Email Not Sent....');", true);

        }
    }



    protected void txtflatno_TextChanged(object sender, EventArgs e)
    {
        try {
            if (dbc.check_already_PropertyFlatNoId(txtflatno.Text.Replace("'", "\\'"), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)) == 1)
            {
                ScriptManager.RegisterStartupScript(
                             this,
                             this.GetType(),
                             "MessageBox",
                              "alert('Property / Flat Number Already Exist....');", true);
                txtflatno.Text = "";
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }

    }
    protected void txtPropertyExtensionNumber_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (dbc.check_already_PropertyExtensionNoId(txtPropertyExtensionNumber.Text.Replace("'", "\\'"), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value)) == 1)
            {
                ScriptManager.RegisterStartupScript(
                             this,
                             this.GetType(),
                             "MessageBox",
                              "alert('Property Extension Number Already Exist....');", true);
                txtPropertyExtensionNumber.Text = "";
            }
        }

        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}