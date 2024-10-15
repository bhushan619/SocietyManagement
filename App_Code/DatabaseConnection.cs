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
/// Summary description for DatabaseConnection
/// </summary>
public class DatabaseConnection
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

    public DatabaseConnection()
    {
        //
        con = new MySql.Data.MySqlClient.MySqlConnection();
        con.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        con1 = new MySql.Data.MySqlClient.MySqlConnection();
        con1.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        con2 = new MySql.Data.MySqlClient.MySqlConnection();
        con2.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        con3 = new MySql.Data.MySqlClient.MySqlConnection();
        con3.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        conprofile = new MySql.Data.MySqlClient.MySqlConnection();
        conprofile.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
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

    /*................................Dropdown Masterdata Function.................*/

    public DataTable GetFlatPremisesTypeMasterDataDropdown(int Unitid, string SocietyId)
    {
        MySqlDataAdapter daddteap = new MySqlDataAdapter("SELECT intId,varFlatPremisesName FROM  tblmasterflatpremisestype WHERE intUnitType=" + Unitid + " and  intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet dsdteap = new DataSet();
        daddteap.Fill(dsdteap);
        System.Data.DataTable dtddteap = dsdteap.Tables[0];
        return dtddteap;
    }
    public DataTable GetUnitTypeMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter dasu = new MySqlDataAdapter("SELECT intId,varUnitTypeName FROM tblmasterunittype WHERE  intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet dssu = new DataSet();
        dasu.Fill(dssu);
        System.Data.DataTable dtsu = dssu.Tables[0];
        return dtsu;
    }
    public DataTable GetParkinglevelMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter dasu = new MySqlDataAdapter("SELECT intId,varparkinglevel FROM tblmasterparkinglevel WHERE  intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet dssu = new DataSet();
        dasu.Fill(dssu);
        System.Data.DataTable dtsu = dssu.Tables[0];
        return dtsu;
    }
    public DataTable GetAccountTypeMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter dasua = new MySqlDataAdapter("SELECT intId,varAccountName FROM tblmasteraccounttype WHERE  intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet dssua = new DataSet();
        dasua.Fill(dssua);
        System.Data.DataTable dtsua = dssua.Tables[0];
        return dtsua;
    }
    public DataTable GetAssetFacilityMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter aa = new MySqlDataAdapter("SELECT intId,varAssetFacilityName FROM 	tblmasterassetfacility WHERE  intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet aaj = new DataSet();
        aa.Fill(aaj);
        System.Data.DataTable dtaa = aaj.Tables[0];
        return dtaa;
    }
    public DataTable GetComplaintTypeMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter dac = new MySqlDataAdapter("SELECT intId,varComplaintTypeName FROM tblmastercomplainttype WHERE intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet dsc = new DataSet();
        dac.Fill(dsc);
        System.Data.DataTable dtc = dsc.Tables[0];
        return dtc;
    }
    public DataTable GetDepartmentMasterDataDropdownBySocietyId(string SocietyId)
    {
        MySqlDataAdapter dadd = new MySqlDataAdapter("SELECT intId,varDepartmentName FROM tblmasterdepartment WHERE varSocietyId='" + SocietyId + "' and intIsActive=1", con);
        DataSet dsd = new DataSet();
        dadd.Fill(dsd);
        System.Data.DataTable dtdd = dsd.Tables[0];
        return dtdd;
    }
    public DataTable GetDepartmentMasterDataDropdownBySocietyIdForAddEmployee(string SocietyId)
    {

        MySqlDataAdapter dadd = new MySqlDataAdapter("SELECT intId,varDepartmentName FROM tblmasterdepartment WHERE varSocietyId='" + SocietyId + "' and varDepartmentName!='Property' and intIsActive=1", con);
        DataSet dsd = new DataSet();
        dadd.Fill(dsd);
        System.Data.DataTable dtdd = dsd.Tables[0];
        return dtdd;
    }
    public DataTable GetDocumentTypeMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter daddt = new MySqlDataAdapter("SELECT intId,varDocumentName FROM  tblmasterdocumenttype WHERE intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet dsdt = new DataSet();
        daddt.Fill(dsdt);
        System.Data.DataTable dtddt = dsdt.Tables[0];
        return dtddt;
    }
    public DataTable GetEventTypeMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter daddte = new MySqlDataAdapter("SELECT intId,varEventTypeName FROM  tblmastereventtype WHERE intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet dsdte = new DataSet();
        daddte.Fill(dsdte);
        System.Data.DataTable dtddte = dsdte.Tables[0];
        return dtddte;
    }
    public DataTable GetFlatAdditionalAreaMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter daddtea = new MySqlDataAdapter("SELECT intId,varAreaName FROM  tblmasterflatadditionalarea WHERE intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet dsdtea = new DataSet();
        daddtea.Fill(dsdtea);
        System.Data.DataTable dtddtea = dsdtea.Tables[0];
        return dtddtea;
    }
    public DataTable GetSocietyWingMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter daddtea = new MySqlDataAdapter("SELECT intId,varWingName FROM  tblmastersocietywing WHERE intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet dsdtea = new DataSet();
        daddtea.Fill(dsdtea);
        System.Data.DataTable dtddtea = dsdtea.Tables[0];
        return dtddtea;
    }
    public DataTable GetEmployeeTypeMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter daddtemp = new MySqlDataAdapter("SELECT intId,varEmpTypeName FROM  tblmastermemployeetype WHERE intIsActive=1 and varSocietyId='" + SocietyId + "'", con);
        DataSet dsdtemp = new DataSet();
        daddtemp.Fill(dsdtemp);
        System.Data.DataTable dtemp = dsdtemp.Tables[0];
        return dtemp;
    }
    public DataTable GetNoticeTypeMasterDataDropdown(string SocietyId)
    {
        MySqlDataAdapter daNotice = new MySqlDataAdapter("SELECT intId,varNoticeTypeName FROM  	tblmasternoticetype WHERE intIsActive=1  and varSocietyId='" + SocietyId + "'", con);
        DataSet dsdtNotice = new DataSet();
        daNotice.Fill(dsdtNotice);
        System.Data.DataTable dtNotice = dsdtNotice.Tables[0];
        return dtNotice;
    }

    /*.....................................Checking Function.....................*/

    public string CheckMenuinRoleFeatureMap(string roleid, string featureid)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT * FROM rolefeaturesmap WHERE RoleId=" + roleid + " AND FeatureId=" + featureid + "", con1);
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
    public int check_already_SocietyId(string id)
    {
        try
        {
            int schId = 0;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intSocietyCode FROM tblsocietyinfo WHERE intSocietyCode='" + id + "'", con);
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
    public int check_already_SocietyPropertyId(string id)
    {
        try
        {
            int schId = 0;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT varPropertyId FROM tblproperty WHERE varPropertyId='" + id + "'", con);
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
    public int check_already_PropertyFlatNoId(string fid, string sid)
    {
        try
        {
            int schId = 0;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT varPropertyCode FROM tblproperty WHERE varPropertyCode='" + fid + "' and varSocietyId='" + sid + "'", con);
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
    public int check_already_PropertyExtensionNoId(string fid, string sid)
    {
        try
        {
            int schId = 0;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT varExtensionNo FROM tblproperty WHERE varExtensionNo='" + fid + "' and varSocietyId='" + sid + "'", con);
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
    public int check_already_EmployeeId(string id)
    {
        try
        {
            int schId = 0;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT intEmpCode FROM tblsocietypersonnel WHERE intEmpCode='" + id + "'", con);
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
            cmd = new MySqlCommand("SELECT DISTINCT tblsocietyinfo.intSocietyCode FROM tblsocietyinfo INNER JOIN tblproperty ON tblsocietyinfo.intSocietyCode = tblproperty.varSocietyId INNER JOIN                         tblsocietypersonnel ON tblsocietyinfo.intSocietyCode = tblsocietypersonnel.intSocietyId WHERE tblproperty.varUsername = '" + username + "' OR tblsocietypersonnel.varUsername = '" + username + "'", con);
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

    /*.....................................Get Data Function.....................*/

    public string GetAccountTypeByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,varAccountName FROM tblmasteraccounttype WHERE  varAccountName = '" + type + "' and varSocietyId='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string GetParkinglevelByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,varparkinglevel FROM tblmasterparkinglevel WHERE  varparkinglevel = '" + type + "' and varSocietyId='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string GetHelpLineByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,varHelplineName FROM tblmasterhelpline WHERE varHelplineName = '" + type + "' and varSocietyId='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string GetPropertyOwnerRoleIdBySocietyId(string idm, string rolename)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT        rolesmasterculturemap.RoleId FROM      rolesmasterculturemap  WHERE        varSocietyId = '" + idm + "' and RoleName='" + rolename + "' limit 1", con1);
            dr2 = cmd11.ExecuteReader();
            if (dr2.Read())
            {
                typeid = dr2["RoleId"].ToString();
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
    public string GetPropertyDepartmentIdBySocietyId(string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT        rolesmasterculturemap.RoleId FROM      rolesmasterculturemap INNER JOIN     tblproperty ON rolesmasterculturemap.RoleId = tblproperty.intRoleId WHERE        tblproperty.varSocietyId = '" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["RoleId"].ToString();
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
    public string GetEventTypeByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,varEventTypeName FROM tblmastereventtype WHERE varEventTypeName = '" + type + "' and varSocietyId='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string GetNoticeTypeByName(string type, string idn)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,varNoticeTypeName FROM tblmasternoticetype WHERE varNoticeTypeName = '" + type + "' and varSocietyId='" + idn + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string GetComplaintTypeByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,varComplaintTypeName FROM tblmastercomplainttype WHERE varComplaintTypeName = '" + type + "' and varSocietyId='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string GetUnitTypeByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId,varUnitTypeName FROM tblmasterunittype WHERE varUnitTypeName = '" + type + "' and varSocietyid='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string Get_tblmasterdepartmentByNameAndSocietyID(string type, string SocietyId)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varDepartmentName  FROM tblmasterdepartment WHERE  varDepartmentName  = '" + type + "' and varSocietyId='" + SocietyId + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string Get_tblmasterassetfacilityByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varAssetFacilityName  FROM tblmasterassetfacility WHERE  varAssetFacilityName  = '" + type + "' and varSocietyId='" + idm + "' ", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string Get_tblmasterdocumenttypeByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varDocumentName  FROM tblmasterdocumenttype WHERE  varDocumentName  = '" + type + "' and varSocietyId='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string Get_Employee_NAMe_Dept_Role_By_EmpId_Society_Id(string sid, string eid)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT  tblsocietypersonnel.intId, tblsocietypersonnel.intSocietyId, tblsocietypersonnel.intEmpCode, tblsocietypersonnel.intEmpType,concat( tblsocietypersonnel.varEmpName,' ( ',tblmasterdepartment.varDepartmentName, ' - ',    rolesmasterculturemap.RoleName,' )') as Name,  tblsocietypersonnel.varMbPrimary, tblsocietypersonnel.varMobile, tblsocietypersonnel.intIsActive,  tblsocietypersonnel.varPrimaryEmail FROM            tblsocietypersonnel INNER JOIN  tblmasterdepartment ON tblsocietypersonnel.intDeptId = tblmasterdepartment.intId INNER JOIN  rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId WHERE   (tblsocietypersonnel.intSocietyId = '" + sid + "') AND (tblsocietypersonnel.intEmpCode = '" + eid + "')", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["Name"].ToString();
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
    public string Get_tblmastermemployeetypeByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varEmpTypeName  FROM tblmastermemployeetype WHERE  varEmpTypeName  = '" + type + "' and  varSocietyId  = '" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string Get_tblmasterflatadditionalareaByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varAreaName  FROM tblmasterflatadditionalarea WHERE  varAreaName  = '" + type + "' and varSocietyId='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string Get_tblmastersocietywingByName(string type, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varWingName  FROM tblmastersocietywing WHERE  varWingName  = '" + type + "' and varSocietyId='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string Get_tblmasterflatpremisestypeByName(string type, int unit, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varFlatPremisesName  FROM tblmasterflatpremisestype WHERE  varFlatPremisesName  = '" + type + "' and intUnitType=" + unit + " and varSocietyId='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string Get_tblmasterparkinglevelslotByName(string type, int unit, string idm)
    {
        try
        {
            string typeid = string.Empty;
            con1.Close();
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd11 = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId, varparkinglevelSlot  FROM tblmasterparkinglevelslot WHERE  varparkinglevelSlot  = '" + type + "' and intparkinglevelId=" + unit + " and varSocietyId='" + idm + "'", con1);
            dr1 = cmd11.ExecuteReader();
            if (dr1.Read())
            {
                typeid = dr1["intId"].ToString();
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
    public string get_PropertyOwnerName(string sId, string IDs)
    {
        string name = string.Empty;
        try
        {

            con2.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT CONCAT(tblproperty.varName, ' (', tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, ')') AS name FROM tblproperty INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where tblproperty.varSocietyId='" + sId + "' and tblproperty.varPropertyId='" + IDs + "'", con2);

            dr2 = cmd.ExecuteReader();
            if (dr2.Read())
            {
                name = dr2["name"].ToString();
            }
            con2.Close();
            cmd.Dispose();
            return name;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return name;
        }
    }
    public string get_EmployeeName(string sId, string IDs)
    {
        string name = string.Empty;
        try
        {

            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT concat(tblsocietypersonnel.varEmpName, '-', rolesmasterculturemap.RoleName) AS name FROM tblsocietypersonnel INNER JOIN rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId where tblsocietypersonnel.intSocietyId='" + sId + "' and tblsocietypersonnel.intEmpCode='" + IDs + "'", con);


            dr2 = cmd.ExecuteReader();
            if (dr2.Read())
            {
                name = dr2["name"].ToString();
            }
            con.Close();
            cmd.Dispose();
            return name;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return name;
        }
    }

   
    /*.....................................Insert Masterdata  Function.....................*/

    public int insert_tblmasteraccounttype(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            // int id = max_tblmasteraccounttype();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasteraccounttype ( varSocietyId, varAccountName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmasterparkinglevel(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmasterparkinglevel();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasterparkinglevel ( varSocietyId, varparkinglevel, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmasterhelpline(string societyid, string varHelplineName, string varContactPerson, string varHelpMobile, string varHelpPhone, string varHelpEmail, string varAddress, string varDescription, string varRemark, string varCreatedDate, string varCreatedBy, int intIsActive)
    {
        try
        {
            //int id = max_tblmasterhelpline();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasterhelpline ( varSocietyId, varHelplineName, varContactPerson, varHelpMobile, varHelpPhone, varHelpEmail, varAddress, varDescription, varRemark, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5, ex6) VALUES('" + societyid + "','" + varHelplineName + "','" + varContactPerson + "','" + varHelpMobile + "','" + varHelpPhone + "','" + varHelpEmail + "','" + varAddress + "','" + varDescription + "','" + varRemark + "','" + varCreatedDate + "','" + varCreatedBy + "'," + intIsActive + ",'','','','','','')", con);

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
    public int insert_tblmastereventtype(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmastereventtype();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmastereventtype ( varSocietyId, varEventTypeName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5)  VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmasternoticetype(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmasternoticetype();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasternoticetype ( varSocietyId, varNoticeTypeName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5)  VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmastercomplainttype(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmastercomplainttype();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmastercomplainttype  ( varSocietyId, varComplaintTypeName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5)  VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmasterunittype(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmasterunittype();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasterunittype  ( varSocietyId, varUnitTypeName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblclassified(string varSocietyId, string varPersonalId, int intRole, string varSubject, string varDescription, string varLocation, int intCountry, int intState, int intCity, string varPin, string varContactName, string varMobile, string varEmail, string varEventImage, string varCreatedDate, string varCreatedBy, int intIsActive)
    {
        try
        {
            //int id = max_tblclassified();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblclassified ( varSocietyId, varPersonalId, intRole, varSubject, varDescription, varLocation, intCountry, intState, intCity, varPin, varContactName, varMobile, varEmail, varClassifiedImage, varCreatedDate, varCreatedBy, intIsActive, status, ex2, ex3, ex4, ex5)  VALUES('" + varSocietyId + "','" + varPersonalId + "'," + intRole + ", '" + varSubject + "', '" + varDescription + "', '" + varLocation + "',  " + intCountry + ", " + intState + ", " + intCity + ", '" + varPin + "', '" + varContactName + "', '" + varMobile + "', '" + varEmail + "', '" + varEventImage + "', '" + varCreatedDate + "', '" + varCreatedBy + "', '" + intIsActive + "','Reject','','','','')", con);

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
    public int insert_tblsocietygallary(string varSocietyId, string varPersonalId, int intRole, string varSubject, string varDescription, string varGallaryImage, string varCreatedDate, string varCreatedBy, int intIsActive)
    {
        try
        {
            //int id = max_tblsocietygallary();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblsocietygallary ( varSocietyId, varPersonalId, intRole, varSubject, varDescription, varGallaryImage, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5)  VALUES('" + varSocietyId + "','" + varPersonalId + "'," + intRole + ", '" + varSubject + "', '" + varDescription + "','" + varGallaryImage + "', '" + varCreatedDate + "', '" + varCreatedBy + "', '" + intIsActive + "','','','','','')", con);

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
    public int insert_tblpoll(string varSocietyId, string varPersonalId, int intRole, string varQuestion, string varOptionalText, string varOption1, string varOption2, string varOption3, string varOption4, string varAnswer, string varContactName, string varMobile, string varEmail, string varCreatedDate, string varCreatedBy, int intIsActive)
    {
        try
        {
            //int id = max_tblpoll();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblpoll ( varSocietyId, varPersonalId, intRole, varQuestion, varOptionalText, varOption1, varOption2, varOption3, varOption4, varAnswer, varContactName, varMobile, varEmail, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5)  VALUES('" + varSocietyId + "','" + varPersonalId + "'," + intRole + ", '" + varQuestion + "', '" + varOptionalText + "', '" + varOption1 + "',  '" + varOption2 + "', '" + varOption3 + "', '" + varOption4 + "', '" + varAnswer + "', '" + varContactName + "', '" + varMobile + "', '" + varEmail + "',  '" + varCreatedDate + "', '" + varCreatedBy + "', '" + intIsActive + "','','','','','')", con);

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
    public int insert_tblpollanswer(int pollid, string varPersonalId, string societyId, string varAnswer, string varAnswerDate, string varAnswerTime, string varRemark)
    {
        try
        {
            //int id = max_tblpollanswer();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblpollanswer (intPollId, varSocietyId, varPersonalId, varAnswer, varAnswerDate, varAnswerTime, varRemark, ex1, ex2, ex3, ex4, ex5)  VALUES(" + pollid + ",'" + societyId + "','" + varPersonalId + "','" + varAnswer + "', '" + varAnswerDate + "', '" + varAnswerTime + "', '" + varRemark + "','','','','','')", con);

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

    /*........................Society/Property insert Function........................*/

    public int insert_tblsocietyinfo(string intSocietyCode, string varRegistrationNo, string varName, string varSAddress, string varSPhone, string varSMobile, string varSEmail, string varPassword, int varCountryId, int varStateId, int varCityId, string varContactPerson, string varContactMobile, string varContactPhone, string varContactEmail, int varIsActive)
    {
        try
        {
            //int id = max_tblsocietyinfo();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();                                                                                                                     //  varSPhone, varSMobile, varSEmail, varSFax, varCountryId, varStateId, varCityId, varPin, varConstructedby, varCompany, varCompanyAddress, varContactPerson, varContactMobile, varContactPhone, varContactEmail, varConstuctionYear, varTotalArea, varTotalWings, varIsActive, ex1, ex2, ex3, ex4
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblsocietyinfo ( intSocietyCode, varRegistrationNo, varName, varSAddress, varSPhone, varSMobile, varSEmail, varSFax, varCountryId, varStateId, varCityId, varPin, varConstructedby, varCompany, varCompanyAddress, varContactPerson, varContactMobile, varContactPhone, varContactEmail, varConstuctionYear, varTotalArea, varTotalWings, varIsActive, ex1, ex2, ex3, ex4)  VALUES('" + intSocietyCode + "','" + varRegistrationNo + "','" + varName + "','" + varSAddress + "','" + varSPhone + "','" + varSMobile + "','" + varSEmail + "',''," + varCountryId + "," + varStateId + "," + varCityId + ",'','','','','" + varContactPerson + "','" + varContactMobile + "','" + varContactPhone + "','" + varContactEmail + "','','',''," + varIsActive + ",'','','','')", con);

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
    public int insert_tblsocietypersonnel(string intSocietyCode, string intEmpCode, int intDeptId, int intRole, int intEmpType, string varEmpName, string varEmpPoliceVerify, string varMaritalStatus, string varFatherHusband, string varSpouseName, string varDateOfJoin, string varDOB, string varGender, string varMbPrimary, string varMbOther, string varEmailOther, string varPANNo, string varPFNo, string varESINo, int intCountry, int intState, int intCity, string varPin, string varAddress, string varPermanentAddress, string primaryemail, string VarUsername, string varPassword, string varMobile, string varFBLink, string varGoogleLink, string varTwitterLink, string varImage, int intIsActive, string intCreatedBy, string varCreatedDate, string varProviderName, string varContactPerson, string varContactPersonMbNo, string varContactPersonAddress)
    {
        try
        {
            //int id = max_tblsocietypersonnel();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();                                                                                                                     //  varSPhone, varSMobile, varSEmail, varSFax, varCountryId, varStateId, varCityId, varPin, varConstructedby, varCompany, varCompanyAddress, varContactPerson, varContactMobile, varContactPhone, varContactEmail, varConstuctionYear, varTotalArea, varTotalWings, varIsActive, ex1, ex2, ex3, ex4
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblsocietypersonnel ( intSocietyId, intEmpCode, intDeptId, intRole, intEmpType, varEmpName, varEmpPoliceVerify, varMaritalStatus, varFatherHusband, varSpouseName, varDateOfJoin, varDOB, varGender, varMbPrimary, varMbOther, varEmailOther, varPANNo, varPFNo, varESINo, intCountry, intState, intCity, varPin, varAddress, varPermanentAddress, varPrimaryEmail, varUsername, varPassword, varMobile, varFBLink, varGoogleLink, varTwitterLink, varImage, intIsActive, intCreatedBy, varCreatedDate, varProviderName, varContactPerson, varContactPersonMbNo, varContactPersonAddress, ex1, ex2, ex3, ex4, ex5, ex6)  VALUES('" + intSocietyCode + "','" + intEmpCode + "'," + intDeptId + "," + intRole + "," + intEmpType + ",'" + varEmpName + "','" + varEmpPoliceVerify + "','" + varMaritalStatus + "','" + varFatherHusband + "','" + varSpouseName + "','" + varDateOfJoin + "','" + varDOB + "','" + varGender + "','" + varMbPrimary + "','" + varMbOther + "','" + varEmailOther + "','" + varPANNo + "','" + varPFNo + "','" + varESINo + "'," + intCountry + "," + intState + "," + intCity + ",'" + varPin + "','" + varAddress + "','" + varPermanentAddress + "','" + primaryemail + "','" + VarUsername + "','" + varPassword + "','" + varMobile + "','" + varFBLink + "','" + varGoogleLink + "','" + varTwitterLink + "','" + varImage + "'," + intIsActive + ",'" + intCreatedBy + "','" + varCreatedDate + "','" + varProviderName + "','" + varContactPerson + "','" + varContactPersonMbNo + "','" + varContactPersonAddress + "','','','','','','')", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();

            con.Open();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblinoutstatus( varSocietyId, varPersonnelId, intRoleId, varStatus) VALUES ( '" + intSocietyCode + "', '" + intEmpCode + "', " + intRole + ", 1)", con);
            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();

            //string query = " INSERT INTO rolefeaturesmap (RoleId, FeatureId, IsCreate, IsRead, IsUpdate, IsDelete, varSocietyId, IsActive) VALUES";

            //query += "(" + intRole + ", 5, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 51, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 52, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 6, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 53, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 54, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 7, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 55, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 56, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 8, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 57, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 58, 0, 0, 0, 0, '" + intSocietyCode + "', 1),";
            //query += "(" + intRole + ", 11, 0, 0, 0, 0, '" + intSocietyCode + "', 1)";

            //con.Open();
            //cmd = new MySql.Data.MySqlClient.MySqlCommand(query, con);
            //cmd.ExecuteNonQuery();
            //con.Close();
            //cmd.Dispose();
            return 1;
        }
        catch (Exception s)
        {
            string exp = s.Message;
            con.Close();
            return 0;
        }

    }
    public int insert_tbleventannouncement(string varSocietyId, string varPersonalId, string intRole, string intEventType, string varSubject, string varDescription, string varStartDate, string varEndDate, string varStartTime, string varEndTime, string varLocation, string varEventCapacity, string intCountry, string intState, string intCity, string varPin, string varContactName, string varMobile, string varEmail, string varEventImage, string varCreatedDate, string varCreatedBy, int intIsActive)
    {
        try
        {
            //int id = max_tbleventannouncement();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tbleventannouncement(varSocietyId, varPersonalId, intRole, intEventType, varSubject, varDescription, varStartDate, varEndDate, varStartTime, varEndTime, varLocation, varEventCapacity, intCountry, intState, intCity, varPin, varContactName, varMobile, varEmail, varEventImage, varCreatedDate, varCreatedBy, intIsActive) values ('" + varSocietyId + "', '" + varPersonalId + "', " + intRole + ", " + intEventType + ", '" + varSubject + "', '" + varDescription + "', '" + varStartDate + "', '" + varEndDate + "', '" + varStartTime + "', '" + varEndTime + "', '" + varLocation + "', '" + varEventCapacity + "', " + intCountry + ", " + intState + ", " + intCity + ", " + varPin + ", '" + varContactName + "', '" + varMobile + "', '" + varEmail + "', '" + varEventImage + "', '" + varCreatedDate + "', '" + varCreatedBy + "'," + intIsActive + ")", con);

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
    public int insert_tblproperty(string varPropertyId, string varSocietyId, int intRoleId, int intWingId, int intPremisesUnitId, int intPremisesTypeId, string varPropertyCode, string varName, string varGender, string varExtensionNo, string varAlternateAddress, string varPhoneNo, string varMobile, string varAltMobile, string varEmail, string varAltEmail, string Username, string varPassword, string createddate, string varCreatedBy, int intIsActive)
    {
        try
        {
            //int id = max_tblproperty();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblproperty ( varPropertyId, varSocietyId, intRoleId, intWingId, intPremisesUnitId, intPremisesTypeId, varPropertyCode, varName, varGender, varExtensionNo, varAlternateAddress, varPhoneNo, varMobile, varAlternateMobile, varEmail, varAlternateEmail, varUsername, varPassword, varCreatedDate, varCreatedBy, intIsActive, varImage, varFBLink, varGoogleLink, varTwitterLink, ex2, ex3, ex4, ex5)  VALUES('" + varPropertyId + "','" + varSocietyId + "'," + intRoleId + "," + intWingId + "," + intPremisesUnitId + "," + intPremisesTypeId + ",'" + varPropertyCode + "','" + varName + "','" + varGender + "','" + varExtensionNo + "','" + varAlternateAddress + "','" + varPhoneNo + "','" + varMobile + "','" + varAltMobile + "','" + varEmail + "','" + varAltEmail + "','" + Username + "','" + varPassword + "','" + createddate + "','" + varCreatedBy + "'," + intIsActive + ",'NoProfile.png','http://','http://','http://','','','','')", con);
            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();

            //id = max_tblpropertydetails();
            //id = id + 1;
            con.Open();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblpropertydetails  ( varPropertyId, varDateofPurchase, varArea, varIsRenovated, varCosting, varCurrency, ex1, ex2, ex3, ex4, ex5)  VALUES('" + varPropertyId + "','','','','','','','','','','')", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();


            con.Open();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblinoutstatus( varSocietyId, varPersonnelId, intRoleId, varStatus) VALUES ( '" + varSocietyId + "', '" + varPropertyId + "', " + intRoleId + ", 1)", con);
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
    public int insert_tblpropertyvehical(string varSocietyId, string varPropertyId, string varParkingSlot, string varVehicalType, string varVehicalName, string varVehicalNumber, string varVehicalColor, string varCreatedBy, int intIsActive, string varCreatedDate)
    {
        try
        {
            //int id = max_tblpropertyvehical();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblpropertyvehical (varSocietyId, varPropertyId, varParkingSlot, varVehicalType, varVehicalName, varVehicalNumber, varVehicalColor, varCreatedBy, intIsActive, varCreatedDate, ex1, ex2, ex3, ex4, ex5) VALUES('" + varSocietyId + "','" + varPropertyId + "','" + varParkingSlot + "','" + varVehicalType + "','" + varVehicalName + "','" + varVehicalNumber + "','" + varVehicalColor + "','" + varCreatedBy + "'," + intIsActive + ",'" + varCreatedDate + "','','','','','')", con);

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
    public int insert_tblpropertyfamily(string varPropertyId, string varName, string varGender, string varAge, string varOccupation, string varAlternateAddress, string varMobileNo, string varAlternateMobile, string varEmail, string varAlternateEmail, int intIsActive, string varCreatedDate)
    {
        try
        {
            //int id = max_tblpropertyfamily();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblpropertyfamily ( intPropertyId, varName, varGender, varAge, varOccupation, varAlternateAddress, varMobileNo, varAlternateMobile, varEmail, varAlternateEmail, intIsActive, varCreatedDate, ex1, ex2, ex3, ex4, ex5)  VALUES('" + varPropertyId + "','" + varName + "','" + varGender + "','" + varAge + "','" + varOccupation + "','" + varAlternateAddress + "','" + varMobileNo + "','" + varAlternateMobile + "','" + varEmail + "','" + varAlternateEmail + "'," + intIsActive + ",'" + varCreatedDate + "','','','','','')", con);

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
    public int insert_tblbankdetails(string varSocietyId, string varPersonnelId, int intRoleId, string varAccountHolderName, string varAccountNo, string varBankName, int intAccountType, string varIFSCCode, string varMCIRCode, string varBranchAddress, string varBranchName, string varCreatedDate, string varCreatedBy, int intIsActive)
    {
        try
        {
            //int id = max_tblbankdetails();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblbankdetails (varSocietyId, varPersonnelId, intRoleId, varAccountHolderName, varAccountNo, varBankName, intAccountType, varIFSCCode, varMCIRCode, varBranchAddress, varBranchName, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES('" + varSocietyId + "','" + varPersonnelId + "'," + intRoleId + ",'" + varAccountHolderName + "','" + varAccountNo + "','" + varBankName + "'," + intAccountType + ",'" + varIFSCCode + "','" + varMCIRCode + "','" + varBranchAddress + "','" + varBranchName + "','" + varCreatedDate + "','" + varCreatedBy + "'," + intIsActive + ",'','','','','')", con);

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
    public int insert_tbldocuments(string varSocietyId, string varPersonnelId, int intRoleId, int intDocumentType, string varDescription, string varDocument, string varCreatedDate, string varCreatedBy, int intIsActive, string status)
    {
        try
        {
            //int id = max_tbldocuments();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tbldocuments ( varSocietyId, varPersonnelId, intRoleId, intDocumentType, varDescription, varDocument, varCreatedDate, varCreatedBy, varStatus, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES('" + varSocietyId + "','" + varPersonnelId + "'," + intRoleId + "," + intDocumentType + ",'" + varDescription + "','" + varDocument + "','" + varCreatedDate + "','" + varCreatedBy + "','" + status + "'," + intIsActive + ",'','','','','')", con);

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
    public int insert_tblmasterdepartment(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmasterdepartment();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasterdepartment ( varSocietyId, varDepartmentName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmasterassetfacility(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmasterassetfacility();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasterassetfacility (varSocietyId, varAssetFacilityName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5)  VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmasterdocumenttype(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmasterdocumenttype();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasterdocumenttype (varSocietyId, varDocumentName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmastermemployeetype(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmastermemployeetype();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmastermemployeetype ( varSocietyId, varEmpTypeName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmasterflatadditionalarea(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmasterflatadditionalarea();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasterflatadditionalarea ( varSocietyId, varAreaName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5)  VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmastersocietywing(string societyid, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmastersocietywing();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmastersocietywing  ( varSocietyId, varWingName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5)  VALUES('" + societyid + "','" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmasterflatpremisestype(string societyid, int Unit, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmasterflatpremisestype();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasterflatpremisestype  ( varSocietyId, intUnitType, varFlatPremisesName, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES('" + societyid + "'," + Unit + ",'" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'','','','','')", con);

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
    public int insert_tblmasterparkinglevelslot(string societyid, int Unit, string type, string description, string remark, string createddate, int isactive)
    {
        try
        {
            //int id = max_tblmasterparkinglevelslot();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblmasterparkinglevelslot ( varSocietyId, intparkinglevelId, varparkinglevelSlot, varDescription, varRemark, varCreatedDate, intCreatedBy, intIsActive, intIsAssigned, ex2, ex3, ex4, ex5) VALUES('" + societyid + "'," + Unit + ",'" + type + "','" + description + "','" + remark + "','" + createddate + "',1," + isactive + ",'0','','','','')", con);

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
    public int insert_tblsocietynoticeboard(string varSocietyId, string varPersonalId, int intRole, string varSubject, string varDescription, string varCreatedDate, string varCreatedBy, int intIsActive)
    {
        try
        {
            //int id = max_tblsocietynoticeboard();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblsocietynoticeboard ( varSocietyId, varPersonalId, intRole, varSubject, varDescription, varCreatedDate, varCreatedBy, varStatus, intIsActive, ex1, ex2, ex3, ex4, ex5)  VALUES('" + varSocietyId + "','" + varPersonalId + "'," + intRole + ", '" + varSubject + "', '" + varDescription + "', '" + varCreatedDate + "', '" + varCreatedBy + "','Pending', '" + intIsActive + "','','','','','')", con);

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
    public int insert_tblnotice(string varSocietyId, string varPersonalId, int intRole, int intNoticeType, int assigntype, string varNoticeTitle, string varValueDate, string varDescription, string varReportTo, string varCreatedDate, string varCreatedBy, string name)
    {
        try
        {
            //int id = max_tblnotice();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblnotice (varSocietyId, varPersonalId, intRole, intNoticeType, varAssignType, varNoticeTitle, varValueDate, varDescription, varReportTo, varName, varImage, varCreatedDate, varCreatedBy, intIsActive, ex1, ex2, ex3, ex4, ex5, ex6) VALUES('" + varSocietyId + "','" + varPersonalId + "'," + intRole + "," + intNoticeType + "," + assigntype + ", '" + varNoticeTitle + "','" + varValueDate + "', '" + varDescription + "', '" + varReportTo + "','" + name + "','', '" + varCreatedDate + "', '" + varCreatedBy + "',1,'','','','','','')", con);

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
    public int insert_tblrequest(string varSocietyId, string varPersonalId, int intRole, string intAssignToRole, string varSubject, string varDescription, string varCreatedDate, int intIsActive)
    {
        try
        {
            //int id = max_tblrequest();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblrequest (varSocietyId, varPersonneId, intPersonelRole, varAssignToRoleId, varDate, varTime, varSubject, varDescription, varStatus, varRemark, intIsActive, ex1, ex2, ex3, ex4, ex5)  VALUES('" + varSocietyId + "','" + varPersonalId + "'," + intRole + "," + intAssignToRole + ",'" + DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd") + "', '" + DateTime.UtcNow.AddMinutes(330).ToString("hh:mm:ss") + "','" + varSubject + "', '" + varDescription + "', 'Pending', '', '" + intIsActive + "','','','','','')", con);

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
    public int insert_tblcompliants(string varSocietyId, string varPersonalId, int intRole, string intAssignToRole, string varSubject, string varDescription, string varCreatedDate, int intIsActive)
    {
        try
        {
            //int id = max_tblcompliants();
            //id = id + 1;
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblcompliants  ( varSocietyId, varPersonneId, intPersonelRole, varAssignToRoleId, varDate, varTime, varSubject, varDescription, varStatus, varRemark, varProceedDate, intIsActive, ex1, ex2, ex3, ex4, ex5) VALUES('" + varSocietyId + "','" + varPersonalId + "'," + intRole + "," + intAssignToRole + ",'" + DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd") + "', '" + DateTime.UtcNow.AddMinutes(330).ToString("hh:mm:ss") + "','" + varSubject + "', '" + varDescription + "', 'New', '', '','" + intIsActive + "','','','','','')", con);

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

    /*.....................................Update Function.....................*/

    public int update_tblmasteraccounttype(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasteraccounttype SET  varAccountName ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmasterparkinglevel(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasterparkinglevel SET  varparkinglevel	 ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblproperty(string Id, string varName, string varGender, string varExtensionNo, string phnone, string mobile, string email, string altmobile, string altemail, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblproperty SET  varName ='" + varName + "' ,varGender='" + varGender + "',varExtensionNo='" + varExtensionNo + "', varPhoneNo ='" + phnone + "', varMobile ='" + mobile + "', varEmail ='" + email + "', varAlternateMobile ='" + altmobile + "', varAlternateEmail ='" + altemail + "', intIsActive =" + isactive + " WHERE varUsername ='" + Id + "'", con);

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
    public int update_tblproperty_BypropertyOwner(string Id, string varName, string varGender, string varAlternateAddress, string phnone, string mobile, string email, string altmobile, string altemail, string varUsername, string varImage, string varFBLink, string varGoogleLink, string varTwitterLink)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            //varUsername, string  varPassword, string  varImage,  string  varFBLink,  string  varGoogleLink, string  varTwitterLink)
            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblproperty SET  varName ='" + varName + "' ,varGender='" + varGender + "',varAlternateAddress='" + varAlternateAddress + "', varPhoneNo ='" + phnone + "', varMobile ='" + mobile + "', varEmail ='" + email + "', varAlternateMobile ='" + altmobile + "', varAlternateEmail ='" + altemail + "', varUsername ='" + varUsername + "', varImage ='" + varImage + "', varFBLink ='" + varFBLink + "', varGoogleLink ='" + varGoogleLink + "', varTwitterLink ='" + varTwitterLink + "' WHERE varPropertyId ='" + Id + "'", con);

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
    public int update_tblpropertyvehical(string Id, string varVehicalType, string varVehicalName, string varVehicalNumber, string varVehicalColor, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblpropertyvehical SET  varVehicalType ='" + varVehicalType + "',varVehicalName='" + varVehicalName + "', varVehicalNumber ='" + varVehicalNumber + "', varVehicalColor ='" + varVehicalColor + "', intIsActive =" + intIsActive + " WHERE intId ='" + Id + "'", con);

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
    public int update_tblpropertydetails(string Id, string varDateofPurchase, string varArea, string varIsRenovated, string varCosting, string varCurrency)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblpropertydetails SET  varDateofPurchase ='" + varDateofPurchase + "',varArea='" + varArea + "', varIsRenovated ='" + varIsRenovated + "', varCosting ='" + varCosting + "', varCurrency ='" + varCurrency + "' WHERE varPropertyId ='" + Id + "'", con);

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
    public int update_tblpropertyfamily(int Id, string varName, string varGender, string varAge, string varOccupation, string varAlternateAddress, string varMobileNo, string varAlternateMobile, string varEmail, string varAlternateEmail, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblpropertyfamily SET  varName ='" + varName + "', varGender ='" + varGender + "', varAge ='" + varAge + "', varOccupation ='" + varOccupation + "', varAlternateAddress ='" + varAlternateAddress + "', varMobileNo ='" + varMobileNo + "', varEmail ='" + varEmail + "', varAlternateEmail ='" + varAlternateEmail + "', intIsActive =" + intIsActive + " WHERE intId ='" + Id + "'", con);

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
    public int update_tblbankdetails(int Id, string varAccountHolderName, string varAccountNo, string varBankName, int intAccountType, string varIFSCCode, string varMCIRCode, string varBranchAddress, string varBranchName, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblbankdetails  SET varBankName='"+ varBankName + "' , varAccountHolderName ='" + varAccountHolderName + "', varAccountNo ='" + varAccountNo + "', varIFSCCode ='" + varIFSCCode + "', varMCIRCode ='" + varMCIRCode + "', varBranchAddress ='" + varBranchAddress + "', varBranchName ='" + varBranchName + "', intAccountType =" + intAccountType + ", intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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
    public int update_tbleventannouncement(int Id, string varSubject, string varDescription, string varStartDate, string varEndDate, string varStartTime, string varEndTime, string varLocation, string varEventCapacity, int intCountry, int intState, int intCity, string varPin, string varContactName, string varMobile, string varEmail, string varEventImage, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tbleventannouncement  SET  varSubject ='" + varSubject + "', varDescription ='" + varDescription + "', varStartDate = '" + varStartDate + "', varEndDate = '" + varEndDate + "', varStartTime = '" + varStartTime + "',  varLocation = '" + varLocation + "', varEventCapacity = '" + varEventCapacity + "', intCountry = " + intCountry + ", intState = " + intState + ", intCity = " + intCity + ", varPin = '" + varPin + "', varEventCapacity = '" + varEventCapacity + "',  varMobile = '" + varMobile + "', varEmail = '" + varEmail + "', varEventImage = '" + varEventImage + "', intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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
    public int update_tblclassified(int Id, string varSubject, string varDescription, string varLocation, int intCountry, int intState, int intCity, string varPin, string varContactName, string varMobile, string varEmail, string varClassifiedImage, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblclassified  SET  varSubject ='" + varSubject + "', varDescription ='" + varDescription + "',  varLocation = '" + varLocation + "', intCountry = " + intCountry + ", intState = " + intState + ", intCity = " + intCity + ", varPin = '" + varPin + "',  varMobile = '" + varMobile + "', varEmail = '" + varEmail + "', varClassifiedImage = '" + varClassifiedImage + "', intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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
 
    public int update_tblsocietygallary(int Id, string varSubject, string varDescription, string varGallaryImage, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblsocietygallary  SET  varSubject ='" + varSubject + "', varDescription ='" + varDescription + "', varGallaryImage = '" + varGallaryImage + "', intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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
    public int update_tblpoll(int Id, string varQuestion, string varOptionalText, string varOption1, string varOption2, string varOption3, string varOption4, string varAnswer, string varContactName, string varMobile, string varEmail, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblpoll  SET  varQuestion ='" + varQuestion + "', varOptionalText ='" + varOptionalText + "',  varOption1 = '" + varOption1 + "', varOption2 = '" + varOption2 + "',varOption3 = '" + varOption3 + "',varOption4 = '" + varOption4 + "',varAnswer = '" + varAnswer + "',varContactName = '" + varContactName + "',  varMobile = '" + varMobile + "', varEmail = '" + varEmail + "',  intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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
    public int update_tbldocuments(int Id, int intDocumentType, string varDescription, string varDocument, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tbldocuments  SET  intDocumentType =" + intDocumentType + ", varDescription ='" + varDescription + "', varDocument ='" + varDocument + "', intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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
    public int update_tblnotice(int Id, int intNoticeType, int varAssignType, string varNoticeTitle, string varValueDate, string varDescription)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblnotice  SET  intNoticeType =" + intNoticeType + ", varAssignType =" + varAssignType + ", varNoticeTitle ='" + varNoticeTitle + "', varValueDate ='" + varValueDate + "', varDescription ='" + varDescription + "' WHERE intId =" + Id + "", con);

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
    public int update_tblmasterhelpline(int id, string varHelplineName, string varContactPerson, string varHelpMobile, string varHelpPhone, string varHelpEmail, string varAddress, string varDescription, string varRemark, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasterhelpline SET varHelplineName='" + varHelplineName + "',varContactPerson='" + varContactPerson + "',varHelpMobile='" + varHelpMobile + "',varHelpPhone='" + varHelpPhone + "' ,varHelpEmail='" + varHelpEmail + "',varAddress='" + varAddress + "',varDescription='" + varDescription + "',varRemark='" + varRemark + "',intIsActive=" + intIsActive + "  WHERE intId =" + id + "", con);

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
    public int update_tblmastereventtype(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmastereventtype SET  varEventTypeName ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmasternoticetype(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasternoticetype SET  varNoticeTypeName ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmastercomplainttype(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmastercomplainttype SET  varComplaintTypeName ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmasterunittype(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasterunittype SET  varUnitTypeName ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmasterdepartment(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasterdepartment SET   varDepartmentName  ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblassignnotifications(string sid, string memid, int roleid)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblassignnotifications SET   varPersonalId  ='" + memid + "', intRoleId =" + roleid + " WHERE varSocietyId='" + sid + "'", con);

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
    public int update_tblsocietypersonnel(int id, int intDeptId, int intRole, int intEmpType, string varEmpName, string varEmpPoliceVerify, string varMaritalStatus, string varFatherHusband, string varSpouseName, string varDateOfJoin, string varDOB, string varGender, string varMbPrimary, string varMbOther, string varEmailOther, string varPANNo, string varPFNo, string varESINo, int intCountry, int intState, int intCity, string varPin, string varAddress, string varPermanentAddress, string VarUsername, string varImage, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblsocietypersonnel SET intEmpType=" + intEmpType + ",   intDeptId = " + intDeptId + ", intRole = " + intRole + ", varEmpName = '" + varEmpName + "', varEmpPoliceVerify = '" + varEmpPoliceVerify + "', varMaritalStatus = '" + varMaritalStatus + "', varFatherHusband = '" + varFatherHusband + "',  varSpouseName = '" + varSpouseName + "', varDateOfJoin = '" + varDateOfJoin + "', varDOB = '" + varDOB + "', varDOB = '" + varDOB + "', varGender = '" + varGender + "', varMbPrimary = '" + varMbPrimary + "',  varMbOther = '" + varMbOther + "', varEmailOther = '" + varEmailOther + "', varPANNo = '" + varPANNo + "', varPFNo = '" + varPFNo + "', varESINo = '" + varESINo + "', intCountry = " + intCountry + ",  intState = " + intState + ", intCity = " + intCity + ", varPin = '" + varPin + "', varAddress = '" + varAddress + "', varPermanentAddress = '" + varPermanentAddress + "', varPrimaryEmail = '" + VarUsername + "',  varImage = '" + varImage + "', intIsActive = " + intIsActive + "    WHERE intId = " + id + "", con);

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
    public int update_tblsocietypersonnel_ByPErsonalHimself(string pid, string varEmpName, string varEmpPoliceVerify, string varMaritalStatus, string varFatherHusband, string varSpouseName, string varDOB, string varGender, string varMbPrimary, string varMbOther, string varEmailOther, string varPANNo, string varPFNo, string varESINo, int intCountry, int intState, int intCity, string varPin, string varAddress, string varPermanentAddress, string VarUsername, string varPrimaryEmail, string varImage, string varFBLink, string varGoogleLink, string varTwitterLink)
    {
        try
        {
            con.Close();
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblsocietypersonnel SET  varEmpName = '" + varEmpName + "', varEmpPoliceVerify = '" + varEmpPoliceVerify + "', varMaritalStatus = '" + varMaritalStatus + "', varFatherHusband = '" + varFatherHusband + "',  varSpouseName = '" + varSpouseName + "', varDOB = '" + varDOB + "',  varGender = '" + varGender + "', varMbPrimary = '" + varMbPrimary + "',  varMbOther = '" + varMbOther + "', varEmailOther = '" + varEmailOther + "', varPANNo = '" + varPANNo + "', varPFNo = '" + varPFNo + "', varESINo = '" + varESINo + "', intCountry = " + intCountry + ",  intState = " + intState + ", intCity = " + intCity + ", varPin = '" + varPin + "', varAddress = '" + varAddress + "', varPermanentAddress = '" + varPermanentAddress + "', varPrimaryEmail = '" + varPrimaryEmail + "', 	varUsername = '" + VarUsername + "',  varImage = '" + varImage + "',  varFBLink = '" + varFBLink + "',  varGoogleLink = '" + varGoogleLink + "',  varTwitterLink = '" + varTwitterLink + "'   WHERE intEmpCode = '" + pid + "'", con);

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
    public int update_feature(int id, Int64 sParentId, string sPageName, int issubmenu, string sFeatureName, Int16 sIsActive)
    {
        try
        {
            con.Close();
            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE featuresmaster SET ParentId=" + sParentId + ",varFeatureName='" + sFeatureName + "',PageName='" + sPageName + "',isSubMenu=" + issubmenu + ",IsActive=" + sIsActive + " WHERE FeatureId =" + id + "", con);

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
    public int update_Role(int id, Int64 deptId, string sroleName, Int16 sIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE rolesmaster SET DeptId=" + deptId + ",IsActive=" + sIsActive + " WHERE RoleId=" + id + "", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();

            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmdz = new MySql.Data.MySqlClient.MySqlCommand();

            cmdz = new MySql.Data.MySqlClient.MySqlCommand("UPDATE rolesmasterculturemap SET RoleName='" + sroleName + "' WHERE RoleId   =" + id + "", con);

            cmdz.ExecuteNonQuery();
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
    public int update_Title(int id, string titleName, Int16 sIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE titlemaster SET IsActive=" + sIsActive + " WHERE TitleId=" + id + "", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();

            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmdz = new MySql.Data.MySqlClient.MySqlCommand();

            cmdz = new MySql.Data.MySqlClient.MySqlCommand("UPDATE titlemasterculturemap SET TitleName='" + titleName + "' WHERE TitleId  =" + id + "", con);

            cmdz.ExecuteNonQuery();
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
    public int update_tblmasterassetfacility(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasterassetfacility SET   varAssetFacilityName  ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmasterdocumenttype(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasterdocumenttype SET   varDocumentName  ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmastermemployeetype(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmastermemployeetype SET   varEmpTypeName  ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmasterflatadditionalarea(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE  tblmasterflatadditionalarea SET   varAreaName  ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmastersocietywing(int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE  tblmastersocietywing SET   varWingName	  ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmasterflatpremisestype(int Unit, int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasterflatpremisestype SET intUnitType=" + Unit + ",  varFlatPremisesName  ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmasterparkinglevelslot(int Unit, int TypeId, string type, string description, string remark, int isactive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasterparkinglevelslot SET intparkinglevelId=" + Unit + ",  varparkinglevelSlot  ='" + type + "', varDescription ='" + description + "', varRemark ='" + remark + "', intIsActive =" + isactive + " WHERE intId =" + TypeId + "", con);

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
    public int update_tblmasterparkinglevelslot(int Assigned, int ID)
    {
        con.Close();
        con.Open();

        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

        cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblmasterparkinglevelslot SET intIsAssigned=" + Assigned + " WHERE intId =" + ID + "", con);

        cmd.ExecuteNonQuery();
        con.Close();
        cmd.Dispose();
        return 1;
    }
    public int update_tblsocietynoticeboard(int Id, string varSubject, string varDescription, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblsocietynoticeboard  SET  varSubject ='" + varSubject + "', varDescription ='" + varDescription + "', intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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
    public int update_tblrequest(int Id, string varSubject, string varDescription, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblrequest  SET  varSubject ='" + varSubject + "', varDescription ='" + varDescription + "', intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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
    public int update_tblrequestStatus(Int64 Id, string status)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            if (status == "Approved")
            {
                cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblrequest  SET  varStatus ='" + status + "',intIsActive=1 WHERE intId =" + Id + "", con);
            }
            else
            {
                cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblrequest  SET  varStatus ='" + status + "',intIsActive=0 WHERE intId =" + Id + "", con);
            }
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
    public int update_tblsocietynoticeboard(Int64 Id, string status)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            if (status == "Approved")
            {
                cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblsocietynoticeboard  SET  varStatus ='" + status + "',intIsActive=1 WHERE intId =" + Id + "", con);
            }
            else
            {
                cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblsocietynoticeboard  SET  varStatus ='" + status + "',intIsActive=0 WHERE intId =" + Id + "", con);
            }
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
    public int update_tbldocuments(Int64 Id, string status)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            if (status == "Approved")
            {
                cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tbldocuments  SET  varStatus ='" + status + "',intIsActive=1 WHERE intId =" + Id + "", con);
            }
            else
            {
                cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tbldocuments  SET  varStatus ='" + status + "',intIsActive=0 WHERE intId =" + Id + "", con);
            }
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
    public int update_tblcompliants(int Id, string varSubject, string varDescription, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblcompliants  SET  varSubject ='" + varSubject + "', varDescription ='" + varDescription + "', intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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
    public int update_tblcompliantsStatus(Int64 Id, string status)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            if (status == "Processed")
            {
                cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblcompliants  SET  varStatus ='" + status + "', varProceedDate='" + DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd") + "', intIsActive=1 WHERE intId =" + Id + "", con);
            }

            else if (status == "Resolved")
            {
                cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblcompliants  SET  varStatus ='" + status + "', varProceedDate='" + DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd") + "', intIsActive=1 WHERE intId =" + Id + "", con);
            }
            else
            {
                cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblcompliants  SET  varStatus ='" + status + "',	varProceedDate='" + DateTime.UtcNow.AddMinutes(330).ToString("yyyy-MM-dd") + "', intIsActive=0 WHERE intId =" + Id + "", con);
            }
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

    //////////////////// Notifications ////////////////

    public string select_tblassignnotifications(string socId)
    {
        string chk = string.Empty;
        try
        {
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select concat(varPersonalId,'-',intRoleId) as newid from  tblassignnotifications where varSocietyId='" + socId + "'", con2);
            con2.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                chk = dr["newid"].ToString();
            }
            con2.Close();
            return chk;
        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            con2.Close();
            return chk;
        }
    }
    public string insert_tblnotifications(string societyId, string type, string fromid, string fromRoleId, string toId, string toRole, string text, string link, string cache, string status, string remark)
    {
        try
        {
            //int id = max_tblnotifications();
            //id = id + 1;
            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblnotifications ( varSocietyId, varNotType, intNotFromId, varNotFromRoleId, intNotToId, varNotToRoleId, varNotText, varLink, varCache, varStatus, varRemark, varDateTime, ex1, ex2) VALUES('" + societyId + "','" + type + "','" + fromid + "','" + fromRoleId + "','" + toId + "','" + toRole + "','" + text + "','" + link + "','" + cache + "','" + status + "','" + remark + "','" + DateTime.ParseExact(DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy"), "dd-MM-yyyy", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "','','')", con1);
            cmd1.ExecuteNonQuery();
            con1.Close();
            cmd1.Dispose();
            return 1.ToString(); ;
        }
        catch (Exception ex)
        {
            con1.Close();
            string exp = ex.Message;
            return ex.Message;
        }
    }
    public void deleteAll_Notification(string memId)
    {
        try
        {

            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("delete from tblnotifications where intNotToId='" + memId + "'", con1);
            cmd1.ExecuteNonQuery();
            con1.Close();
            cmd1.Dispose();

        }
        catch (Exception ex)
        {
            string exp = ex.Message;
            con1.Close();
        }
    }
    public void readAll_Notification(string memId)
    {
        try
        {

            con1.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd1 = new MySql.Data.MySqlClient.MySqlCommand("update tblnotifications set varStatus='Read' where intNotToId='" + memId + "'", con1);
            cmd1.ExecuteNonQuery();
            con1.Close();
            cmd1.Dispose();

        }
        catch (Exception ex)
        {
            con1.Close();
            cmd1.Dispose();
            string exp = ex.Message;
        }
    }
    public int update_tblclassifiedBySKAdmin(int Id, string status, int intIsActive)
    {
        try
        {
            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblclassified  SET status='" + status + "',  intIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

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

    public bool insert_tblaccountdetails(string socId, string name, string desc)
    {
        try
        {
            string acno = CreateRandomPassword(4);

            con.Open();
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
            cmd = new MySql.Data.MySqlClient.MySqlCommand("INSERT INTO tblaccountdetails (varSocietyId, varAccountNo, varAccountName, varDescription) VALUES ('" + socId + "', '" + acno + "', '" + name + "', '" + desc + "')", con);

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
    public int insert_tblaccountbook(string varSocietyId, string varDate, string varAccountNo, string varVoucher, string varReason, string varPreviousBalance, string varEntryType, string varAmount, string varBalance, string varEntryBy)
    {
        try
        {

            if (varEntryType == "1")
            {
                con.Open();
                cmd = new MySqlCommand("INSERT INTO tblaccountbook(varSocietyId, varDate, varAccountNo, varVoucher, varReason, varPreviousBalance, varEntryType, varAmount, varBalance, varEntryBy ) VALUES ('" + varSocietyId + "', '" + varDate + "', '" + varAccountNo + "', '" + varVoucher + "', '" + varReason + "', '" + varPreviousBalance + "', " + varEntryType + ", '" + varAmount + "', '" + varBalance + "', '" + varEntryBy + "')", con);
                cmd.ExecuteNonQuery();
                long x = cmd.LastInsertedId;

                con.Close();

                if (Convert.ToDateTime(varDate) < Convert.ToDateTime(DateTime.UtcNow.ToString("yyyy-MM-dd")))
                {
                    string entries = string.Empty;
                    MySql.Data.MySqlClient.MySqlCommand cmdkk = new MySql.Data.MySqlClient.MySqlCommand(" SELECT intId FROM tblaccountbook WHERE  varDate>'" + varDate + "'  and  varSocietyId='" + varSocietyId + "' and intId!= " + x + " ORDER by varDate ASC, intId ASC", con);
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
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varDate FROM tblaccountbook WHERE varSocietyId='" + varSocietyId + "' and varDate<='" + varDate + "' order by varDate desc LIMIT 1", con1);
                    con1.Open();
                    dr = cmds.ExecuteReader();
                    if (dr.Read())
                    {

                        con2.Close();
                        MySql.Data.MySqlClient.MySqlCommand cmdss = new MySql.Data.MySqlClient.MySqlCommand("SELECT varBalance as amount FROM tblaccountbook WHERE varDate='" + Convert.ToDateTime(dr["varDate"].ToString()).ToString("yyyy-MM-dd") + "' and   varSocietyId='" + varSocietyId + "' order by intId desc LIMIT 1", con2);
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
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varDate FROM tblaccountbook WHERE varSocietyId='" + varSocietyId + "' order by varDate desc LIMIT 1", con1);
                    con1.Open();
                    dr = cmds.ExecuteReader();
                    if (dr.Read())
                    {

                        con2.Close();
                        MySql.Data.MySqlClient.MySqlCommand cmdss = new MySql.Data.MySqlClient.MySqlCommand("SELECT varBalance as amount FROM tblaccountbook WHERE varDate='" + Convert.ToDateTime(dr["varDate"].ToString()).ToString("yyyy-MM-dd") + "' and   varSocietyId='" + varSocietyId + "' order by intId desc LIMIT 1", con2);
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
                cmd = new MySqlCommand("INSERT INTO tblaccountbook(varSocietyId, varDate, varAccountNo, varVoucher, varReason, varPreviousBalance, varEntryType, varAmount, varBalance, varEntryBy ) VALUES ('" + varSocietyId + "', '" + varDate + "', '" + varAccountNo + "', '" + varVoucher + "', '" + varReason + "', '" + pAmt + "', " + varEntryType + ", '" + varAmount + "', '" + (Convert.ToDouble(pAmt) - Convert.ToDouble(varAmount)).ToString() + "', '" + varEntryBy + "')", con);
                cmd.ExecuteNonQuery();
                con.Close();


                if (Convert.ToDateTime(varDate) < Convert.ToDateTime(DateTime.UtcNow.ToString("yyyy-MM-dd")))
                {
                    string entries = string.Empty;
                    MySql.Data.MySqlClient.MySqlCommand cmdkk = new MySql.Data.MySqlClient.MySqlCommand(" SELECT intId FROM tblaccountbook WHERE  varDate>'" + varDate + "'  and  varSocietyId='" + varSocietyId + "'", con);
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
    public int delete_tblamsaccountbook(string kirdid, string amount, string date, string socId, string entryType)
    {
        try
        {

            string entries = string.Empty;
            string changeEntries = string.Empty;

            con.Close();
            MySql.Data.MySqlClient.MySqlCommand cmdkk = new MySql.Data.MySqlClient.MySqlCommand("SELECT intId FROM tblaccountbook WHERE varDate>='" + date + "' and  varSocietyId='" + socId + "' ORDER BY tblaccountbook.varDate ASC,intId ASC", con);
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
    public string getInitialbalance(string dates, string socId)
    {
        try
        {

            string balance = string.Empty;
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT varPreviousBalance as amount FROM tblaccountbook WHERE varDate='" + dates + "' and varSocietyId='" + socId + "' order by intId asc LIMIT 1", con1);
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
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varPreviousBalance as amount FROM tblaccountbook WHERE varSocietyId='" + socId + "' and varDate<'" + dates + "' order by intId asc LIMIT 1", con1);
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
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varPreviousBalance as amount FROM tblaccountbook WHERE  varSocietyId='" + socId + "' and varDate<'" + dates + "' order by varDate desc,intId desc LIMIT 1", con1);
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
    public string getClosingBalance(string dates, string socId)
    {
        try
        {

            string balance = string.Empty;
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("SELECT varBalance as amount FROM tblaccountbook WHERE varDate='" + dates + "' and varSocietyId='" + socId + "' order by intId desc LIMIT 1", con1);
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
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varBalance as amount FROM tblaccountbook WHERE varSocietyId='" + socId + "' and varDate<'" + dates + "' order by intId desc LIMIT 1", con1);
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
                    MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand("SELECT varBalance as amount FROM tblaccountbook WHERE  varSocietyId='" + socId + "' and varDate<'" + dates + "' order by varDate desc,intId desc LIMIT 1", con1);
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

    public bool check_alreadyAccountName(string acName,string societyId)
    {
        
        try
        {
            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select intId as newid from tblaccountdetails where varAccountName='" + acName + "' and varSocietyId='" + societyId + "'", con);
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
    //......................... skadmin functions

    public void update_tblsocietypersonnelbySKadmin(string Id,string sid, string intIsActive)
    {
        try
        {

            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmds = new MySql.Data.MySqlClient.MySqlCommand();

            cmds = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblsocietyinfo  SET  varIsActive =" + intIsActive + " WHERE intId =" + Id + "", con);

            cmds.ExecuteNonQuery();
            con.Close();
            cmds.Dispose();

            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();

            cmd = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblsocietypersonnel  SET  intIsActive =" + intIsActive + " WHERE intSocietyId ='" + sid + "'", con);

            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();

            con.Close();
            con.Open();

            MySql.Data.MySqlClient.MySqlCommand cmdp = new MySql.Data.MySqlClient.MySqlCommand();

            cmdp = new MySql.Data.MySqlClient.MySqlCommand("UPDATE tblproperty  SET  intIsActive =" + intIsActive + " WHERE varSocietyId ='" + sid + "'", con);

            cmdp.ExecuteNonQuery();
            con.Close();
            cmdp.Dispose();

         

        }
        catch (Exception s)
        {

            string strr = s.Message;
            con.Close();

        }
    }








































    /*.....................................Max Function.....................*/

    //public int max_tblsocietypersonnel()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblsocietypersonnel", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tbleventannouncement()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tbleventannouncement", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblclassified()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblclassified", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;

    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblsocietygallary()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblsocietygallary", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblpoll()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblpoll", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblpollanswer()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblpollanswer", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasteraccounttype()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasteraccounttype", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasterparkinglevel()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasterparkinglevel", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblproperty()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblproperty", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;

    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblpropertydetails()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblpropertydetails", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;

    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblpropertyvehical()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblpropertyvehical", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;

    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblpropertyfamily()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblpropertyfamily", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tbldocuments()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tbldocuments", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblbankdetails()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblbankdetails", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;

    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasterhelpline()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasterhelpline", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmastereventtype()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmastereventtype", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasternoticetype()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasternoticetype", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmastercomplainttype()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmastercomplainttype", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;

    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblsocietyinfo()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblsocietyinfo", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;

    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasterunittype()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasterunittype", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasterdepartment()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasterdepartment", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasterassetfacility()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasterassetfacility", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;

    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasterdocumenttype()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasterdocumenttype", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmastermemployeetype()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmastermemployeetype", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasterflatadditionalarea()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasterflatadditionalarea", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmastersocietywing()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmastersocietywing", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasterflatpremisestype()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasterflatpremisestype", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblmasterparkinglevelslot()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblmasterparkinglevelslot", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblsocietynoticeboard()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblsocietynoticeboard", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblnotice()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblnotice", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblrequest()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblrequest", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}
    //public int max_tblnotifications()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from  tblnotifications", con2);
    //        con2.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //        con2.Close();
    //        return chk;
    //    }
    //    catch (Exception ex)
    //    {
    //        string exp = ex.Message;
    //        con2.Close();
    //        return chk;
    //    }
    //}
    //public int max_tblcompliants()
    //{
    //    int chk = 0;
    //    try
    //    {
    //        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand("select max(intId) as newid from tblcompliants", con);
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            chk = Convert.ToInt32(dr["newid"].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //        string exp = ex.Message;
    //    }
    //    con.Close();
    //    return chk;
    //}


}
