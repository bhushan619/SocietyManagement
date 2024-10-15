using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_FAQ : BaseClass
{
    DatabaseConnectionSKAdmin dbc = new DatabaseConnectionSKAdmin();RegexUtilities rex = new RegexUtilities();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int insert_ok = dbc.insert_tblenquiry(txtName.Text.Replace("'", "\\'"), txtmobile.Text.Replace("'", "\\'"), txtemail.Text.Replace("'", "\\'"), "", txtcomment.Text.Replace("'", "\\'"),"","");
            if (insert_ok == 1)
            {
                MessageDisplay(Resources.ErrorMessages.Submit, "alert alert-success");
                clear();
            }
            else
            {
                MessageDisplay(Resources.ErrorMessages.SomeError, "alert alert-danger");
            }
            clear();

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            dbc.con.Close();
        }
    }
    void MessageDisplay(string message, string cssClass)
    {
        lblMessage.Text = message;
        divMessage.Attributes.Add("class", cssClass);
    }
    public void clear()
    {
        txtcomment.Text = "";
        txtemail.Text = "";
        txtmobile.Text = "";
        txtName.Text = "";
      
    }
}