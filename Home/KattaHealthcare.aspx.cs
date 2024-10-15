using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_KattaHealthcare : BaseClass
{
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //protected void lnkSearch_Click(object sender, EventArgs e)
    //{
    //    if (ddlLocation.SelectedIndex == 0)
    //    {
    //        Response.Write("<script>alert('Please Select Location');window.location='Home.aspx';</script>");
    //    }
    //    else if (ddlService.SelectedIndex == 0)
    //    {
    //        Response.Write("<script>alert('Please Select Service');window.location='Home.aspx';</script>");
    //    }
    //    else
    //    {
    //        DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    //        Response.Redirect("~/Services/Customer/CreateServiceOrder.aspx?loc=" + ddlLocation.SelectedItem + "&locd=" + ddlLocation.SelectedValue + "&ser=" + ddlService.SelectedItem + "&serd=" + ddlService.SelectedValue + "", false);
    //        //Response.Redirect("~/HOME/PAGES/CreateServiceOrder.aspx?loc=" + ddlLocation.Text + "&locd=" + ddlLocation.SelectedValue + "&ser=" + ddlService.Text + "&serd=" + dbc.getCodeByService(txtServices.Text) + "", false);
    //    }

    //}

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int insert_ok = dbc.insert_tblenquiry(txtName.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtemail.Text.Replace("'", "\\'"), ddlpolicy.Text.Replace("'", "\\'"), txtcomment.Text.Replace("'", "\\'"),"","");
            if (insert_ok == 1)
            {
                ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "MessageBox",
                "alert('Thank you for submitting Request...!!!');window.location='KattaHealthcare.aspx';", true);
              
                clear();
            }
            else
            {
                ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "MessageBox",
                "alert('Please Try Again...!!!');window.location='KattaHealthcare.aspx';", true);
              
            }
            clear();

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
        }
    }
   
    public void clear()
    {
        txtcomment.Text = "";
        txtemail.Text = "";
        txtmobile.Text = "";
        txtName.Text = "";
        //ddlpolicy.SelectedIndex = 0;
        ddlpolicy.Text = "";


        //txtlcomment.Text = "";
        //txtlemail.Text = "";
        //txtlmb.Text = "";
        //txtlname.Text = "";
        //ddllpolicy.SelectedIndex = 0;

        //txtmcomment.Text = "";
        //txtmemail.Text = "";
        //txtmmb.Text = "";
        //txtmname.Text = "";
       
    }

    //protected void btnLifesubmit_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        int insert_ok = dbc.insert_tblenquiry(txtlname.Text.Replace("'", "\\'"), txtlmb.Text.Replace("'", "\\'"), txtlemail.Text.Replace("'", "\\'"), ddllpolicy.SelectedValue.ToString(), txtlcomment.Text.Replace("'", "\\'"),"","");
    //        if (insert_ok == 1)
    //        {
    //            ScriptManager.RegisterStartupScript(
    //            this,
    //            this.GetType(),
    //            "MessageBox",
    //            "alert('Thank you for submitting Request...!!!');window.location='KattaHealthcare.aspx';", true);

    //            clear();
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(
    //            this,
    //            this.GetType(),
    //            "MessageBox",
    //            "alert('Please Try Again...!!!');window.location='KattaHealthcare.aspx';", true);

    //        }
    //        clear();

    //    }
    //    catch (Exception ex)
    //    {
    //        string exp = ex.Message;
    //        dbc.con.Close();
    //    }
    //}

    //protected void btnmedicalsubmit_Click(object sender, EventArgs e)
    //{

    //    try
    //    {
           
    //        int insert_ok = dbc.insert_tblenquiry(txtmname.Text.Replace("'", "\\'"), txtmmb.Text.Replace("'", "\\'"), txtmemail.Text.Replace("'", "\\'"), rgbyes.Checked?"Yes":"No", txtmcomment.Text.Replace("'", "\\'"),"","");
    //        if (insert_ok == 1)
    //        {
    //            ScriptManager.RegisterStartupScript(
    //            this,
    //            this.GetType(),
    //            "MessageBox",
    //            "alert('Thank you for submitting Request...!!!');window.location='KattaHealthcare.aspx';", true);

    //            clear();
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(
    //            this,
    //            this.GetType(),
    //            "MessageBox",
    //            "alert('Please Try Again...!!!');window.location='KattaHealthcare.aspx';", true);

    //        }
    //        clear();

    //    }
    //    catch (Exception ex)
    //    {
    //        string exp = ex.Message;
    //        dbc.con.Close();
    //    }
    //}
}