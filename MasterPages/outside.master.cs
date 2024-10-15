using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPages_outside : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (IsPostBack)
        {

        }
       else if (!IsPostBack)
        { 
            String activepage = Request.RawUrl;
            if (activepage.Contains("Login.aspx"))
            {
                hyLogin.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("Contact.aspx"))
            {
                hyContact.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("Career.aspx"))
            {
                hycareer.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("Enquiry.aspx"))
            {
                hyEnquiry.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("Blog.aspx"))
            {
                hyBlog.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("SVendorProfile.aspx"))
            {
                hyProfile.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("CustomerProfile.aspx"))
            {
                hyProfile.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("ViewOrders.aspx"))
            {
                hyOrders.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("KattaHealthcare.aspx"))
            {
                hyServices.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
          
            else if (activepage.Contains("Vendor.aspx"))
            {
                hyVendor.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("KattaManager.apsx"))
            {
                hymanager.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("Sales.aspx"))
            {
                hysales.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else if (activepage.Contains("ChangePassword.aspx"))
            {
                hyChangePass.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }
            else
            {
                hyHome.Attributes.Add("style", "color:#8ec2e8;font-weight:600");
            }

            
            if (Request.Cookies["CookieCustomerEmail"] != null)
            {
                hyLogin.Visible = false;
                hyContact.Visible = false;
                hyEnquiry.Visible = false;
               
                hyLogout.Visible = true;
                hyProfile.Visible = true;
                hyOrders.Visible = true;

                hyVendor.Visible = true;
              
                hyServices.Visible = true;

                hyBlog.Visible = true;
                hysales.Visible = false;
                hyChangePass.Visible = true;

                Knownus.Visible = false;
                joinus.Visible = false;


                hyProfile.NavigateUrl = "~/Home/CustomerProfile.aspx";
            }
            else if (Request.Cookies["CookieVendorEmail"] != null)
            {
                hyLogin.Visible = false;
                hyContact.Visible = false;
                hyEnquiry.Visible = false;
                
                hyLogout.Visible = true;
                hyProfile.Visible = true;
                hyOrders.Visible = true;

              
                hyServices.Visible = true;
               

                hyBlog.Visible = true;
                hysales.Visible = false;
                hyChangePass.Visible = true;

                Knownus.Visible = false;
                joinus.Visible = false;

                hyProfile.NavigateUrl = "~/Home/SVendorProfile.aspx";
            }
            else
            {
                hyLogin.Visible = true;
                hyContact.Visible = true;
                hyEnquiry.Visible = true;
               
                hyLogout.Visible = false;
                hyProfile.Visible = false;
                hyOrders.Visible = false;
                hyVendor.Visible = false;
                hyServices.Visible = false;
                hyHome.Visible = true;
                hyBlog.Visible = true;
                hysales.Visible = true;
                hyVendor.Visible = true;
                hymanager.Visible = true;
                hyServices.Visible = true;
                hycareer.Visible = true;
                hyChangePass.Visible = false;
            }
        }
    }
}
