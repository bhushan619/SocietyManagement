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
using System.IO;
using System.Globalization;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;



public partial class Society_Property_MyProperty : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static int EditfamilyintId = 0;
    static string EditTypeId = string.Empty;
    static string EditPropertyFlatintId = string.Empty;
        static string EditVehicalTypeId = string.Empty;
    static string Propertyid = string.Empty;
    string gen = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            getPremisesData();
            getPropertyData();
            getListViewMasterData();
            getFlatData();
            getListViewVehicalMasterData();
            
        }
        if (this.IsPostBack)
        {
            TabName.Value = Request.Form[TabName.UniqueID];
        }
    }
    public void getPropertyData()
    {
        try
        {
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varPropertyId, varSocietyId, intRoleId, intWingId, intPremisesUnitId, intPremisesTypeId, varPropertyCode, varName,varExtensionNo, varAlternateAddress, varPhoneNo, varMobile, varEmail, varUsername, varPassword, varCreatedDate, varCreatedBy,varAlternateMobile,varAlternateEmail, intIsActive FROM tblproperty WHERE varPropertyId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "'", dbc.con1);

            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                ddlWing.SelectedValue = dbc.dr["intWingId"].ToString();
                getPrimisesUnit(dbc.dr["intPremisesUnitId"].ToString());

                ddlPremisesType.SelectedValue = dbc.dr["intPremisesTypeId"].ToString();


                ddlPremises.SelectedValue = dbc.dr["intPremisesUnitId"].ToString();
                txtflatno.Text = dbc.dr["varPropertyCode"].ToString();
                txtPropertyExtensionNumber.Text = dbc.dr["varExtensionNo"].ToString();

                EditTypeId = dbc.dr["varUsername"].ToString();
                txtowner.Text = dbc.dr["varName"].ToString();
                txtphone.Text = dbc.dr["varPhoneNo"].ToString();
                txtmobile.Text = dbc.dr["varMobile"].ToString();
                txtEmail.Text = dbc.dr["varEmail"].ToString();
                txtAltMobileNos.Text = dbc.dr["varAlternateMobile"].ToString();
                txtAltEmailIds.Text = dbc.dr["varAlternateEmail"].ToString();

                if (Convert.ToInt32(dbc.dr["intIsActive"].ToString()) == 1)
                {
                    chkIsActive.Checked = true;
                }
                else
                {
                    chkIsActive.Checked = false;
                }

                ddlWing.Enabled = false;
                ddlPremises.Enabled = false;
                ddlPremisesType.Enabled = false;
                txtflatno.Enabled = false;
                txtPropertyExtensionNumber.Enabled = false;
                chkIsActive.Enabled = false;
            }
            dbc.con1.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con1.Close();
        }
    }
   
    public void getPremisesData()
    {
        try
        {
            ddlWing.DataSource = dbc.GetSocietyWingMasterDataDropdown(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
            ddlWing.DataTextField = "varWingName";
            ddlWing.DataValueField = "intId";
            ddlWing.DataBind();
            ddlWing.Items.Insert(0, new ListItem(":: Select Premises ::", ""));

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
    protected void ddlPremises_SelectedIndexChanged(object sender, EventArgs e)
    {
        getPrimisesUnit(ddlPremises.SelectedValue);
    }
    public void getPrimisesUnit(string premises)
    {
        try
        {
            ddlPremisesType.DataSource = dbc.GetFlatPremisesTypeMasterDataDropdown(Convert.ToInt32(premises), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value));
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

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            int Update_ok = dbc.update_tblproperty(rex.DecryptString(Request.Cookies["CookiePropertyId"].Value), txtowner.Text.Replace("'", "\\'"), rgbMale.Checked ? "Male" : "Female", txtPropertyExtensionNumber.Text.Replace("'", "\\'"), txtphone.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), txtAltMobileNos.Text.Replace("'", "\\'"), txtAltEmailIds.Text.Replace("'", "\\'"), chkIsActive.Checked ? 1 : 0);

            if (Update_ok == 1)
            {
                MessageDisplay(Resources.Messages.Updated, "alert alert-success"); 
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }
            
            btnUpdate.Visible = false;
            myproerty.Visible = true; 
           
        }
        catch (Exception ex)
        {
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }
    //family start
    protected void btnSubmitFamily_Click(object sender, EventArgs e)
    {
        try
        {
            int insert_ok = dbc.insert_tblpropertyfamily(rex.DecryptString(Request.Cookies["CookiePropertyId"].Value), txtFamilyName.Text.Replace("'", "\\'"), rgbMale.Checked ? "Male" : "Female", txtfamilyage.Text.Replace("'", "\\'"), txtOccupation.Text.Replace("'", "\\'"), txtAlternateAddress.Text.Replace("'", "\\'"), txtFamilyMobile.Text.Replace("'", "\\'"), txtFamilyAlternateMobile.Text.Replace("'", "\\'"), txtFamilyEmail.Text.Replace("'", "\\'"), txtFamilyAlternateEmail.Text.Replace("'", "\\'"), Convert.ToInt32(chkIsActive.Checked ? 1 : 0), DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"));

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
        }

    }
    public void getListViewMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intPropertyId, varName, varGender, varAge, varOccupation, varAlternateAddress, varMobileNo, varAlternateMobile, varEmail, varAlternateEmail, intIsActive, varCreatedDate FROM tblpropertyfamily WHERE intPropertyId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "'", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstType.DataSource = dt;
            lstType.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
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

                btnUpdateFamily.Visible = true;
                btnSubmitFamily.Visible = false;

                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intPropertyId, varName, varGender, varAge,       varOccupation, varAlternateAddress, varMobileNo, varAlternateMobile, varEmail, varAlternateEmail, intIsActive, varCreatedDate FROM tblpropertyfamily WHERE intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditfamilyintId = Convert.ToInt32(dbc.dr["intId"].ToString());
                    txtFamilyName.Text = dbc.dr["varName"].ToString();

                    if (dbc.dr["varGender"].ToString() == "Male")
                    {
                        rgbMale.Checked = true;
                    }
                    else if (dbc.dr["varGender"].ToString() == "Female")
                    {
                        rgbFemale.Checked = true;
                    }
                    txtfamilyage.Text = dbc.dr["varAge"].ToString();
                    txtOccupation.Text = dbc.dr["varOccupation"].ToString();
                    txtAlternateAddress.Text = dbc.dr["varAlternateAddress"].ToString();
                    txtFamilyMobile.Text = dbc.dr["varMobileNo"].ToString();
                    txtFamilyAlternateMobile.Text = dbc.dr["varAlternateMobile"].ToString();
                    txtFamilyEmail.Text = dbc.dr["varEmail"].ToString();
                    txtFamilyAlternateEmail.Text = dbc.dr["varAlternateEmail"].ToString();

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
            else if (e.CommandName == "Delets")
            {
                dbc.con.Close();
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("DELETE FROM tblpropertyfamily WHERE intId = " + Convert.ToInt32(e.CommandArgument.ToString()) + "", dbc.con);
                int i = cmd1.ExecuteNonQuery();
                dbc.con.Close();

                if (i == 1)
                {
                    MessageDisplay(Resources.Messages.Deleted, "alert alert-success");

                }
                else
                {
                    MessageDisplay(Resources.Messages.NotDeleted, "alert alert-danger");
                }
                getListViewMasterData();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
        }
    }
    protected void btnUpdateFamily_Click(object sender, EventArgs e)
    {
        try
        {
            int Update_ok = dbc.update_tblpropertyfamily(EditfamilyintId, txtFamilyName.Text.Replace("'", "\\'"), rgbMale.Checked ? "Male" : "Female", txtfamilyage.Text.Replace("'", "\\'"), txtOccupation.Text.Replace("'", "\\'"), txtAlternateAddress.Text.Replace("'", "\\'"), txtFamilyMobile.Text.Replace("'", "\\'"), txtFamilyAlternateMobile.Text.Replace("'", "\\'"), txtFamilyEmail.Text.Replace("'", "\\'"), txtFamilyAlternateEmail.Text.Replace("'", "\\'"), chkIsActive.Checked ? 1 : 0);

            if (Update_ok == 1)
            {
                MessageDisplay(Resources.Messages.Updated, "alert alert-success");
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }
            btnUpdateFamily.Visible = false;
            btnSubmitFamily.Visible = true;
           getListViewMasterData(); 
        }
        catch (Exception ex)
        {
            MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
        }
    }
    public void clear()
    {
        chkIsActive.Checked = false;
        txtfamilyage.Text = "";
        txtFamilyAlternateEmail.Text = "";
        txtFamilyAlternateMobile.Text = "";
        txtFamilyEmail.Text = "";
        txtFamilyMobile.Text = "";
        txtFamilyName.Text = "";
        txtOccupation.Text = "";
        txtAlternateAddress.Text = "";
    }
    //vehical start
    public void clearvehical()
    {
        chkVehicalActive.Checked = false;
        txtVehicalColour.Text = "";
        txtVehicalNAme.Text = "";
        txtVehicalNumber.Text = "";
        txtVehicalType.Text = "";
      
    }
    protected void btnUpdateVehical_Click(object sender, EventArgs e)
    {
        try
        {

            int Update_ok = dbc.update_tblpropertyvehical(EditVehicalTypeId, txtVehicalType.Text.Replace("'", "\\'"), txtVehicalNAme.Text.Replace("'", "\\'"), txtVehicalNumber.Text.Replace("'", "\\'"), txtVehicalColour.Text.Replace("'", "\\'"), chkVehicalActive.Checked ? 1 : 0);

            if (Update_ok == 1)
            {
                MessageDisplay(Resources.Messages.Updated, "alert alert-success");
                clearvehical();
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }
            getListViewVehicalMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
        }
    }
    protected void lstVehicalType_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            this.DataPagerVehical.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getListViewVehicalMasterData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void lstVehicalType_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edits")
            {
                dbc.con.Close();
                dbc.con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblpropertyvehical.intId, tblpropertyvehical.varSocietyId, tblpropertyvehical.varPropertyId, tblpropertyvehical.varParkingSlot, tblpropertyvehical.varVehicalType, tblpropertyvehical.varVehicalName, tblpropertyvehical.varVehicalNumber, tblpropertyvehical.varVehicalColor, tblmasterparkinglevelslot.varparkinglevelSlot, tblpropertyvehical.intIsActive FROM tblpropertyvehical INNER JOIN tblmasterparkinglevelslot ON tblpropertyvehical.varParkingSlot = tblmasterparkinglevelslot.intId where tblpropertyvehical.intId=" + Convert.ToInt32(e.CommandArgument.ToString()) + " ", dbc.con);

                dbc.dr = cmd.ExecuteReader();
                if (dbc.dr.Read())
                {
                    EditVehicalTypeId = dbc.dr["intId"].ToString();
                    txtVehicalParkingNumber.Text = dbc.dr["varparkinglevelSlot"].ToString();
                    txtVehicalType.Text = dbc.dr["varVehicalType"].ToString();
                    txtVehicalNAme.Text = dbc.dr["varVehicalName"].ToString();
                    txtVehicalNumber.Text = dbc.dr["varVehicalNumber"].ToString();
                    txtVehicalColour.Text = dbc.dr["varVehicalColor"].ToString();
                  
                    if (Convert.ToInt32(dbc.dr["intIsActive"].ToString()) == 1)
                    {
                        chkVehicalActive.Checked = true;
                    }
                    else
                    {
                        chkVehicalActive.Checked = false;
                    }
                }
                dbc.con.Close();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
        }
    }
    public void getListViewVehicalMasterData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblproperty.varName AS Owner, tblmasterparkinglevelslot.varparkinglevelSlot AS Slot, tblmasterparkinglevelslot.intId AS 'SlotId', tblpropertyvehical.varVehicalName AS 'VehName', tblpropertyvehical.varVehicalNumber AS 'VehNum',tblpropertyvehical.intId FROM tblmasterparkinglevelslot INNER JOIN tblpropertyvehical ON tblmasterparkinglevelslot.intId = tblpropertyvehical.varParkingSlot INNER JOIN tblproperty ON tblpropertyvehical.varPropertyId = tblproperty.varPropertyId WHERE tblproperty.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblpropertyvehical.varPropertyId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "'", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstVehicalType.DataSource = dt;
            lstVehicalType.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    //vehical end
    public void getFlatData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varPropertyId, date_format(varDateofPurchase,'%d-%m-%Y') as varDateofPurchase , varArea, varIsRenovated, varCosting, varCurrency FROM tblpropertydetails WHERE varPropertyId='" + rex.DecryptString(Request.Cookies["CookiePropertyId"].Value) + "'", dbc.con);
            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                EditPropertyFlatintId = (dbc.dr["intId"].ToString());
                txtDOB.Text = dbc.dr["varDateofPurchase"].ToString();
                txtFlatArea.Text = dbc.dr["varArea"].ToString();
                txtfrenovated.Text = dbc.dr["varIsRenovated"].ToString();
                txtfcost.Text = dbc.dr["varCosting"].ToString();
                txtfcurrency.Text = dbc.dr["varCurrency"].ToString();
            }
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }

    protected void btnsubmitFlat_Click(object sender, EventArgs e)
    {
        try
        {

            int Update_ok = dbc.update_tblpropertydetails(rex.DecryptString(Request.Cookies["CookiePropertyId"].Value),  Convert.ToDateTime(txtDOB.Text).ToString("yyyy-MM-dd"), txtFlatArea.Text.Replace("'", "\\'"), txtfrenovated.Text.Replace("'", "\\'"), txtfcost.Text.Replace("'", "\\'"), txtfcurrency.Text);

            if (Update_ok == 1)
            {
                MessageDisplay(Resources.Messages.Updated, "alert alert-success");
              //  clearvehical();
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }
            getFlatData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
        }
    }
}