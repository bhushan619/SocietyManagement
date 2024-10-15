<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Property.master" AutoEventWireup="true" CodeFile="Invoices.aspx.cs" Inherits="Society_Property_Invoices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    	<div class="col-lg-12 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2> Invoices Information</h2>
				</div>
				<div class="panel-body table-responsive"> 
    <asp:ListView ID="lstInvoices" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="lstInvoices_ItemCommand">
         
         
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td><div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                </div></td>
                </tr>
            </table>
        </EmptyDataTemplate>
         
        <ItemTemplate>
            <tr style="">
                 <td>
                    <asp:Label Text='<%# Container.DataItemIndex+1 %>' runat="server" ID="Label1" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("InvoiceNo") %>' runat="server" ID="InvoiceNoLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Date") %>' runat="server" ID="DateLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Amount") %>' runat="server" ID="AmountLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Outstanding") %>' runat="server" ID="OutstandingLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("[Payment Status]") %>' runat="server" CssClass='<%# Eval("[Payment Status]").ToString() == "Paid" ? "label label-success" : "label label-warning" %>'  ID="Payment_StatusLabel"/> </td>
                 <td class="text-center"> 
                     <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId") %>' CommandName="view"  ToolTip="View Full Invoice" runat="server"  CssClass=" fa fa-eye" style="color:#558b2f"/></td>
                <td class="text-center"> 
                     <asp:LinkButton  ID="LinkButton1" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId") %>' CommandName="pay" ToolTip="Pay Bill Now"  runat="server" Enabled='<%# Eval("[Payment Status]").ToString() == "Paid" ? false : true %>' CssClass=" fa fa-credit-card" style="color:#ff6a00"/></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
             
                        <table runat="server" id="itemPlaceholderContainer" class="table table-bordered table-hover" border="0">
                            <tr runat="server" style="">
                                 <th runat="server">Sr. No.</th>
                                <th runat="server">Name</th>
                                <th runat="server">InvoiceNo</th>
                                <th runat="server">Date</th>
                                <th runat="server">Amount</th>
                                <th runat="server">Outstanding</th>
                                <th runat="server">Status</th>
                                 <th colspan="2" class="text-center" runat="server">#</th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </table> 
        </LayoutTemplate>
         
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' >
      
    </asp:SqlDataSource>
                    </div>
                </div>
          </div>
</asp:Content>

