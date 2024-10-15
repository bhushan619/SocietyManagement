using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyKatta.App_Code.BAL;
using SocietyKatta.App_Code.BAL.Society.MasterData;

public partial class SK_MasterData_VendorServiceSubTypes : ClsVendorServiceSubType
{


    static int EditServiceTypeId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            using (ClsCommanData cjc = new ClsCommanData())
            {
                txtMainCode.Text = cjc.CreateRandomId(5);
            }
            getServiceData();
            getServiceGridData();

        }
    }
    public void getServiceData()
    {
        try
        {
            using (ClsVendorService ccs = new ClsVendorService())
            {
                ddlServiceType.DataSource = ccs.FetchVendorService(1);//FetchCountryNameWithId by passing cultureid from cookie
                ddlServiceType.DataTextField = "varName";
                ddlServiceType.DataValueField = "intServiceCode";
                ddlServiceType.DataBind();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getServiceTypeData(Int64 service)
    {
        try
        {
            using (ClsVendorServiceType ccs = new ClsVendorServiceType())
            {
                ddlServiceMyType.DataSource = ccs.FetchVendorServiceTypeByService(service);//FetchCountryNameWithId by passing cultureid from cookie
                ddlServiceMyType.DataTextField = "Type";
                ddlServiceMyType.DataValueField = "intServicetypeCode";
                ddlServiceMyType.DataBind();
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    /// <summary>
    /// get Timezone Data
    /// </summary>



    /// <summary>
    /// clear text feild
    /// </summary>

    public void clear()
    {
        chkIsActive.Checked = false;
        txtDescription.Text = "";
        txtPrice.Text = "";
        ddlServiceMyType.SelectedIndex = 0;
        txtName.Text = "";
        txtRemark.Text = "";
        ddlServiceType.SelectedIndex = 0;
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


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtName.Text == "")
            {
                MessageDisplay(Resources.Messages.Empty, "alert alert-success");
            }
            else
            {
                if (AddVendorServiceSubTypeDetails(Convert.ToInt32(txtMainCode.Text), Convert.ToInt32(ddlServiceMyType.SelectedValue), Convert.ToInt32(ddlServiceType.SelectedValue), txtName.Text.Replace("'", "\\'"), txtPrice.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), txtRemark.Text.Replace("'", "\\'"), 1, chkIsActive.Checked ? 1 : 0))
                {
                    MessageDisplay(Resources.Messages.Added, "alert alert-success");
                   
                    //getServiceTypeData();

                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
                }

            } clear();
            getServiceGridData();
            using (ClsCommanData cjx = new ClsCommanData())
            {
                txtMainCode.Text = "";
                txtMainCode.Text = cjx.CreateRandomId(5);
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        try
        {
            this.DataPager1.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            this.getServiceGridData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    public void getServiceGridData()
    {
        try
        {
            ListView1.DataSource = FetchVendorServiceSubType();
            ListView1.DataBind();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        //string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
        //string id = commandArgs[0];
        //string stat = commandArgs[1];
        try
        {
            if (e.CommandName == "Edits")
            {
                EditServiceTypeId = Convert.ToInt32(e.CommandArgument.ToString());
                btnUpdate.Visible = true;
                btnSubmit.Visible = false;
                GetVendorServiceTypeById(Convert.ToInt32(e.CommandArgument.ToString()));
                txtDescription.Text = Description;
                txtMainCode.Text = Convert.ToString(ServicetypeCode);
                txtName.Text = Name;
                txtRemark.Text = Remark;
                txtPrice.Text = varPrice;
                chkIsActive.Checked = Convert.ToBoolean(IsActive);
                ddlServiceType.SelectedValue = Convert.ToString(ServiceCode);
                getServiceTypeData(ServiceCode);
                ddlServiceMyType.SelectedValue = Convert.ToString(ServicetypeCode);
            }

            else if (e.CommandName == "Delets")
            {
                if (DeleteVendorServiceTypeDetails(Convert.ToInt32(e.CommandArgument.ToString())))
                {
                    MessageDisplay(Resources.Messages.Deleted, "alert alert-success");

                    getServiceGridData();
                }
                else
                {
                    MessageDisplay(Resources.Messages.NotDeleted, "alert alert-danger");
                }
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (UpdateVendorServiceSubTypeById(EditServiceTypeId, Convert.ToInt32(ddlServiceType.SelectedValue), Convert.ToInt32(ddlServiceMyType.SelectedValue), txtName.Text.Replace("'", "\\'"), txtPrice.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), txtRemark.Text.Replace("'", "\\'"), chkIsActive.Checked ? 1 : 0))
            {
                MessageDisplay(Resources.Messages.Updated, "alert alert-success");

                getServiceGridData();
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
            EditServiceTypeId = 0;
            clear();

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }

    protected void ddlServiceType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlServiceMyType.Items.Clear();
            ddlServiceMyType.Items.Add(":: Select Type ::");
            ddlServiceMyType.Items[0].Value = "";
            getServiceTypeData(Convert.ToInt64(ddlServiceType.SelectedValue));
        }

        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}
