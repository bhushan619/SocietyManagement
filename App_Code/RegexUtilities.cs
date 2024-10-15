using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Globalization;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for RegexUtilities
/// </summary>
public class RegexUtilities : System.Web.UI.Page, IDisposable
{
    public RegexUtilities()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    bool invalid = false;
    /// <summary>
    /// This function is used to validate the email passed to it with regex.
    /// </summary>
    /// <param name="strIn"></param>
    /// <returns></returns>
    public bool IsValidEmail(string strIn)
    {
        invalid = false;
        if (String.IsNullOrEmpty(strIn))
            return false;

        // Use IdnMapping class to convert Unicode domain names.
        strIn = Regex.Replace(strIn, @"(@)(.+)$", this.DomainMapper);
        if (invalid)
            return false;

        // Return true if strIn is in valid e-mail format.
        return Regex.IsMatch(strIn,
               @"^(?("")(""[^""]+?""@)|(([0-9a-z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-z])@))" +
               @"(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-z][-\w]*[0-9a-z]*\.)+[a-z0-9]{2,17}))$",
               RegexOptions.IgnoreCase);
    }

    private string DomainMapper(Match match)
    {
        // IdnMapping class with default property values.
        IdnMapping idn = new IdnMapping();

        string domainName = match.Groups[2].Value;
        try
        {
            domainName = idn.GetAscii(domainName);
        }
        catch (ArgumentException)
        {
            invalid = true;
        }
        return match.Groups[1].Value + domainName;
    }
    public string EncryptString(string queryValue)
    {
        string str_queryStringValue;
        str_queryStringValue = Convert.ToBase64String(System.Text.Encoding.Unicode.GetBytes(queryValue));
        return str_queryStringValue;
    }

    public string DecryptString(string encryptedQueryValue)
    {
        string str_DecryptedString;
        if (encryptedQueryValue.Length >= 2)
        {
            str_DecryptedString = System.Text.Encoding.Unicode.GetString(Convert.FromBase64String(encryptedQueryValue));
           
                return str_DecryptedString;
           
        }
        else
            str_DecryptedString = "0";
        return str_DecryptedString;
    }

     
}