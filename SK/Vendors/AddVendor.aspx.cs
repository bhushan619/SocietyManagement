using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyKatta.App_Code.BAL.Society.MasterData;
using SocietyKatta.App_Code.BAL.Users;
using SocietyKatta.App_Code.BAL;

public partial class SK_Vendors_AddVendor : ClsVendor
{
    DatabaseConnectionServices dbc = new DatabaseConnectionServices();
  
    static string EditVendorId = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getServiceData();
            getVendorGridData();
            getCountryData();
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
    public void getServiceData()
    {
        try
        {
            using (ClsVendorService ccs = new ClsVendorService())
            {
                ddlService.DataSource = ccs.FetchVendorService(1);//FetchCountryNameWithId by passing cultureid from cookie
                ddlService.DataTextField = "varName";
                ddlService.DataValueField = "intServiceCode";
                ddlService.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void clear()
    {
        chkIsActive.Checked = false;
        txtNeighbourhood.Text = "";

        txtAddress.Text = "";
        txtContactName.Text = "";
        txtEmail.Text = "";
     
        txtFirstName.Text = "";
     
        txtMobile.Text = "";
        txtPassword.Text = "";
        txtPhone.Text = "";
        txtPin.Text = "";
      
        txtUsername.Text = "";

        ddlCountry.SelectedIndex = 0;
        ddlState.SelectedIndex = 0;
        cmbcity.SelectedIndex = 0;

        txtDescription.Text = "";
        txtAbout.Text = "";
        txtVisitCharges.Text = "";
        ddlService.SelectedIndex = 0;
      
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
             int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
            string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
            string fileName = dbc.CreateRandomPassword(3) + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;

            if (contentLength != 0)
            {
                string myStr = ImgProfile.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/Services/Vendor/VendorImages/") + fileName);
            }
            else
            {
                fileName = "NoProfile.png";
            }

            if (AddVendorSDetails(txtFirstName.Text.Replace("'", "\\'"), txtContactName.Text.Replace("'", "\\'"), txtPhone.Text.Replace("'", "\\'"), txtMobile.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), ddlCountry.SelectedValue, ddlState.SelectedValue, cmbcity.SelectedValue, txtAddress.Text.Replace("'", "\\'"), txtNeighbourhood.Text.Replace("'", "\\'"), txtPin.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), txtPassword.Text.Replace("'", "\\'"), DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), "1", chkIsActive.Checked ? "1" : "0", txtAbout.Text.Replace("'", "\\'"), fileName, txtVisitCharges.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), ddlService.SelectedValue))
            {
                MessageDisplay(Resources.Messages.Added, "alert alert-success");
                clear();
                // getVendorGridData();

            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
            }
            getVendorGridData();
         
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

        this.getVendorGridData();
    }
    public void getVendorGridData()
    {
        try
        {
            lstVendors.DataSource = FetchVendor();
            lstVendors.DataBind();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
            string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
            string fileName = dbc.CreateRandomPassword(3) + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;

            if (contentLength != 0)
            {
                string myStr = ImgProfile.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/Services/Vendor/VendorImages/") + fileName);
            }
            else
            {
                fileName = "NoProfile.png";
            }

            if (UpdateVendorDataById(EditVendorId, txtFirstName.Text.Replace("'", "\\'"),txtContactName.Text.Replace("'", "\\'"), txtPhone.Text.Replace("'", "\\'"), txtMobile.Text.Replace("'", "\\'"), txtEmail.Text.Replace("'", "\\'"), ddlCountry.SelectedValue, ddlState.SelectedValue, cmbcity.SelectedValue, txtPin.Text.Replace("'", "\\'"),  txtAddress.Text.Replace("'", "\\'"), txtNeighbourhood.Text.Replace("'", "\\'"), txtUsername.Text.Replace("'", "\\'"), txtPassword.Text.Replace("'", "\\'"), chkIsActive.Checked ? 1 : 0, txtAbout.Text.Replace("'", "\\'"), fileName, txtVisitCharges.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), ddlService.SelectedValue))
            {
                MessageDisplay(Resources.Messages.Updated, "alert alert-success");

                getVendorGridData();
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }
            txtPassword.ReadOnly = false;
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
            EditVendorId = string.Empty;
            clear();

        }
        catch (Exception ex)
        {
            string exp = ex.Message;

        }
    }
    public void changecity(string state)
    {
        cmbcity.Items.Clear();
        cmbcity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(state));
        cmbcity.DataTextField = "CityName";
        cmbcity.DataValueField = "CityId";
        cmbcity.DataBind();
        cmbcity.Items.Insert(0, new ListItem(":: Select City ::", ""));
    }
    protected void state_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            cmbcity.Items.Clear();
            cmbcity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(ddlState.SelectedValue));
            cmbcity.DataTextField = "CityName";
            cmbcity.DataValueField = "CityId";
            cmbcity.DataBind();
            cmbcity.Items.Insert(0, new ListItem(":: Select City ::", ""));
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(
                   this,
                   this.GetType(),
                   "MessageBox",
                   "alert('" + ex.Message + "');", true);
        }
    }




    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlState.Items.Clear();
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
    protected void lstVendors_ItemCommand(object sender, ListViewCommandEventArgs e)
    {//string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
        //string id = commandArgs[0];
        //string stat = commandArgs[1];
        try
        {
            if (e.CommandName == "Edits")
            {
                EditVendorId = e.CommandArgument.ToString();
                btnUpdate.Visible = true;
                btnSubmit.Visible = false;

                GetVendorDataById(e.CommandArgument.ToString());

                txtAddress.Text = Address;
                txtContactName.Text = ContactPerson;
                txtEmail.Text = EmailId;

                txtFirstName.Text = FirstName;

                txtMobile.Text = MobileNo;
                txtPassword.Text = Password;
                txtPhone.Text = PhoneNo;
                txtPin.Text = Pincode;
                txtNeighbourhood.Text = varNeighbourhood;
                txtUsername.Text = Username;

                ddlCountry.SelectedIndex = Convert.ToInt32(Country);
                ddlState.DataSource = dbc.GetstateMasterDataFromCountryId(Convert.ToInt32(Country));

                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "StateId";
                ddlState.DataBind();

                cmbcity.DataSource = dbc.GetCityMasterDataFromStateId(Convert.ToInt32(State));

                cmbcity.DataTextField = "CityName";
                cmbcity.DataValueField = "CityId";
                cmbcity.DataBind();

                //ddlCountry.SelectedValue = Country;
                ddlState.SelectedValue = State;
                cmbcity.SelectedValue = City;

                chkIsActive.Checked = IsActive == "1" ? true : false;
                txtPassword.ReadOnly = true;
                ddlService.SelectedValue = SvarName;

                txtDescription.Text= varDescription ;
                txtAbout.Text = varAbout  ;
                txtVisitCharges.Text = varCharges;

                ImgProfile.ImageUrl = "~/Services/Vendor/VendorImages/" + varImage;
                //if (Convert.ToBoolean(IsActive)== true)
                //{
                //    chkIsActive.Checked = true;
                //}
                //else
                //{
                //    chkIsActive.Checked = false;
                //}
                // 
            }

            //else if (e.CommandName == "Delets")
            //{
            //    if (DeleteVendorServiceTypeDetails(Convert.ToInt32(e.CommandArgument.ToString())))
            //    {
            //        MessageDisplay(Resources.Messages.Deleted, "alert alert-success");

            //        getVendorGridData();
            //    }
            //    else
            //    {
            //        MessageDisplay(Resources.Messages.NotDeleted, "alert alert-danger");
            //    }
            //}
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }

    }
}