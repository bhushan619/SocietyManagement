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
using System.Globalization;

/// <summary>
/// Summary description for DatabaseConnectionSKAdmin
/// </summary>
public class DatabaseConnectionSKAdmin
{
    public MySql.Data.MySqlClient.MySqlConnection con, con1, con2, con3, conprofile;
    public MySql.Data.MySqlClient.MySqlCommand cmd, cmd1;
    public MySql.Data.MySqlClient.MySqlDataReader dr, dr1, dr2;

    public MySql.Data.MySqlClient.MySqlDataAdapter dataAdapter = new MySql.Data.MySqlClient.MySqlDataAdapter();
    public DataTable oDt, oDt1;
    public DataRow oDr;

    string tdt = string.Empty;


    public string begindate = new DateTime(DateTimeOffset.UtcNow.LocalDateTime.Year, DateTimeOffset.UtcNow.LocalDateTime.Month, 1).ToShortDateString();
    public string enddate = DateTimeOffset.UtcNow.AddHours(12).LocalDateTime.ToShortDateString();
	public DatabaseConnectionSKAdmin()
	{
        con = new MySql.Data.MySqlClient.MySqlConnection();
        con.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionStringSKAdmin"].ConnectionString;
        con1 = new MySql.Data.MySqlClient.MySqlConnection();
        con1.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionStringSKAdmin"].ConnectionString;
        con2 = new MySql.Data.MySqlClient.MySqlConnection();
        con2.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionStringSKAdmin"].ConnectionString;
        con3 = new MySql.Data.MySqlClient.MySqlConnection();
        con3.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionStringSKAdmin"].ConnectionString;
        conprofile = new MySql.Data.MySqlClient.MySqlConnection();
        conprofile.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionStringSKAdmin"].ConnectionString;

	}

    /*.....................................Random Function.....................*/
    public string CreateRandomPassword(int PasswordLength)
    {
        string _allowedChars = "123456789";
        Random randNum = new Random();
        char[] chars = new char[PasswordLength];
        int allowedCharCount = _allowedChars.Length;
        for (int i = 0; i < PasswordLength; i++)
        {
            chars[i] = _allowedChars[(int)((_allowedChars.Length) * randNum.NextDouble())];
        }
        return new string(chars);
    }
    public string CreateRandomMemberId(int IdLength)
    {
        string _allowedChars = "123456789";
        Random randNum = new Random();
        char[] chars = new char[IdLength];
        int allowedCharCount = _allowedChars.Length;
        for (int i = 0; i < IdLength; i++)
        {
            chars[i] = _allowedChars[(int)((_allowedChars.Length) * randNum.NextDouble())];
        }
        return new string(chars);
    }
   
    /*................................Country State City Function.................*/
    public DataTable GetCountryMasterData()
    {
        MySqlDataAdapter da = new MySqlDataAdapter("SELECT CountryId,CountryName FROM countrymaster WHERE IsActive=1", con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        System.Data.DataTable dt = ds.Tables[0];
        return dt;
    }
    public DataTable GetstateMasterDataFromCountryId(int CountryId)
    {
        MySqlDataAdapter das = new MySqlDataAdapter("SELECT StateId,StateName FROM statemaster WHERE CountryId=" + CountryId + " and IsActive=1", con);
        DataSet dss = new DataSet();
        das.Fill(dss);
        System.Data.DataTable dts = dss.Tables[0];
        return dts;
    }
    public DataTable GetCityMasterDataFromStateId(int StateId)
    {
        MySqlDataAdapter dac = new MySqlDataAdapter("SELECT CityId,CityName FROM citymaster WHERE StateId =" + StateId + " and IsActive=1", con);
        DataSet dsc = new DataSet();
        dac.Fill(dsc);
        System.Data.DataTable dtc = dsc.Tables[0];
        return dtc;
    }
    public DataTable GetDepartmentMasterDataDropdownBySocietyIdForAddEmployee(string SocietyId)
    {

        MySqlDataAdapter dadd = new MySqlDataAdapter("SELECT intId,varDepartmentName FROM tblskdepartment WHERE intIsActive=1", con);
        DataSet dsd = new DataSet();
        dadd.Fill(dsd);
        System.Data.DataTable dtdd = dsd.Tables[0];
        return dtdd;
    }
    public string CheckMenuinRoleFeatureMap(string roleid, string featureid)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT * FROM rolefeaturesmap WHERE varEmpId='" + roleid + "' AND FeatureId=" + featureid + "", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = 1.ToString();
            }
            else return 0.ToString();
            con1.Close();
            return typeid;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return string.Empty;
        }
    }
    public string GetParentMenuFromSubMenu(string featureid)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT ParentId FROM featuresmaster WHERE FeatureId=" + featureid + "", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["ParentId"].ToString();
            }
            else return 0.ToString();
            con1.Close();
            return typeid;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return string.Empty;
        }
    }
    public int check_already_EmployeeId(string id)
    {
        try
        {
            int schId = 0;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intEmpCode FROM tblskpersonnel WHERE intEmpCode='" + id + "'", con);
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                schId = 1;
            }
            else
            {
                schId = 0;
            }
            con.Close();
            return schId;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return 0;
        }
    }
    public bool check_UsernameExists(string username)
    {
        try
        {
            con.Open();
            cmd = new MySqlCommand("SELECT * FROM tblskpersonnel WHERE varUsername= '" + username + "' ", con);
            dr2 = cmd.ExecuteReader();
            if (dr2.Read())
            {
                con.Close();
                return true;
            }
            else
            {
                con.Close();
                return false;
            }
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            con.Close();
            return false;
        }
    }
    /*.........................get function for dropdown................*/
    public DataTable GetDepartmentMasterDataDropdownForAddEmployee()
    {

        MySqlDataAdapter dadd = new MySqlDataAdapter("SELECT intId,varDepartmentName FROM tblskdepartment where intIsActive=1", con);
        DataSet dsd = new DataSet();
        dadd.Fill(dsd);
        System.Data.DataTable dtdd = dsd.Tables[0];
        return dtdd;
    }

    public DataTable GetRoleListByDeptId(int deptid)
    {

        MySqlDataAdapter dadd = new MySqlDataAdapter("SELECT        rolesmaster.intId, rolesmaster.RoleName, rolesmaster.DeptId, rolesmaster.RoleId FROM    rolesmaster INNER JOIN    tblskdepartment ON rolesmaster.DeptId = tblskdepartment.intId WHERE        rolesmaster.DeptId='"+deptid+"'", con);
        DataSet dsd = new DataSet();
        dadd.Fill(dsd);
        System.Data.DataTable dtdd = dsd.Tables[0];
        return dtdd;
    }
    /*.....................................Super Admin-Anuvaa Module   insert function.....................*/
    public int insert_tblskhelp(string varName, string varMobile, string varEmail, string varSub, string varDescription)
    {
        try
        {
            //int id = max_tblcompliants();
            //id = id + 1;
            con.Close();
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblskhelp( varName, varMobile, varEmail, varSub, varDescription, varDate,ex1,ex2) VALUES ('" + varName + "','" + varMobile + "','" + varEmail + "','" + varSub + "','" + varDescription + "','" + DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd") + "','','')", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();
            return 1;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return 0;
        }

    }

    public int insert_tblsksupport(string varPersonneId, int intPersonelRole, string varName, string varUsername, string varMobile, string varEmail, string varSubject, string varDescription, string varStatus, string varRemark, int intIsActive)
    {
        try
        {
            //int id = max_tblcompliants();
            //id = id + 1;
            con.Close();
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblsksupport (varPersonneId, intPersonelRole, varDate,varName, varUsername, varMobile, varEmail, varSubject, varDescription, varStatus, varRemark, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES ('" + varPersonneId + "'," + intPersonelRole + ",'" + DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd") + "','" + varName + "','" + varUsername + "','" + varMobile + "','" + varEmail + "','" + varSubject + "','" + varDescription + "','" + varStatus + "','" + varRemark + "'," + intIsActive + ",'','','','','')", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();
            return 1;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return 0;
        }

    }
    public int insert_tblenquiry(string name, string mb, string email, string service, string comment, string adhar, string pan)
    {
        try
        {

            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblenquiry(varName, varMobile, varEmail, varServiceName, varDescription,adhar,pan,createdDate) VALUES ('" + name + "','" + mb + "','" + email + "','" + service + "','" + comment + "','" + adhar + "','" + pan + "','" + DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd") + "')", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();
            return 1;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return 0;
        }

    }

    public int insert_tblskpersonnel( string intEmpCode, int intDeptId, int intRole, int intEmpType, string varEmpName,  string varMaritalStatus, string varFatherHusband,  string varDateOfJoin, string varDOB, string varGender, string varMbPrimary, string varMbOther, string varEmailOther, string varPANNo, string varPFNo, string varESINo, int intCountry, int intState, int intCity, string varPin, string varAddress, string varPermanentAddress, string primaryemail, string VarUsername, string varPassword, string varMobile,  string varImage, int intIsActive, string intCreatedBy, string varCreatedDate)
    {
        try
        {
            
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();                                                                                                                     //  varSPhone, varSMobile, varSEmail, varSFax, varCountryId, varStateId, varCityId, varPin, varConstructedby, varCompany, varCompanyAddress, varContactPerson, varContactMobile, varContactPhone, varContactEmail, varConstuctionYear, varTotalArea, varTotalWings, varIsActive, ex1, ex2, ex3, ex4
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblskpersonnel( intEmpCode, intDeptId, intRole, intEmpType, varEmpName, varMaritalStatus, varFatherHusband, varDateOfJoin, varDOB, varGender, varMbPrimary, varMbOther, varEmailOther, varPANNo, varPFNo, varESINo, intCountry, intState, intCity, varPin, varAddress, varPermanentAddress, varPrimaryEmail, varUsername, varPassword, varMobile, varImage, intIsActive, intCreatedBy, varCreatedDate, ex1, ex2, ex3) VALUES('" + intEmpCode + "'," + intDeptId + "," + intRole + "," + intEmpType + ",'" + varEmpName + "','" + varMaritalStatus + "','" + varFatherHusband + "','" + varDateOfJoin + "','" + varDOB + "','" + varGender + "','" + varMbPrimary + "','" + varMbOther + "','" + varEmailOther + "','" + varPANNo + "','" + varPFNo + "','" + varESINo + "'," + intCountry + "," + intState + "," + intCity + ",'" + varPin + "','" + varAddress + "','" + varPermanentAddress + "','" + primaryemail + "','" + VarUsername + "','" + varPassword + "','" + varMobile + "','" + varImage + "'," + intIsActive + ",'" + intCreatedBy + "','" + varCreatedDate + "','','','')", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();

            return 1;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return 0;
        }

    }
    /*.........................update function...................*/
    public int update_tblskpersonnel(int id, int intDeptId, int intRole, int intEmpType, string varEmpName,  string varMaritalStatus, string varFatherHusband,  string varDateOfJoin, string varDOB, string varGender, string varMbPrimary, string varMbOther, string varEmailOther, string varPANNo, string varPFNo, string varESINo, int intCountry, int intState, int intCity, string varPin, string varAddress, string varPermanentAddress, string VarUsername, string varImage, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblskpersonnel SET intEmpType=" + intEmpType + ",   intDeptId = " + intDeptId + ", intRole = " + intRole + ", varEmpName = '" + varEmpName + "', varMaritalStatus = '" + varMaritalStatus + "', varFatherHusband = '" + varFatherHusband + "',  varDateOfJoin = '" + varDateOfJoin + "', varDOB = '" + varDOB + "', varDOB = '" + varDOB + "', varGender = '" + varGender + "', varMbPrimary = '" + varMbPrimary + "',  varMbOther = '" + varMbOther + "', varEmailOther = '" + varEmailOther + "', varPANNo = '" + varPANNo + "', varPFNo = '" + varPFNo + "', varESINo = '" + varESINo + "', intCountry = " + intCountry + ",  intState = " + intState + ", intCity = " + intCity + ", varPin = '" + varPin + "', varAddress = '" + varAddress + "', varPermanentAddress = '" + varPermanentAddress + "', varPrimaryEmail = '" + VarUsername + "',  varImage = '" + varImage + "', intIsActive = " + intIsActive + "    WHERE intId = " + id + "", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();
            con.Close();
            return 1;
        }
        catch (Exception s)
        {
            string strr = s.Message;
            con.Close();
            return 0;
        }
    }
  
    public int update_tblskpersonnelByHerself(string id, string varEmpName, string varMaritalStatus, string varFatherHusband,  string varDOB, string varGender, string varMbPrimary, string varMbOther, string varEmailOther, string varPANNo, string varPFNo, string varESINo, int intCountry, int intState, int intCity, string varPin, string varAddress, string varPermanentAddress, string emailprimary, string VarUsername, string varImage)
    {
        try
        {
            con.Close();
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblskpersonnel SET varEmpName = '" + varEmpName + "', varMaritalStatus = '" + varMaritalStatus + "', varFatherHusband = '" + varFatherHusband + "',  varDOB = '" + varDOB + "', varDOB = '" + varDOB + "', varGender = '" + varGender + "', varMbPrimary = '" + varMbPrimary + "',  varMbOther = '" + varMbOther + "', varEmailOther = '" + varEmailOther + "', varPANNo = '" + varPANNo + "', varPFNo = '" + varPFNo + "', varESINo = '" + varESINo + "', intCountry = " + intCountry + ",  intState = " + intState + ", intCity = " + intCity + ", varPin = '" + varPin + "', varAddress = '" + varAddress + "', varPermanentAddress = '" + varPermanentAddress + "', varPrimaryEmail = '" + emailprimary + "', varUsername = '" + VarUsername + "',  varImage = '" + varImage + "'    WHERE intEmpCode = '" + id + "'", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();
            con.Close();
            return 1;
        }
        catch (Exception s)
        {
            string strr = s.Message;
            con.Close();
            return 0;
        }
    }
    public void update_tblskpersonnelStatusbySKadmin(string Id, string intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblskpersonnel  SET  intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();

        }
        catch (Exception s)
        {

            string strr = s.Message;
            con.Close();

        }
    }
    // Support Update
    public int update_tblsksupportBySKAdmin(int Id, string status)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblsksupport  SET varStatus='" + status + "' WHERE intId =" + Id + "", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();
            return 1;
        }
        catch (Exception s)
        {

            string strr = s.Message;
            con.Close();
            return 0;
        }
    }

    //////////////////// accounting ////////////////

    public bool insert_tblaccountdetails( string name, string desc)
    {
        try
        {
            string acno = CreateRandomPassword(4);

            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblaccountdetails ( varAccountNo, varAccountName, varDescription) VALUES ( '" + acno + "', '" + name + "', '" + desc + "')", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();
            return true;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return false;
        }
    }
    public bool update_tblaccountdetails(string acno, string name, string desc)
    {
        try
        {
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("update tblaccountdetails set varAccountName= '" + name + "', varDescription='" + desc + "' where intId= " + acno + "", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();
            return true;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return false;
        }
    }
    public int insert_tblaccountbook(string varDate, string varAccountNo, string varVoucher, string varReason, string varPreviousBalance, string varEntryType, string varAmount, string varBalance, string varEntryBy)
    {
        try
        {

            if (varEntryType == "1")
            {
                con.Open();
                cmd = new MySqlCommand("INSERT INTO tblaccountbook( varDate, varAccountNo, varVoucher, varReason, varPreviousBalance, varEntryType, varAmount, varBalance, varEntryBy ) VALUES ( '" + varDate + "', '" + varAccountNo + "', '" + varVoucher + "', '" + varReason + "', '" + varPreviousBalance + "', " + varEntryType + ", '" + varAmount + "', '" + varBalance + "', '" + varEntryBy + "')", con);
                cmd.ExecuteNonQuery();
                long x = cmd.LastInsertedId;

                con.Close();

                if (Convert.ToDateTime(varDate) < Convert.ToDateTime(DateTime.UtcNow.ToString("yyyy-MM-dd")))
                {
                    string entries = string.Empty;
                    MySql.Data.MySqlClient.MySqlCommand cmdkk = new MySql.Data.MySqlClient.MySqlCommand(" SELECT intId FROM tblaccountbook WHERE  varDate>'" + varDate + "'   and intId!= " + x + " ORDER by varDate ASC, intId ASC", con);
                    con.Open();
                    dr = cmdkk.ExecuteReader();
                    while (dr.Read())
                    {
                        entries = entries + dr["intId"].ToString() + ";";
                    }
                    con.Close();

                    string[] Kird = entries.Split(';');
                    for (int i = 0; i < Kird.Length - 1; i++)
                    {   // for credit
                        con2.Open();
                        MySql.Data.MySqlClient.MySqlCommand cmdccj = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblaccountbook SET varBalance= varBalance+" + varAmount + ",varPreviousBalance= varPreviousBalance+" + varAmount + " WHERE  intId=" + Convert.ToInt32(Kird[i].ToString()) + "", con2);
                        cmdccj.ExecuteNonQuery();
                        con2.Close();
                    }
                }
            }
            else
            {
                string pAmt = string.Empty;
                if (Convert.ToDateTime(varDate) < Convert.ToDateTime(DateTime.UtcNow.ToString("yyyy-MM-dd")))
                {
                    con1.Close();
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varDate FROM tblaccountbook WHERE  varDate<='" + varDate + "' order by varDate desc LIMIT 1", con1);
                    con1.Open();
                    dr = cmds.ExecuteReader();
                    if (dr.Read())
                    {

                        con2.Close();
                        MySql.Data.MySqlClient.MySqlCommand cmdss = new MySql.Data.MySqlClient.MySqlCommand("SELECT varBalance as amount FROM tblaccountbook WHERE varDate='" + Convert.ToDateTime(dr["varDate"].ToString()).ToString("yyyy-MM-dd") + "'  order by intId desc LIMIT 1", con2);
                        con2.Open();
                        dr1 = cmdss.ExecuteReader();
                        if (dr1.Read())
                        {
                            pAmt = dr1["amount"].ToString();
                        }
                        con2.Close();
                    }
                }
                else
                {
                    con1.Close();
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varDate FROM tblaccountbook order by varDate desc LIMIT 1", con1);
                    con1.Open();
                    dr = cmds.ExecuteReader();
                    if (dr.Read())
                    {

                        con2.Close();
                        MySql.Data.MySqlClient.MySqlCommand cmdss = new MySql.Data.MySqlClient.MySqlCommand("SELECT varBalance as amount FROM tblaccountbook WHERE varDate='" + Convert.ToDateTime(dr["varDate"].ToString()).ToString("yyyy-MM-dd") + "'  order by intId desc LIMIT 1", con2);
                        con2.Open();
                        dr1 = cmdss.ExecuteReader();
                        if (dr1.Read())
                        {
                            pAmt = dr1["amount"].ToString();
                        }
                        con2.Close();
                    }

                    con1.Close();
                }



                con.Open();
                cmd = new MySqlCommand("INSERT INTO tblaccountbook( varDate, varAccountNo, varVoucher, varReason, varPreviousBalance, varEntryType, varAmount, varBalance, varEntryBy ) VALUES ( '" + varDate + "', '" + varAccountNo + "', '" + varVoucher + "', '" + varReason + "', '" + pAmt + "', " + varEntryType + ", '" + varAmount + "', '" + (Convert.ToDouble(pAmt) - Convert.ToDouble(varAmount)).ToString() + "', '" + varEntryBy + "')", con);
                cmd.ExecuteNonQuery();
                con.Close();


                if (Convert.ToDateTime(varDate) < Convert.ToDateTime(DateTime.UtcNow.ToString("yyyy-MM-dd")))
                {
                    string entries = string.Empty;
                    MySql.Data.MySqlClient.MySqlCommand cmdkk = new MySql.Data.MySqlClient.MySqlCommand(" SELECT intId FROM tblaccountbook WHERE  varDate>'" + varDate + "'  ", con);
                    con.Open();
                    dr = cmdkk.ExecuteReader();
                    while (dr.Read())
                    {
                        entries = entries + dr["intId"].ToString() + ";";
                    }
                    con.Close();

                    string[] Kird = entries.Split(';');
                    for (int i = 0; i < Kird.Length - 1; i++)
                    {
                        con2.Open();
                        MySql.Data.MySqlClient.MySqlCommand cmdccj = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblaccountbook SET varBalance= varBalance-" + varAmount + ",varPreviousBalance= varPreviousBalance-" + varAmount + " WHERE  intId=" + Convert.ToInt32(Kird[i].ToString()) + "", con2);
                        cmdccj.ExecuteNonQuery();
                        con2.Close();
                    }
                }
            }

            return 1;
        }
        catch (Exception ex)
        {
            string es = ex.Message;
            return 0;
        }
    }
    public int delete_tblamsaccountbook(string kirdid, string amount, string date,  string entryType)
    {
        try
        {

            string entries = string.Empty;
            string changeEntries = string.Empty;

            con.Close();
            MySql.Data.MySqlClient.MySqlCommand cmdkk = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId FROM tblaccountbook WHERE varDate>='" + date + "' ORDER BY tblaccountbook.varDate ASC,intId ASC", con);
            con.Open();
            dr = cmdkk.ExecuteReader();
            while (dr.Read())
            {
                entries = entries + dr["intId"].ToString() + ";";
            }
            con.Close();
            int ss = 0;
            string[] Kird = entries.Split(';');
            for (int i = 0; i < Kird.Length - 1; i++)
            {
                if (Kird[i].ToString() == kirdid)
                {
                    ss = 1;
                }
                if (ss == 1)
                {
                    if (Kird[i].ToString() == kirdid)
                    { }
                    else
                    {
                        changeEntries = changeEntries + Kird[i].ToString() + ";";
                    }
                }
            }
            Array.Clear(Kird, 0, Kird.Length);
            Kird = changeEntries.Split(';');
            for (int i = 0; i < Kird.Length - 1; i++)
            {
                if (entryType == "1")
                {
                    con2.Open();
                    MySql.Data.MySqlClient.MySqlCommand cmdccj = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblaccountbook SET varBalance= varBalance-" + amount + ",varPreviousBalance=varPreviousBalance-" + amount + " WHERE  intId=" + Convert.ToInt32(Kird[i].ToString()) + "", con2);
                    cmdccj.ExecuteNonQuery();
                    con2.Close();
                }
                else
                {
                    con2.Open();
                    MySql.Data.MySqlClient.MySqlCommand cmdccj = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblaccountbook SET varBalance= varBalance+" + amount + ",varPreviousBalance=varPreviousBalance+" + amount + " WHERE  intId=" + Convert.ToInt32(Kird[i].ToString()) + "", con2);
                    cmdccj.ExecuteNonQuery();
                    con2.Close();
                }
            }
            con.Close();
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("DELETE from tblaccountbook WHERE intId = " + kirdid + "", con);
            cmd.ExecuteNonQuery();
            con.Close();

            return 1;
        }
        catch (Exception s)
        {
            con.Close();
            return 0;
        }
    }
    public string getInitialbalance(string dates)
    {
        try
        {

            string balance = string.Empty;
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT varPreviousBalance as amount FROM tblaccountbook WHERE varDate='" + dates + "' order by intId asc LIMIT 1", con1);
            con1.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                if (dr["amount"].ToString() == "")
                {
                    balance = 0.ToString();
                }
                else
                {
                    balance = dr["amount"].ToString();
                }
            }
            else
            {
                if (Convert.ToDateTime(dates) < Convert.ToDateTime(DateTime.UtcNow.ToString("yyyy-MM-dd")))
                {
                    con1.Close();
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varPreviousBalance as amount FROM tblaccountbook WHERE  varDate<'" + dates + "' order by intId asc LIMIT 1", con1);
                    con1.Open();
                    dr = cmds.ExecuteReader();
                    if (dr.Read())
                    {
                        if (dr["amount"].ToString() == "")
                        {
                            balance = 0.ToString();
                        }
                        else
                        {
                            balance = dr["amount"].ToString();
                        }
                    }
                    else
                    {
                        balance = 0.ToString();
                    }
                    con1.Close();
                }
                else
                {
                    con1.Close();
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varPreviousBalance as amount FROM tblaccountbook WHERE  and varDate<'" + dates + "' order by varDate desc,intId desc LIMIT 1", con1);
                    con1.Open();
                    dr = cmds.ExecuteReader();
                    if (dr.Read())
                    {
                        if (dr["amount"].ToString() == "")
                        {
                            balance = 0.ToString();
                        }
                        else
                        {
                            balance = dr["amount"].ToString();
                        }
                    }
                    else
                    {
                        balance = 0.ToString();
                    }
                    con1.Close();
                }
            }
            con1.Close();
            return balance;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return "0";
        }
    }
    public string getClosingBalance(string dates)
    {
        try
        {

            string balance = string.Empty;
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT varBalance as amount FROM tblaccountbook WHERE varDate='" + dates + "'  order by intId desc LIMIT 1", con1);
            con1.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                if (dr["amount"].ToString() == "")
                {
                    balance = 0.ToString();
                }
                else
                {
                    balance = dr["amount"].ToString();
                }
            }
            else
            {
                if (Convert.ToDateTime(dates) < Convert.ToDateTime(DateTime.UtcNow.ToString("yyyy-MM-dd")))
                {
                    con1.Close();
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varBalance as amount FROM tblaccountbook WHERE  varDate<'" + dates + "' order by intId desc LIMIT 1", con1);
                    con1.Open();
                    dr = cmds.ExecuteReader();
                    if (dr.Read())
                    {
                        if (dr["amount"].ToString() == "")
                        {
                            balance = 0.ToString();
                        }
                        else
                        {
                            balance = dr["amount"].ToString();
                        }
                    }
                    else
                    {
                        balance = 0.ToString();
                    }
                    con1.Close();
                }
                else
                {
                    con1.Close();
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varBalance as amount FROM tblaccountbook WHERE   varDate<'" + dates + "' order by varDate desc,intId desc LIMIT 1", con1);
                    con1.Open();
                    dr = cmds.ExecuteReader();
                    if (dr.Read())
                    {
                        if (dr["amount"].ToString() == "")
                        {
                            balance = 0.ToString();
                        }
                        else
                        {
                            balance = dr["amount"].ToString();
                        }
                    }
                    else
                    {
                        balance = 0.ToString();
                    }
                    con1.Close();
                }
            }
            con1.Close();
            return balance;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return "0";
        }
    }

    public bool check_alreadyAccountName(string acName)
    {

        try
        {
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select intId as newid from tblaccountdetails where varAccountName='" + acName + "'", con);
            con.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                con.Close();
                return true;
            }
            else
            {
                con.Close();
                return false;
            }
        }
        catch (Exception ex)
        {
            con.Close();
            return false;
        }

    }
}