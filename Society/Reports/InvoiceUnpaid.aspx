<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="InvoiceUnpaid.aspx.cs" Inherits="Society_Reports_InvoiceUnpaid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <div class="row">
            <div class="col-lg-12">  
                    <div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2><i class="ti  ti-home"></i>Flatwise UnPaid Invoices Details </h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''>
				</div>	
			</div>
         <div class="panel-body" >
<div class="table-responsive">
<asp:ListView ID="lstInvoices" runat="server"  OnSorting="lstInvoices_Sorting"  OnItemCommand="lstInvoices_ItemCommand">
         
         
            <EmptyDataTemplate>
                <table id="Table2" runat="server" style="">
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
                    <td>    <asp:Label Text='<%# Eval("Flat") %>' runat="server" ID="Label2" /></td>
                        <td>    <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("InvoiceNo") %>' runat="server" ID="InvoiceNoLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("Date") %>' runat="server" ID="DateLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("Amount") %>' runat="server" ID="AmountLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("[Payment Status]") %>' runat="server" CssClass='<%# Eval("[Payment Status]").ToString() == "Paid" ? "label label-success" : "label label-warning" %>'  ID="Payment_StatusLabel"/> </td>
                        <td class="text-center"> <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId") %>' CommandName="view" ToolTip="View Full Invoice"  runat="server"  CssClass=" fa fa-eye fa-2x" style="color:#558b2f"/></td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
             
                            <table runat="server" id="itemPlaceholderContainer" class="table table-bordered table-hover" border="0">
                                <tr id="Tr2" runat="server" style="">
                                        <th id="Th2" runat="server">Sr. No.</th>
                                                                                                                                                
                                        <th id="Th1" runat="server">Flat No.&nbsp;<asp:ImageButton ID="imFlat" CommandArgument="Flat" CommandName="Sort" Text="Flat" ImageUrl="~/Designs/Outside/images/asc.png" runat="server" /></th>
                                    <th id="Th5" runat="server">Owner Name&nbsp;<asp:ImageButton ID="imOwner" CommandArgument="Name" CommandName="Sort" Text="Name" ImageUrl="~/Designs/Outside/images/asc.png" runat="server" /></th>
                                    <th id="Th7" runat="server">Invoice No</th>
                                    <th id="Th8" runat="server">Date</th>
                                    <th id="Th9" runat="server">Amount</th>
                                                                                                                                            
                                    <th id="Th11" runat="server">Status</th>
                                        <th id="Th12" class="text-center" runat="server">#</th>
                                </tr>
                                                                                                                                            
                                <tr runat="server" id="itemPlaceholder"></tr> 
                                                                                                                                              
                                                                                                                                     
                            </table> 
                                                                                                                         
            </LayoutTemplate>
         
        </asp:ListView>
</div>
                                                        
                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' >
                   
                </asp:SqlDataSource>
                     </div>   </div>
                </div>
</div>       


</asp:Content>

