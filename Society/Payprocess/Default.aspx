<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Society_Payprocess_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" method="post">
    
    <div id ="frmError" runat="server">
      <span style="color:red">Please fill all mandatory fields.</span>
      <br/>
      <br/>
      </div>
      
    
   <input type="hidden" runat="server" id="key" name="key" />
      <input type="hidden" runat="server" id="hash" name="hash"  />
            <input type="hidden" runat="server" id="txnid" name="txnid" />
             <input type="hidden" runat="server" id="enforce_paymethod" name="enforce_paymethod" />
       
     <br />
    
    </form>
</body>
</html>
