using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using SocietyKatta.App_Code.BAL;
using SocietyKatta.App_Code.BAL.Society.MasterData;

public partial class SK_MasterData_VendorServices : ClsVendorService
{

  
    static int EditServiceId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getServiceGridData();
            using (ClsCommanData cjc = new ClsCommanData())
            {
                txtMainCode.Text = cjc.CreateRandomId(5);
            }

        }
    }

    public void getServiceGridData()
    {
        try
        {
            ListView1.DataSource = FetchVendorService(1);
            ListView1.DataBind();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    public void clear()
    {
        try
        {
            chkIsActive.Checked = false;
            txtDescription.Text = "";

            txtName.Text = "";
            txtRemark.Text = "";

            txtVisitingFee.Text = "";

            ImgProfile.ImageUrl = "~/SK/MasterData/serviceimages/NoProfile.png";
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
            string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
            string fileName = txtMainCode.Text + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;     

            if (contentLength != 0)
            {
                string myStr = ImgProfile.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/SK/MasterData/serviceimages/") + fileName);
                if (AddVendorServiceDetails(Convert.ToInt32(txtMainCode.Text), txtName.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), txtVisitingFee.Text.Replace("'", "\\'"), txtRemark.Text.Replace("'", "\\'"), 1, chkIsActive.Checked ? 1 : 0, fileName))
                {
                    MessageDisplay(Resources.Messages.Added, "alert alert-success");
                    clear();
                    getServiceGridData();
                }
                else
                {
                    MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
                }
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.UploadImage, "alert alert-danger");
            }
            getServiceGridData();
            using (ClsCommanData xa = new ClsCommanData())
            {
                txtMainCode.Text = "";
                txtMainCode.Text = xa.CreateRandomId(5);
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
    protected void btnReset_Click(object sender, EventArgs e)
    {
        try
        {
            using (ClsCommanData cjc = new ClsCommanData())
            {
                txtMainCode.Text = cjc.CreateRandomId(5);
            }

            clear();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
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
                EditServiceId = Convert.ToInt32(e.CommandArgument.ToString());
                btnUpdate.Visible = true;
                btnSubmit.Visible = false;
                GetVendorServiceeById(Convert.ToInt32(e.CommandArgument.ToString()));
                txtDescription.Text = Description;
                txtMainCode.Text = Convert.ToString(ServiceCode);
                txtVisitingFee.Text = VisitingFee.ToString();
                txtName.Text = Name;
                txtRemark.Text = Remark;
                chkIsActive.Checked = Convert.ToBoolean(IsActive);
                ImgProfile.ImageUrl = "~/SK/MasterData/serviceimages/" + varImage;

            }

            else if (e.CommandName == "Delets")
            {
                if (DeleteVendorServiceDetails(Convert.ToInt32(e.CommandArgument.ToString())))
                {
                    MessageDisplay(Resources.Messages.Deleted, "alert alert-success");

                   
                }
                else
                {
                    MessageDisplay(Resources.Messages.NotDeleted, "alert alert-danger");
                } 
                getServiceGridData();
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
            int contentLength = fupProPic.PostedFile.ContentLength;//You may need it for validation
            string contentType = fupProPic.PostedFile.ContentType;//You may need it for validation
            string fileName = EditServiceId + " " + fupProPic.PostedFile.FileName;//fupProPic.PostedFile.FileName;     

            if (contentLength != 0)
            {
                string myStr = ImgProfile.ImageUrl;
                string[] ssize = myStr.Split('/');
                fupProPic.PostedFile.SaveAs(Server.MapPath("~/SK/MasterData/serviceimages/") + fileName);
                if (UpdateVendorServiceTypeById(EditServiceId, txtName.Text.Replace("'", "\\'"), txtDescription.Text.Replace("'", "\\'"), txtRemark.Text.Replace("'", "\\'"), txtVisitingFee.Text.Replace("'", "\\'"), chkIsActive.Checked ? 1 : 0, fileName))
                {
                    MessageDisplay(Resources.Messages.Updated, "alert alert-success");

                    getServiceGridData();
                }
            }
            else
            {
                MessageDisplay(Resources.Messages.NotUpdated, "alert alert-danger");
            }
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
            EditServiceId = 0;
            clear();

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
}