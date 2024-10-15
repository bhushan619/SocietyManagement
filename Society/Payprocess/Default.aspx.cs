using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using System.Text;
using System.Net;
using System.IO;

public partial class Society_Payprocess_Default : System.Web.UI.Page
{
    public string action1 = string.Empty;
    public string hash1 = string.Empty;
    public string txnid1 = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            key.Value = ConfigurationManager.AppSettings["MERCHANT_KEY"];

            try
            {

                string[] hashVarsSeq;
                string hash_string = string.Empty;


                if (string.IsNullOrEmpty(Request.Form["txnid"])) // generating txnid
                {
                    Random rnd = new Random();
                    string strHash = Generatehash512(rnd.ToString() + DateTime.Now);
                    txnid1 = strHash.ToString().Substring(0, 20);

                }
                else
                {
                    txnid1 = Request.Form["txnid"];
                }
                if (string.IsNullOrEmpty(Request.Form["hash"])) // generating hash value
                {
                    if (
                        string.IsNullOrEmpty(ConfigurationManager.AppSettings["MERCHANT_KEY"]) ||
                        string.IsNullOrEmpty(txnid1) ||
                        string.IsNullOrEmpty(Request.QueryString["amount"]) ||
                        string.IsNullOrEmpty(Request.QueryString["firstname"]) ||
                        string.IsNullOrEmpty(Request.QueryString["email"]) ||
                        string.IsNullOrEmpty(Request.QueryString["phone"]) ||
                        string.IsNullOrEmpty(Request.QueryString["productinfo"]) ||
                          string.IsNullOrEmpty(Request.QueryString["udf1"]) ||
                        string.IsNullOrEmpty(Request.QueryString["udf2"]) ||
                          string.IsNullOrEmpty(Request.QueryString["udf3"]) ||
                        string.IsNullOrEmpty("http://societykatta.com/Society/payprocess/Default.aspx") ||
                        string.IsNullOrEmpty("http://societykatta.com/Society/payprocess/Default.aspx") ||
                        string.IsNullOrEmpty("payu_paisa")
                        )
                    {
                        //error

                        frmError.Visible = true;
                        return;
                    }

                    else
                    {
                        frmError.Visible = false;
                        hashVarsSeq = ConfigurationManager.AppSettings["hashSequence"].Split('|'); // spliting hash sequence from config
                        hash_string = "";
                        foreach (string hash_var in hashVarsSeq)
                        {
                            if (hash_var == "key")
                            {
                                hash_string = hash_string + ConfigurationManager.AppSettings["MERCHANT_KEY"];
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "txnid")
                            {
                                hash_string = hash_string + txnid1;
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "amount")
                            {
                                hash_string = hash_string + Convert.ToDecimal(Request.QueryString["amount"]).ToString("g29");
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "productinfo")
                            {
                                hash_string = hash_string + Request.QueryString["productinfo"].ToString();
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "firstname")
                            {
                                hash_string = hash_string + Request.QueryString["firstname"].ToString();
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "email")
                            {
                                hash_string = hash_string + Request.QueryString["email"].ToString();
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "udf1")
                            {
                                hash_string = hash_string + Request.QueryString["udf1"].ToString();
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "udf2")
                            {
                                hash_string = hash_string + Request.QueryString["udf2"].ToString();
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "udf3")
                            {
                                hash_string = hash_string + Request.QueryString["udf3"].ToString();
                                hash_string = hash_string + '|';
                            }
                            else
                            {

                                hash_string = hash_string + (Request.Form[hash_var] != null ? Request.Form[hash_var] : "");// isset if else
                                hash_string = hash_string + '|';
                            }
                        }

                        hash_string += ConfigurationManager.AppSettings["SALT"];// appending SALT

                        hash1 = Generatehash512(hash_string).ToLower();         //generating hash
                        action1 = ConfigurationManager.AppSettings["PAYU_BASE_URL"] + "/_payment";// setting URL

                    }


                }

                else if (!string.IsNullOrEmpty(Request.Form["hash"]))
                {
                    hash1 = Request.Form["hash"];
                    action1 = ConfigurationManager.AppSettings["PAYU_BASE_URL"] + "/_payment";

                }




                if (!string.IsNullOrEmpty(hash1))
                {
                    hash.Value = hash1;
                    txnid.Value = txnid1;

                    System.Collections.Hashtable data = new System.Collections.Hashtable(); // adding values in gash table for data post
                    data.Add("hash", hash.Value);
                    data.Add("txnid", txnid.Value);
                    data.Add("key", key.Value);
                    string AmountForm = Convert.ToDecimal(Request.QueryString["amount"]).ToString("g29");// eliminating trailing zeros
                    //amount.Text = AmountForm;
                    // data.Add("amount", AmountForm);
                    data.Add("amount", AmountForm);
                    data.Add("firstname", Request.QueryString["firstname"].Trim());
                    data.Add("email", Request.QueryString["email"].Trim());
                    data.Add("phone", Request.QueryString["phone"].Trim());
                    data.Add("productinfo", Request.QueryString["productinfo"].Trim());
                    data.Add("surl", Request.QueryString["surl"].Trim());
                    data.Add("furl", Request.QueryString["furl"].Trim());
                    data.Add("lastname", "");
                    data.Add("curl", "");
                    data.Add("address1", "");
                    data.Add("address2", "");
                    data.Add("city", "");
                    data.Add("state", "");
                    data.Add("country", "");
                    data.Add("zipcode", "");
                    data.Add("udf1", Request.QueryString["udf1"].Trim());
                    data.Add("udf2", Request.QueryString["udf2"].Trim());
                    data.Add("udf3", Request.QueryString["udf3"].Trim());
                    data.Add("udf4", "");
                    data.Add("udf5", "");
                    data.Add("pg", "");
                    data.Add("service_provider", "payu_paisa".Trim());


                    string strForm = PreparePOSTForm(action1, data);
                    Page.Controls.Add(new LiteralControl(strForm));

                }

                else
                {
                    //no hash

                }

            }

            catch (Exception ex)
            {
                Response.Write("<span style='color:red'>" + ex.Message + "</span>");

            }
        }
        catch (Exception ex)
        {
            Response.Write("<span style='color:red'>" + ex.Message + "</span>");

        }
    }

    public string Generatehash512(string text)
    {

        byte[] message = Encoding.UTF8.GetBytes(text);

        UnicodeEncoding UE = new UnicodeEncoding();
        byte[] hashValue;
        SHA512Managed hashString = new SHA512Managed();
        string hex = "";
        hashValue = hashString.ComputeHash(message);
        foreach (byte x in hashValue)
        {
            hex += String.Format("{0:x2}", x);
        }
        return hex;

    }

    private string PreparePOSTForm(string url, System.Collections.Hashtable data)      // post form
    {
        //Set a name for the form
        string formID = "PostForm";
        //Build the form using the specified data to be posted.
        StringBuilder strForm = new StringBuilder();
        strForm.Append("<form id=\"" + formID + "\" name=\"" +
                       formID + "\" action=\"" + url +
                       "\" method=\"POST\">");

        foreach (System.Collections.DictionaryEntry key in data)
        {

            strForm.Append("<input type=\"hidden\" name=\"" + key.Key +
                           "\" value=\"" + key.Value + "\">");
        }


        strForm.Append("</form>");
        //Build the JavaScript which will do the Posting operation.
        StringBuilder strScript = new StringBuilder();
        strScript.Append("<script language='javascript'>");
        strScript.Append("var v" + formID + " = document." +
                         formID + ";");
        strScript.Append("v" + formID + ".submit();");
        strScript.Append("</script>");
        //Return the form and the script concatenated.
        //(The order is important, Form then JavaScript)
        return strForm.ToString() + strScript.ToString();
    }
}