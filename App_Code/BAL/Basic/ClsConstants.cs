using System;
using System.Collections.Generic;
using System.Web;

namespace SocietyKatta.Basic
{
    /// <summary>
    /// Summary description for ClsConstants
    /// </summary>
    public class ClsConstants
    {
        public const string DEFAULT_CULTURE_ID = "1";
        public const string DEFAULT_CULTURE = "en-US";
    }

    public class MenuIcons
    {
        public static Dictionary<int, string> ParentMenuIcons()
        {
            Dictionary<int, string> dict = new Dictionary<int, string>();
            dict.Add(0, "fa fa-graduation-cap");
            dict.Add(1, "fa fa-user-plus");
            dict.Add(2, "fa fa-gear");
            dict.Add(3, "fa fa-users");
            dict.Add(4, "fa fa-search");
            return dict;
        }
    }
}