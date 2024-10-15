using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietyKatta.DAL;
using System.Data;
using System.Globalization;

namespace SocietyKatta.App_Code.BAL
{
    /// <summary>
    /// Summary description for ClsCommanData
    /// </summary>
    public class ClsCommanData : System.Web.UI.Page
    {
        ClsDAL ObjDAL = new ClsDAL();
        DataTable dt = new DataTable();
       
        public ClsCommanData()
        {
            
        }

        public string CreateRandomId(int IdLength)
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
                if (IsNumeric(str_DecryptedString))
                    return str_DecryptedString;
                else
                    str_DecryptedString = "0";
            }
            else
                str_DecryptedString = "0";
            return str_DecryptedString;
        }
        /// <summary>
        /// Check whether value id a valid Int32 Value or not
        /// </summary>
        /// <param name="value">Any value in string format</param>
        /// <returns>true if passed string is valid Int32 type else false</returns>
        public bool IsNumeric(string value)
        {
            try
            {
                long.Parse(value, new System.Globalization.CultureInfo("en-US"));
            }
            catch (InvalidCastException ex)
            {
                string exp = ex.Message;
                return false;
            }
            catch (FormatException ex)
            {
                string exp = ex.Message;
                return false;
            }
            catch (OverflowException ex)
            {
                string exp = ex.Message;
                return false;
            }
            return true;
        }

    } 
}