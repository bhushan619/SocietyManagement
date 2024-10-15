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
using System.Web.Services;

public partial class Society_Property_Dashbord : System.Web.UI.Page
{
    DatabaseConnection dbc = new DatabaseConnection();
    RegexUtilities rex = new RegexUtilities();

    static string EditPersonalId = string.Empty;
    static int newCountStart = 0;
    static int newCountEnd = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (Request.Cookies["CookieSocietyId"] == null)
            {
                Response.Redirect("~/Home/Login.aspx", false);
            }
            else if (!IsPostBack)
            {

                getCountData();
                getAlbum();
                newCountStart = 0;
                newCountEnd = 0;
                getPollQueData();
                getClassifiedData();
                getRequestData();
                getPropertyMemberData();
                getEventEnnouncementData();
                getNoticeBoardData();
                getComplaintData();

               


                string query = "    SELECT DISTINCT   CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name, tblinvoice.varInvoiceId AS InvoiceNo,  ";
                query += "   DATE_FORMAT(tblinvoice.varDateTime,'%d-%m-%Y') AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  ";
                query += "   DATE_FORMAT(tblinvoice.varDateTime,'%d-%m-%Y') AS `Date`, tblinvoice.varTotal AS Amount, tblinvoiceforpersonnels.varOutstanding AS Outstanding,  ";
                query += "   tblinvoiceforpersonnels.varPaymentStatus AS `Payment Status`,tblinvoiceforpersonnels.varPersonnelId ";
                query += "   FROM     tblinvoice INNER JOIN ";
                query += "  tblinvoicedetails ON tblinvoice.varInvoiceId = tblinvoicedetails.varInvoiceId INNER JOIN ";
                query += "   tblinvoiceforpersonnels ON tblinvoice.varInvoiceId = tblinvoiceforpersonnels.varInvoiceId INNER JOIN ";
                query += "   tblproperty ON tblinvoiceforpersonnels.varPersonnelId = tblproperty.varPropertyId INNER JOIN ";
                query += "     tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblinvoice.intFromSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  order by tblinvoice.intid desc ";

                SqlDataSource1.SelectCommand = query;
            }

        }

        catch (Exception ex)
        {
            Response.Redirect("~/Home/Login.aspx", false);
            string exp = ex.Message;
        }
    }
    public void getCountData()
    {
        try
        {
            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intid) as Totalclassified FROM tblclassified WHERE varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  and intIsActive=1  ", dbc.con1);

            dbc.dr = cmd.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblTopClassifieds.Text = string.IsNullOrEmpty(dbc.dr["Totalclassified"].ToString()) ? "0" : dbc.dr["Totalclassified"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmda = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId) as Totalrequest FROM tblrequest WHERE   varStatus='Pending' and varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ", dbc.con1);

            dbc.dr = cmda.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblTopRequests.Text = string.IsNullOrEmpty(dbc.dr["Totalrequest"].ToString()) ? "0" : dbc.dr["Totalrequest"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdpr = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId) as Totalproperty FROM tblproperty WHERE intIsActive=1 and  varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ", dbc.con1);
            dbc.dr = cmdpr.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblTopProperties.Text = string.IsNullOrEmpty(dbc.dr["Totalproperty"].ToString()) ? "0" : dbc.dr["Totalproperty"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            dbc.con1.Close();
            dbc.con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdemp = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId)as Totalemp FROM tblsocietypersonnel WHERE intIsActive=1 and  intSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ", dbc.con1);
            dbc.dr = cmdemp.ExecuteReader();
            if (dbc.dr.Read())
            {
                lblTopEmployees.Text = string.IsNullOrEmpty(dbc.dr["Totalemp"].ToString()) ? "0" : dbc.dr["Totalemp"].ToString();
            }
            dbc.con1.Close();
            dbc.dr.Dispose();

            //dbc.con1.Close();
            //dbc.con1.Open();
            //MySql.Data.MySqlClient.MySqlCommand cmdp = new MySql.Data.MySqlClient.MySqlCommand("SELECT count(intId) as TotalPoll FROM tblpoll WHERE intIsActive=1 and  varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' ", dbc.con1);
            //  dbc.dr = cmdp.ExecuteReader();
            //if (dbc.dr.Read())
            //{
            //    lblTopPolls.Text = dbc.dr["TotalPoll"].ToString();
            //}
            //dbc.con1.Close();
            //dbc.dr.Dispose();
        }
        catch (Exception ex)
        {
            dbc.con1.Close();
            dbc.dr.Dispose();
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
            query += "  tbleventannouncement.varSubject, tbleventannouncement.varDescription,DATE_FORMAT(tbleventannouncement.varStartDate,'%d-%m-%Y') as varStartDate, ";
            query += " DATE_FORMAT(tbleventannouncement.varEndDate,'%d-%m-%Y') as varEndDate , tbleventannouncement.varStartTime, tbleventannouncement.varEndTime, tbleventannouncement.varLocation, ";
            query += " tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, tbleventannouncement.varContactName, tbleventannouncement.varMobile, ";
            query += " tbleventannouncement.varEmail, tbleventannouncement.varEventImage, tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy, ";
            query += " tbleventannouncement.intIsActive, countrymaster.CountryName, statemaster.StateName, citymaster.CityName,";
            query += " CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name";
            query += " FROM tbleventannouncement INNER JOIN";
            query += " countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN";
            query += " statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN";
            query += " citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN";
            query += " tblproperty ON tbleventannouncement.varPersonalId = tblproperty.varPropertyId INNER JOIN";
            query += " tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId  ";

            cmd = new MySql.Data.MySqlClient.MySqlCommand(query + " WHERE tbleventannouncement.intIsActive =1 and tbleventannouncement.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  order by tbleventannouncement.intId desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);
            dbc.con.Close();
            query = string.Empty;
            query += "SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole, ";
            query += " tbleventannouncement.varSubject, tbleventannouncement.varDescription, DATE_FORMAT(tbleventannouncement.varStartDate, ";
            query += " '%d-%m-%Y') AS varStartDate, DATE_FORMAT(tbleventannouncement.varEndDate, '%d-%m-%Y') AS varEndDate, tbleventannouncement.varStartTime, ";
            query += " tbleventannouncement.varEndTime, tbleventannouncement.varLocation, tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, ";
            query += " tbleventannouncement.varContactName, tbleventannouncement.varMobile, tbleventannouncement.varEmail, tbleventannouncement.varEventImage, ";
            query += " tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy, tbleventannouncement.intIsActive, countrymaster.CountryName, ";
            query += " statemaster.StateName, citymaster.CityName, concat(rolesmasterculturemap.RoleName,'-' ,tblsocietypersonnel.varEmpName) as Name";
            query += " FROM tbleventannouncement INNER JOIN";
            query += " countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN";
            query += " statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN";
            query += " citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN";

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

    public void getNoticeBoardData()
    {
        try
        {
            DataTable ndtu = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand ncmdu = new MySql.Data.MySqlClient.MySqlCommand();
            ncmdu = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblsocietynoticeboard.intId, tblsocietynoticeboard.varSocietyId, tblsocietynoticeboard.varPersonalId, tblsocietynoticeboard.intRole, tblsocietynoticeboard.varSubject, tblsocietynoticeboard.varDescription, tblsocietynoticeboard.varCreatedDate, tblsocietynoticeboard.varCreatedBy, tblsocietynoticeboard.varStatus, tblsocietynoticeboard.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')', tblproperty.varName) AS Name FROM tblsocietynoticeboard INNER JOIN tblproperty ON tblsocietynoticeboard.varPersonalId = tblproperty.varPropertyId INNER JOIN  tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblsocietynoticeboard.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblsocietynoticeboard.varStatus='Approved' order by tblsocietynoticeboard.intId desc limit 3", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter nadpu = new MySql.Data.MySqlClient.MySqlDataAdapter(ncmdu);
            nadpu.Fill(ndtu);

            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblsocietynoticeboard.intId,tblsocietynoticeboard.varPersonalId, tblsocietynoticeboard.varSocietyId, tblsocietynoticeboard.varSubject, tblsocietynoticeboard.varDescription, tblsocietynoticeboard.varCreatedDate, tblsocietynoticeboard.varCreatedBy, tblsocietynoticeboard.varStatus, tblsocietynoticeboard.intIsActive,  tblsocietypersonnel.intRole, rolesmaster.RoleId, CONCAT( rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName) as Name,  tblsocietynoticeboard.varPersonalId FROM    tblsocietynoticeboard INNER JOIN   tblsocietypersonnel ON tblsocietynoticeboard.varPersonalId = tblsocietypersonnel.intEmpCode INNER JOIN            rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN       rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE tblsocietynoticeboard.varSocietyId = '" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  and tblsocietynoticeboard.varStatus='Approved' order by tblsocietynoticeboard.intid desc limit 3", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoce = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoce);
            adpdoce.Fill(ndtu);

            lstNoticeboard.DataSource = ndtu;
            lstNoticeboard.DataBind();
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

        sqlGallery.SelectCommand = "SELECT  intId, varSocietyId, varPersonalId, intRole, varSubject, varDescription, varGallaryImage, varCreatedDate, varCreatedBy, intIsActive FROM tblsocietygallary where varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and intRole=" + dbc.GetPropertyOwnerRoleIdBySocietyId(rex.DecryptString(Request.Cookies["CookieSocietyId"].Value), "Admin") + " order by intid desc limit 6";
        LstGallary.DataBind();
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
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varSocietyId, varPersonalId, intRole, varQuestion, varOptionalText, varOption1, varOption2, varOption3, varOption4, varAnswer, varContactName, varMobile, varEmail, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5 FROM tblpoll WHERE intIsActive=1 and varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by intId desc  limit " + newCountStart + "," + newCountEnd + "", dbc.con);
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
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void lstInvoices_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        string[] cmdArgs = e.CommandArgument.ToString().Split(':');
        Cache["InvoiceId"] = cmdArgs[0].ToString();
        Cache["PersonnelId"] = cmdArgs[1].ToString();
        Response.Redirect("~/Society/Accounts/ViewInvoices.aspx", false);
    }
    public void getRequestData()
    {
        try
        {
            DataTable dt = new DataTable();

            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblrequest.intId, tblrequest.varSocietyId, tblrequest.intPersonelRole, tblrequest.varAssignToRoleId, tblrequest.varDate, tblrequest.varTime, tblrequest.varSubject, tblrequest.varDescription, tblrequest.varStatus, tblrequest.varRemark, tblrequest.intIsActive, CONCAT(tblproperty.varPropertyCode, '-', tblmastersocietywing.varWingName, '-', tblproperty.varName) AS Pname, tblrequest.varPersonneId FROM tblrequest INNER JOIN tblproperty ON tblrequest.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE tblrequest.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by  intId desc limit 4", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            lstRequests.DataSource = dt;
            lstRequests.DataBind();
            dbc.con.Close();

        }
        catch (Exception ex)
        {
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    public void getPropertyMemberData()
    {
        try
        {
            DataTable dtp = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmdp = new MySql.Data.MySqlClient.MySqlCommand();
            cmdp = new MySql.Data.MySqlClient.MySqlCommand("sp_select_PropertyDetailsByWhere", dbc.con);
            cmdp.CommandType = CommandType.StoredProcedure;
            /// string whereproperty = "tblproperty.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' and tblproperty.varPropertyId ='" + rex.DecryptString(Request.Cookies["LoggedEmpId"].Value) + "'";
            string whereproperty = "tblproperty.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by intid desc limit 4";
            cmdp.Parameters.Add(new MySqlParameter("spwhere", whereproperty));
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmdp);
            adp.Fill(dtp);

            lstPropertyMember.DataSource = dtp;
            lstPropertyMember.DataBind();
            dbc.con.Close();
        }
        catch (Exception ex)
        {
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }
    protected void lstPropertyMember_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        string lstempintid = e.CommandArgument.ToString();

        if (e.CommandName == "View")
        {
            Cache["PropertyProfile"] = e.CommandArgument.ToString();
            Response.Redirect("~/Society/Admin/Property/ViewPropertyFullProfile.aspx", false);
        }
    }


    protected void lstTypeClassified_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        int claasifiedintid = Convert.ToInt32(e.CommandArgument.ToString());

        if (e.CommandName == "View")
        {
            Cache["claasifiedIntid"] = e.CommandArgument.ToString();
            Response.Redirect("~/Society/View/FullClassified.aspx", false);
        }
    }
    public void getComplaintData()
    {
        try
        {
            DataTable dt = new DataTable();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT tblcompliants.intId, tblcompliants.varSocietyId, tblcompliants.varPersonneId, tblcompliants.intPersonelRole, tblcompliants.varAssignToRoleId,date_format(tblcompliants.varDate,'%d-%m-%Y') as varDate, tblcompliants.varTime, tblcompliants.varSubject, tblcompliants.varDescription, tblcompliants.varStatus, tblcompliants.varRemark, tblcompliants.intIsActive, CONCAT('(', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')', tblproperty.varName) AS Name,date_format(tblcompliants.varProceedDate,'%d-%m-%Y') as varProceedDate FROM tblcompliants INNER JOIN tblproperty ON tblcompliants.varPersonneId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId WHERE varStatus='New' and tblcompliants.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "' order by tblcompliants.intid desc", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(cmd);
            adp.Fill(dt);

            dbc.con.Close();
            dbc.con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmddoce = new MySql.Data.MySqlClient.MySqlCommand();
            cmddoce = new MySql.Data.MySqlClient.MySqlCommand("SELECT        tblcompliants.intId, tblcompliants.varSocietyId, tblcompliants.varPersonneId, tblcompliants.intPersonelRole, tblcompliants.varAssignToRoleId,date_format(tblcompliants.varDate,'%d-%m-%Y') as varDate, tblcompliants.varTime, tblcompliants.varSubject, tblcompliants.varDescription, tblcompliants.varStatus, tblcompliants.varRemark, tblcompliants.intIsActive, tblsocietypersonnel.intRole, rolesmaster.RoleId, CONCAT(rolesmasterculturemap.RoleName, '-', tblsocietypersonnel.varEmpName)  AS Name ,date_format(tblcompliants.varProceedDate,'%d-%m-%Y') as varProceedDate from  tblcompliants INNER JOIN      tblsocietypersonnel ON tblcompliants.varPersonneId = tblsocietypersonnel.intEmpCode INNER JOIN  rolesmaster ON tblsocietypersonnel.intRole = rolesmaster.RoleId INNER JOIN rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE varStatus='New' and tblcompliants.varSocietyId='" + rex.DecryptString(Request.Cookies["CookieSocietyId"].Value) + "'  ORDER BY tblcompliants.intId DESC", dbc.con);
            MySql.Data.MySqlClient.MySqlDataAdapter adpdoce = new MySql.Data.MySqlClient.MySqlDataAdapter(cmddoce);
            adpdoce.Fill(dt);


            lstcomplaints.DataSource = dt;
            lstcomplaints.DataBind();
            dbc.con.Close();


        }
        catch (Exception ex)
        {
            dbc.con.Close();
            string exp = ex.Message;
            //MessageDisplay(Resources.ErrorMessages.IncorrectValues, "alert alert-danger");
        }
    }

    protected void lstcomplaints_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        int claasifiedintid = Convert.ToInt32(e.CommandArgument.ToString());

        if (e.CommandName == "View")
        {
            Cache["claasifiedIntid"] = e.CommandArgument.ToString();
            Response.Redirect("~/Society/View/ViewComplaints.aspx", false);
        }

    }
   
}
 