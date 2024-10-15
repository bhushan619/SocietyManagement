using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using System.IO;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;


public partial class SK_Society_AddSociety : Society
{
  
     DatabaseConnection dbc = new DatabaseConnection();
     DatabaseConnectionServices dbcs = new DatabaseConnectionServices();
    RegexUtilities rex = new RegexUtilities();  
     string  EmpId = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getCountryData();
            getSocietyListviewdata();
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
    public void clear()
    {
        chkIsActive.Checked = false;
        txtcpemail.Text = "";
        txtcpmobile.Text = "";
        txtcpname.Text = "";
        txtSAddress.Text = "";
        txtsemail.Text = "";
        txtsmobile.Text = "";
        txtSocietyName.Text = "";
        txtspassword.Text = "";
        txtsphone.Text = "";
        txtcpphone.Text = "";
        txtsRegistrationNo.Text = "";
        ddlCountry.SelectedIndex = 0;
        ddlState.SelectedIndex = 0;
        ddlCity.SelectedIndex = 0;
    }

    void MessageDisplay(string message, string cssClass)
    {
        try
        {
            lblMessage.Text = message;
            divMessage.Attributes.Add("class", cssClass);
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
            EmpId=AddSociety(txtsRegistrationNo.Text.Replace("'", "\\'"), txtSocietyName.Text.Replace("'", "\\'"), txtSAddress.Text.Replace("'", "\\'"), txtsphone.Text.Replace("'", "\\'"), txtsmobile.Text.Replace("'", "\\'"), txtsemail.Text.Replace("'", "\\'"), ddlCountry.SelectedValue, ddlState.SelectedValue, ddlCity.SelectedValue, txtcpname.Text.Replace("'", "\\'"), txtspassword.Text.Replace("'", "\\'"), txtcpname.Text.Replace("'", "\\'"), txtcpmobile.Text.Replace("'", "\\'"), txtcpphone.Text.Replace("'", "\\'"), txtcpemail.Text);
            if (EmpId != string.Empty)
            {
                sendmail(txtSocietyName.Text.Replace("'", "\\'"), txtspassword.Text.Replace("'", "\\'"), EmpId, txtsemail.Text);
                MessageDisplay(Resources.Messages.Added, "alert alert-success");

                insertCustomer();
                clear();
            }
            else
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            //Societyid = string.Concat("SKS", dbc.CreateRandomMemberId(7));
            //if (dbc.check_already_SocietyId(Societyid) == 1)
            //{
            //    Societyid = string.Concat("SKS", dbc.CreateRandomMemberId(7));
            //}
            //else
            //{
            //    int insert_ok = dbc.insert_tblsocietyinfo(Societyid,txtsRegistrationNo.Text ,txtSocietyName.Text.Replace("'", "\\'"), txtSAddress.Text.Replace("'", "\\'"),txtsphone.Text.Replace("'", "\\'"),txtsmobile.Text.Replace("'", "\\'"),txtsemail.Text.Replace("'", "\\'"),txtspassword.Text.Replace("'", "\\'"),Convert.ToInt32(ddlCountry.SelectedValue),Convert.ToInt32(ddlState.SelectedValue),Convert.ToInt32(ddlCity.SelectedValue),txtcpname.Text.Replace("'", "\\'"),txtcpmobile.Text.Replace("'", "\\'"),txtcpphone.Text.Replace("'", "\\'"), txtcpemail.Text.Replace("'", "\\'"),Convert.ToInt32(chkIsActive.Checked ? 1 : 0));

            //    if (insert_ok == 1)
            //    {

            //        MessageDisplay(Resources.Messages.Added, "alert alert-success");
            //     
            //        clear();

            //    }
            //    else
            //    {
            //        MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            //    }
            //  
            //}
            getSocietyListviewdata();
        }
        catch (Exception ex)
        {
            MessageDisplay(ex.Message, "alert alert-danger");
            
        }
    }
    public void insertCustomer()
    {
        if (dbcs.check_AlreadyCustomer(txtcpemail.Text))
        {

        }
        else
        {
            dbcs.con.Open();
            dbcs.cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblcustomer( varName, varMobile, varEmail, varEmailVerify ,varPassword, varStatus, imgImage ) VALUES ( '" + txtcpname.Text.Replace("'", "\\'") +"', '" + txtcpmobile.Text.Replace("'", "\\'") +"','" + txtcpemail.Text.Replace("'", "\\'") +"','true', '" + txtspassword.Text.Replace("'", "\\'") +"' , '1', 'Noprofile.png')", dbcs.con);
            dbcs.cmd.ExecuteNonQuery();
            dbcs.con.Close();
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getSocietyListviewdata();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getSocietyListviewdata()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,varName,varSAddress,varSEmail,varContactPerson,varContactMobile,varIsActive FROM tblsocietyinfo where 1", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstSocietyList.DataSource = dt;
            lstSocietyList.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    //call this send mail function on submit button click
    private string PopulateBody(string Name, string EmailId, string Societyid, string pass)
    {
        try
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/LoginDetails.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{Name}", Name);
            body = body.Replace("{EmailId}", EmailId);
            body = body.Replace("{id}", Societyid);
            body = body.Replace("{pass}", pass);
            return body;
        }
        catch (Exception ex)
        {            
            string exp = ex.Message;
            return "";
        }
    }
    protected void sendmail(string name, string pass, string Societyid, string email)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <support@societykatta.com>"), new MailAddress(email)))
            {
                mm.Subject = " Your SocietyKatta.com Login Details";

                mm.Body = PopulateBody(name, email, Societyid, pass);

                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                //for server

                smtp.Host = "relay-hosting.secureserver.net";
                smtp.EnableSsl = false;

                //for local 

                //smtp.Host = "smtp.rediffmailpro.com";
                //smtp.EnableSsl = true;

               
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
     
}