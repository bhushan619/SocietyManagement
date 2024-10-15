using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Configuration;
using MySql.Data.MySqlClient;

public partial class Society_Admin_Employee_Dashbord : System.Web.UI.Page
{

    DatabaseConnection dbc = new DatabaseConnection();RegexUtilities rex = new RegexUtilities();
    static string EditPersonalId = string.Empty;
    static int newCountStart = 0;
    static int newCountEnd = 0;
  
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) == null)
            {
                Response.Redirect("~/Home/Login.aspx", false);
            }
            else if (!IsPostBack)
            {

                getAlbum();
                newCountStart = 0;
                newCountEnd = 0;
                getPollQueData();
                getClassifiedData();
                getRequestData();
                getEventEnnouncementData();
                getPersonalDetails();
              

                string query = "   SELECT tblsocietynoticeboard.intId, tblsocietynoticeboard.varSocietyId, tblsocietynoticeboard.varPersonalId, tblsocietynoticeboard.intRole, tblsocietynoticeboard.varSubject, tblsocietynoticeboard.varDescription, tblsocietynoticeboard.varCreatedDate, tblsocietynoticeboard.varCreatedBy, tblsocietynoticeboard.varStatus, tblsocietynoticeboard.intIsActive,";
                query += " CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')', tblproperty.varName) AS Property FROM tblsocietynoticeboard INNER JOIN tblproperty ON tblsocietynoticeboard.varPersonalId = tblproperty.varPropertyId INNER JOIN  tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId  where tblsocietynoticeboard.intIsActive=1 ";
                query += " and tblsocietynoticeboard.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  order by  tblsocietynoticeboard.intId desc limit 10";
                SqlNoticeboard.SelectCommand = query;
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            Response.Redirect("~/Home/Login.aspx", false);
        }
    }
    public void getPersonalDetails()
    {
        try
        {
            dbc.con1.Open();
            // dbc.dr.Dispose();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("sp_Select_SocietyPersonnelFullDetail_By_WhereCondi", dbc.con1);
            cmd.CommandType = CommandType.StoredProcedure;
            string whereemp = "tblsocietypersonnel.intSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblsocietypersonnel.intEmpCode ='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'";
            //string whereproperty = "tblproperty.intSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblproperty.varPropertyId ='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'";
            cmd.Parameters.Add(new MySqlParameter("spwhere", whereemp));
            //      MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);


            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblpFullName.Text = dbc.dr["EmpName"].ToString();
                lblpGender.Text = dbc.dr["varGender"].ToString();
                lblpAddress.Text = dbc.dr["varAddress"].ToString();
                lblpPrimaryMobile.Text = dbc.dr["varMbPrimary"].ToString();
                lblpOtherMobile.Text = dbc.dr["varMbOther"].ToString();
                lblpPrimaryEmail.Text = dbc.dr["varPrimaryEmail"].ToString();
                lblpOtheremail.Text = dbc.dr["varEmailOther"].ToString();
                lblpUsername.Text = dbc.dr["varUsername"].ToString();
                hpfb.NavigateUrl = Page.ResolveUrl(dbc.dr["varFBLink"].ToString());
                hpgoogle.NavigateUrl = dbc.dr["varGoogleLink"].ToString();
                hptwitter.NavigateUrl = dbc.dr["varTwitterLink"].ToString();
            }
            dbc.con1.Close();
        }
        catch (Exception ex)
        {
            dbc.con1.Close();
            string exp = ex.Message;
        }
    }
    public void getEventEnnouncementData()
    {
        try
        {
            DataTable dt = new DataTable();

            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            string query = "SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole, ";
            query += " tbleventannouncement.intEventType, tbleventannouncement.varSubject, tbleventannouncement.varDescription,DATE_FORMAT(tbleventannouncement.varStartDate,'%d-%m-%Y') as varStartDate, ";
            query += " DATE_FORMAT(tbleventannouncement.varEndDate,'%d-%m-%Y') as varEndDate , tbleventannouncement.varStartTime, tbleventannouncement.varEndTime, tbleventannouncement.varLocation, ";
            query += " tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, tbleventannouncement.varContactName, tbleventannouncement.varMobile, ";
            query += " tbleventannouncement.varEmail, tbleventannouncement.varEventImage, tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy, ";
            query += " tbleventannouncement.intIsActive, countrymaster.CountryName, statemaster.StateName, citymaster.CityName, tblmastereventtype.varEventTypeName,";
            query += " CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name";
            query += " FROM tbleventannouncement INNER JOIN";
            query += " countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN";
            query += " statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN";
            query += " citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN";
            query += " tblproperty ON tbleventannouncement.varPersonalId = tblproperty.varPropertyId INNER JOIN";
            query += " tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId  INNER JOIN";
            query += " tblmastereventtype ON tbleventannouncement.intEventType = tblmastereventtype.intId";
            cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " WHERE tbleventannouncement.intIsActive =1 and tbleventannouncement.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  order by tbleventannouncement.intId desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            dbc.con.Close();
            query = string.Empty;
            query += "SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole, ";
            query += " tbleventannouncement.intEventType, tbleventannouncement.varSubject, tbleventannouncement.varDescription, DATE_FORMAT(tbleventannouncement.varStartDate, ";
            query += " '%d-%m-%Y') AS varStartDate, DATE_FORMAT(tbleventannouncement.varEndDate, '%d-%m-%Y') AS varEndDate, tbleventannouncement.varStartTime, ";
            query += " tbleventannouncement.varEndTime, tbleventannouncement.varLocation, tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, ";
            query += " tbleventannouncement.varContactName, tbleventannouncement.varMobile, tbleventannouncement.varEmail, tbleventannouncement.varEventImage, ";
            query += " tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy, tbleventannouncement.intIsActive, countrymaster.CountryName, ";
            query += " statemaster.StateName, citymaster.CityName, tblmastereventtype.varEventTypeName,concat(rolesmasterculturemap.RoleName,'-' ,tblsocietypersonnel.varEmpName) as Name";
            query += " FROM tbleventannouncement INNER JOIN";
            query += " countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN";
            query += " statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN";
            query += " citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN";
            query += " tblmastereventtype ON tbleventannouncement.intEventType = tblmastereventtype.intId INNER JOIN";
            query += " tblsocietypersonnel ON tbleventannouncement.varPersonalId = tblsocietypersonnel.intEmpCode INNER JOIN";
            query += " rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId";

            cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " WHERE tbleventannouncement.intIsActive =1 and tbleventannouncement.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  order by tbleventannouncement.intId desc", dbc.con);
            adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
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
    public void getAlbum()
    {
        try
        {
            sqlGallery.SelectCommand = "SELECT  intId, varSocietyId, varPersonalId, intRole, varSubject, varDescription, varGallaryImage, varCreatedDate, varCreatedBy, intIsActive FROM tblsocietygallary where varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and intRole=" + dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Admin") + " order by intid desc limit 6";
            LstGallary.DataBind();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }

    }
    public void getPollQueData()
    {
        try
        {
            newCountStart = newCountStart + 1;
            newCountEnd = newCountEnd + 1;
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varQuestion, varOptionalText, varOption1, varOption2, varOption3, varOption4, varAnswer, varContactName, varMobile, varEmail, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5 FROM tblpoll WHERE intIsActive=1 and varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' limit " + newCountStart + "," + newCountEnd + "", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            lstPoll.DataSource = dt;
            lstPoll.DataBind();
            dbc.con.Close();

            dbc.con.Open();
            cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intPollId, varSocietyId, varPersonalId, varAnswer, varAnswerDate, varAnswerTime, varRemark FROM tblpollanswer WHERE  intPollId=" + dt.Rows[0][0].ToString() + " and varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and varPersonalId='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'", dbc.con);
            dbc.dr2 = cmd.ExecuteReader();
            if (dbc.dr2.Read())
            {
                dt.Rows.Clear();
                dbc.con.Close();
                getPollQueData();
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
    protected void btnPollAnswer_Click(object sender, System.EventArgs e)
    {
        try
        {
            string answer = string.Empty;
            RadioButton op1 = new System.Web.UI.WebControls.RadioButton();
            RadioButton op2 = new System.Web.UI.WebControls.RadioButton();
            RadioButton op3 = new System.Web.UI.WebControls.RadioButton();
            RadioButton op4 = new System.Web.UI.WebControls.RadioButton();
            Label ridPoll = new System.Web.UI.WebControls.Label();
            foreach (ListViewDataItem item in lstPoll.Items)
            {
                op1 = (RadioButton)item.FindControl("op1");
                op2 = (RadioButton)item.FindControl("op2");
                op3 = (RadioButton)item.FindControl("op3");
                op4 = (RadioButton)item.FindControl("op4");
                ridPoll = (Label)item.FindControl("idPoll");

                answer = op1.Checked ? op1.Text : op2.Checked ? op2.Text : op3.Checked ? op3.Text : op4.Checked ? op4.Text : "";
            }

            if (answer == "")
            {
                Response.Write("<script>alert('Please Select Answer..!!')</script>");
            }
            else
            {
                int insert_ok = dbc.insert_tblpollanswer(Convert.ToInt32(ridPoll.Text), rex.DecryptString(Request.Cookies["LoggedEmpId"].Value), rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), answer, DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd"), DateTime.UtcNow.AddMinutes(330).ToString("hh:mm:ss"), "");
                if (insert_ok == 1)
                {
                    Response.Write("<script>alert('Poll answer submitted successfully..!!')</script>");
                }
            }
            newCountStart = -1;
            newCountEnd = 0;
            getPollQueData();
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }


    public void getClassifiedData()
    {
        try
        {
            DataTable dt = new DataTable();

            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varSubject, varDescription, varLocation, intCountry, intState, intCity, varPin, varContactName, varMobile, varEmail, varClassifiedImage, varCreatedDate, varCreatedBy, intIsActive FROM tblclassified WHERE intIsActive =1 and varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by  intId desc limit 4", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstTypeClassified.DataSource = dt;
            lstTypeClassified.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void lstInvoices_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            string[] cmdArgs = e.CommandArgument.ToString().Split(':');
            Cache["InvoiceId"] = cmdArgs[0].ToString();
            Cache["PersonnelId"] = cmdArgs[1].ToString();
            Response.Redirect("~/Society/Accounts/ViewInvoices.aspx", false);
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }

    }
    public void getRequestData()
    {
        try { }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
        //try
        //{
        //    DataTable dt = new DataTable();

        //    dbc.con.Open();
        //    MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
        //    cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblrequest.intId, tblrequest.varSocietyId, tblrequest.intPersonelRole, tblrequest.varAssignToRoleId, tblrequest.varDate, tblrequest.varTime, tblrequest.varSubject, tblrequest.varDescription, tblrequest.varStatus, tblrequest.varRemark, tblrequest.intIsActive, CONCAT(tblproperty.varPropertyCode, '-', tblmastersocietywing.varWingName, '-', tblproperty.varName) AS Pname, tblrequest.varPersonneId FROM tblrequest INNER JOIN tblproperty ON tblrequest.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblrequest.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by  intId desc limit 4", dbc.con);
        //    MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
        //    adp.Fill(dt);

        //    lstRequests.DataSource = dt;
        //    lstRequests.DataBind();
        //    dbc.con.Close();

        //}
        //catch (Exception ex)
        //{
        //    //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        //}
    }




    protected void lstTypeClassified_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        try
        {
            int claasifiedintid = Convert.ToInt32(e.CommandArgument.ToString());

            if (e.CommandName == "View")
            {
                Cache["claasifiedIntid"] = e.CommandArgument.ToString();
                Response.Redirect("~/Society/View/FullClassified.aspx", false);
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
        }
    }
    
  
}

      