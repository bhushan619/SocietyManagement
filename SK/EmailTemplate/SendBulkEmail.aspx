<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="SendBulkEmail.aspx.cs" Inherits="SK_EmailTemplate_SendBulkEmail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      
                                    <asp:LinkButton ID="lnkinkbutton" runat="server" CssClass="btn btn-warning" OnClick="lnkinkbutton_Click">Import excel</asp:LinkButton>  
                                 
                                    <asp:FileUpload ID="FileUpload1" runat="server" />
    <asp:GridView ID="GridView1" runat="server" ShowHeader="true" AutoGenerateColumns="false" CssClass="table table-bordered">

 <Columns>
                              <asp:BoundField DataField="EmailId" HeaderText="EmailId" SortExpression="EmailId" />       
         
       
      
        </Columns>   <EmptyDataTemplate>

              No Data Found.  

        </EmptyDataTemplate> <PagerSettings Mode="Numeric" />
                                    </asp:GridView>
    <br /><br />
    <div class="col-md-6">
    <asp:TextBox ID="txtemail" runat="server" required="required" CssClass="form-control" placeholder="Enter Email-id"></asp:TextBox>
    <br /> <br />
    <asp:Button ID="btnmail" runat="server" Text="Send Mail" CssClass="btn btn-primary" OnClick="btnmail_Click" />
</div>
</asp:Content>

