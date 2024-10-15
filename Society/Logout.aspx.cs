using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Society_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current != null)
        {
            int cookieCount = HttpContext.Current.Request.Cookies.Count;
            for (var i = 0; i < cookieCount; i++)
            {
                var cookie = HttpContext.Current.Request.Cookies[i];
                if (cookie != null)
                {
                    var cookieName = cookie.Name;
                    var expiredCookie = new HttpCookie(cookieName) { Expires = DateTime.Now.AddDays(-1) };
                    HttpContext.Current.Response.Cookies.Add(expiredCookie); // overwrite it
                }
            }

            // clear cookies server side
            HttpContext.Current.Request.Cookies.Clear();
        }

        // Code disables caching by browser.
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(330).AddHours(-1));
        Response.Cache.SetNoStore();

        HttpContext.Current.Session.Abandon();
        HttpContext.Current.Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));


        Session.Contents.RemoveAll();

        Session.Abandon();
        FormsAuthentication.SignOut();
        Response.Redirect("~/Home/Login.aspx", false);

    }
}