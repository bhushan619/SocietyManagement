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
/// Summary description for DatabaseConnectionServices
/// </summary>
public class DatabaseConnectionServices
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

    /*.....................................Connection String.....................*/
    public DatabaseConnectionServices()
    {
        //
        con = new MySql.Data.MySqlClient.MySqlConnection();
        con.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionStringServices"].ConnectionString;
        con1 = new MySql.Data.MySqlClient.MySqlConnection();
        con1.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionStringServices"].ConnectionString;
        con2 = new MySql.Data.MySqlClient.MySqlConnection();
        con2.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionStringServices"].ConnectionString;
        con3 = new MySql.Data.MySqlClient.MySqlConnection();
        con3.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionStringServices"].ConnectionString;
        conprofile = new MySql.Data.MySqlClient.MySqlConnection();
        conprofile.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionStringServices"].ConnectionString;
        //
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

    public string GetServiceNamefromServiceId( int sid)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, intServiceCode, varName, varDescription, varVisitingFee, varRemark, CreatedDate, CreatedBy, varIsActive, varImage, ex2, ex3 FROM tblvendorservices WHERE intServiceCode=" + sid + "", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["varName"].ToString();
            }
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
    public bool check_AlreadyCustomer(string email)
    {
        try
        {
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("select varEmail from tblcustomer where varEmail='" + email + "'", con);
            dr=cmd.ExecuteReader();
            if (dr.Read())
            {
                con.Close();
                cmd.Dispose();
                return true;
            }
            else
            {
                con.Close();
                cmd.Dispose();
                return false;
            }  
        }
        catch (Exception ex)
        {
            string exs = ex.Message;
            con.Close();
            cmd.Dispose();
            return false;
        }
    }
    public int update_tblvendorBySKAdmin(int Id, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblvendor  SET   varIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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

}