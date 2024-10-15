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

public partial class Society_Admin_Property_AssignParking : System.Web.UI.Page
{
    static string EditTypeId = string.Empty;
    static string Propertyid = string.Empty;
    string parkingslots = string.Empty;
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            // txtUsername.Text = Propertyid;
            getLoadData();
            getListViewMasterData();
        }
    }
    public void getLoadData()
    {
        try {
            ddlWing.DataSource = dbc.GetSocietyWingMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlWing.DataTextField = "varWingName";
            ddlWing.DataValueField = "intId";
            ddlWing.DataBind();
            ddlWing.Items.Insert(0, new ListItem(":: Select Wing ::", ""));


            dbc.con.Close();
            dbc.con.Open();
            MySqlCommand das = new MySqlCommand("SELECT intId, varSocietyId, varparkinglevel, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive  FROM tblmasterparkinglevel WHERE varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'", dbc.con);
            dbc.dr1 = das.ExecuteReader();
            while (dbc.dr1.Read())
            {
                ddlParkingLevel.Items.Add(new ListItem(dbc.dr1["varparkinglevel"].ToString(), dbc.dr1["intId"].ToString()));

            }
            ddlParkingLevel.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void ddlParkingLevel_SelectedIndexChanged(object sender, EventArgs e)
    {
        try {
            GetData(Convert.ToInt32(ddlParkingLevel.SelectedValue));
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    public void GetData(int ParkingLevel)
    {
        try {
            ddlParkingSlots.Items.Clear();
            dbc.con.Close();
            dbc.con.Open();
            MySqlCommand das = new MySqlCommand("SELECT intId, varSocietyId, intparkinglevelId, varparkinglevelSlot, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive FROM tblmasterparkinglevelslot WHERE intparkinglevelId=" + ParkingLevel + " and intIsAssigned=0", dbc.con);
            dbc.dr1 = das.ExecuteReader();
            while (dbc.dr1.Read())
            {
                ddlParkingSlots.Items.Add(new ListItem(dbc.dr1["varparkinglevelSlot"].ToString(), dbc.dr1["intId"].ToString()));

            }
            ddlParkingSlots.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }

    protected void ddlWing_SelectedIndexChanged(object sender, EventArgs e)
    {
        try {
            ddlPropertyCode.Items.Clear();
            ddlPropertyCode.Items.Insert(0, ":: Select Property ::");
            dbc.con.Close();
            dbc.con.Open();
            MySqlCommand das = new MySqlCommand("SELECT intId, varPropertyId, varSocietyId, intRoleId, intWingId, intPremisesUnitId, intPremisesTypeId, varPropertyCode, varName, varAlternateAddress, varPhoneNo, varMobile, varAlternateMobile, varEmail, varAlternateEmail, varUsername, varPassword, varCreatedDate, varCreatedBy, intIsActive  FROM tblproperty WHERE intWingId=" + Convert.ToInt32(ddlWing.SelectedValue) + "", dbc.con);
            dbc.dr1 = das.ExecuteReader();
            while (dbc.dr1.Read())
            {
                ddlPropertyCode.Items.Add(new ListItem(dbc.dr1["varPropertyCode"].ToString() + "-" + dbc.dr1["varName"].ToString(), dbc.dr1["varPropertyId"].ToString()));

            }
            ddlPropertyCode.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
        }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int insert_ok = 0;
        try
        {
            for (int i = 0; i <= ddlParkingSlots.Items.Count - 1; i++)
            {
                if (ddlParkingSlots.Items[i].Selected)
                {

                    insert_ok = dbc.insert_tblpropertyvehical(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), ddlPropertyCode.SelectedValue, ddlParkingSlots.Items[i].Value.ToString(), "", "", "", "", rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), Convert.ToInt32(chkIsActive.Checked ? 1 : 0), DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"));
                    insert_ok = dbc.update_tblmasterparkinglevelslot(1, Convert.ToInt32(ddlParkingSlots.Items[i].Value.ToString()));

                    dbc.con.Close();
                    dbc.con.Open();
                    MySqlCommand das = new MySqlCommand("SELECT tblproperty.intId, tblproperty.varPropertyId, tblproperty.intRoleId, CONCAT(tblproperty.varName,' ( ', tblmastersocietywing.varWingName,' - ', tblproperty.varPropertyCode,' )')   AS Name, tblproperty.varMobile, tblproperty.varEmail, tblproperty.intIsActive, tblproperty.varSocietyId FROM      tblproperty INNER JOIN         tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE        (tblproperty.intIsActive = 1) AND tblproperty.varPropertyId  = '" + ddlPropertyCode.SelectedValue + "'", dbc.con);
                    dbc.dr1 = das.ExecuteReader();
                    if (dbc.dr1.Read())
                        sendmail(dbc.dr1["Name"].ToString(), ddlPropertyCode.SelectedValue, ddlParkingSlots.Items[i].Text.ToString(), dbc.dr1["varEmail"].ToString());
                    dbc.con.Close();

                }
            }
            if (insert_ok == 1)
            {

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
    public void clear()
    {
        chkIsActive.Checked = false;
        ddlWing.SelectedIndex = 0;
        ddlParkingLevel.SelectedIndex = 0;
        ddlParkingSlots.SelectedIndex = 0;
        ddlPropertyCode.SelectedIndex = 0;
        ddlParkingSlots.Items.Clear();
        ddlPropertyCode.Items.Clear();
        ddlPropertyCode.Items.Insert(0,":: Select Property ::");
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
            if (e.CommandName == "Deletes")
            { 
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("delete from tblpropertyvehical where varParkingSlot='" + e.CommandArgument + "'", dbc.con);
                cmd.ExecuteNonQuery();
                dbc.con.Close();

                int insert_ok = dbc.update_tblmasterparkinglevelslot(0, Convert.ToInt32(e.CommandArgument));
                if (insert_ok == 1)
                {

                    MessageDisplay(Resources.Messages.Deleted, "alert alert-success");
                    clear();

                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
                }
                getListViewMasterData();
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
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblproperty.varName AS Owner, tblmasterparkinglevelslot.varparkinglevelSlot AS Slot, tblmasterparkinglevelslot.intId AS 'SlotId', tblpropertyvehical.varVehicalName AS 'VehName', tblpropertyvehical.varVehicalNumber AS 'VehNum' FROM tblmasterparkinglevelslot INNER JOIN tblpropertyvehical ON tblmasterparkinglevelslot.intId = tblpropertyvehical.varParkingSlot INNER JOIN tblproperty ON tblpropertyvehical.varPropertyId = tblproperty.varPropertyId WHERE tblproperty.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'", dbc.con);
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

            //int Update_ok = dbc.update_tblproperty(EditTypeId, txtowner.Text.Replace("'", "\\'"), txtPropertyExtensionNumber.Text.Replace("'", "\\'"), txtphone.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), txtAltMobileNos.Text.Replace("'", "\\'"), txtAltEmailIds.Text.Replace("'", "\\'"), chkIsActive.Checked ? 1 : 0);

            //if (Update_ok == 1)
            //{
            //    MessageDisplay(Resources.Messages.Updated, "alert alert-success");
            //    clear();
            //}
            //else
            //{
            //    MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            //}
            //btnSubmit.Visible = true;
            //btnUpdate.Visible = false;
            //myproerty.Visible = true;
            //txtPassword.Enabled = true;
            //EditTypeId = string.Empty;
            //getListViewMasterData();
        }
        catch (Exception ex)
        {
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }

    private string PopulateBody(string Name, string id, string slot, string email)
    {
        try {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/SK/EmailTemplate/Parking.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{Name}", Name);
            body = body.Replace("{id}", id);
            body = body.Replace("{slot}", slot);
            body = body.Replace("{email}", email);
            return body;
        }
        catch (Exception ex)
        {
            return "";
            string exp = ex.Message;
        }
    }
    protected void sendmail(string name, string id, string slot, string email)
    {
        try
        {

            using (MailMessage mm = new MailMessage(new MailAddress("SocietyKatta <support@societykatta.com>"), new MailAddress(email)))
            {
                mm.Subject = " Your Assign Parking Details";

                mm.Body = PopulateBody(name, id, slot, email);

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