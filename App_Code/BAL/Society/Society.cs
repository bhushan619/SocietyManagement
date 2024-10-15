using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;

/// <summary>
/// Summary description for Society
/// </summary>
public class Society : System.Web.UI.Page
{
    public Society()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    protected String AddSociety(String spSvarRegistrationNo, String spSvarName, String spSvarSAddress, String spSvarSPhone, String spSvarSMobile, String spSvarSEmail, String spSvarCountryId, String spSvarStateId, String spSvarCityId, string spEmpName, string spPassword, string cpname, string cpmobile, string cpphone, string cpemail)
    {
        string[] parameterNames = { "@spSvarRegistrationNo", "@spSvarName", "@spSvarSAddress", "@spSvarSPhone", "@spSvarSMobile", "@spSvarSEmail", "@spSvarCountryId", "@spSvarStateId", "@spSvarCityId", "@spEmpName", "@spPassword", "@cpname", "@cpmobile", "@cpphone", "@cpemail" };
        string[] parameterValues = { spSvarRegistrationNo, spSvarName, spSvarSAddress, spSvarSPhone, spSvarSMobile, spSvarSEmail, spSvarCountryId, spSvarStateId, spSvarCityId, spEmpName, spPassword,  cpname,  cpmobile,  cpphone,  cpemail };
        using (ClsDAL ObjDAL = new ClsDAL())
        {
            return  ObjDAL.ExecuteScalar("sp_insert_Society", parameterNames, parameterValues);
        }
    }
}