<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="SocietyInvoices.aspx.cs" Inherits="Society_Admin_Accounts_SocietyInvoices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="col-lg-12"> 
            <div class="panel panel-info"> 
                <div class="panel-heading">
					<h2>View Society Invoices</h2>
				</div> 
				<div class="panel-body no-padding  table-responsive"> 
                      <div class="table-responsive">
                                          <asp:ListView ID="lstSocietyInvoices" runat="server"   OnItemCommand="lstInvoices_ItemCommand">
         
         
        <EmptyDataTemplate>
            <table id="Table1" runat="server" style="">
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
                    <asp:Label Text='<%# Eval("InvoiceNo") %>' runat="server" ID="InvoiceNoLabel" /></td>
                  <td>
                    <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                 <td>
                    <asp:Label Text='<%# Eval("Date") %>' runat="server" ID="DateLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Amount") %>' runat="server" ID="AmountLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Outstanding") %>' runat="server" ID="OutstandingLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("PaymentStatus") %>' runat="server" CssClass='<%# Eval("PaymentStatus").ToString() == "Paid" ? "label label-success" : "label label-warning" %>'  ID="Payment_StatusLabel"/> </td>
                 <td class="text-center"> 
                     <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId") %>' CommandName="view"  runat="server"  CssClass=" fa fa-eye" style="color:#558b2f"/>
                    </td><td>  <asp:LinkButton  ID="LinkButton1" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId") %>' CommandName="pay" ToolTip="Pay Bill Now"  runat="server" Enabled='<%# Eval("PaymentStatus").ToString() == "Paid" ? false : true %>' CssClass=" fa fa-credit-card" style="color:#ff6a00"/></td>

                 </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
             
                        <table runat="server" id="itemPlaceholderContainer" class="table table-bordered table-hover" border="0">
                            <tr id="Tr1" runat="server" style="">
                                 <th id="Th1" runat="server">Sr. No.</th>
                                <th id="Th3" runat="server">InvoiceNo</th>
                                <th id="Th2" runat="server">Name</th>
                                <th id="Th4" runat="server">Date</th>
                                <th id="Th5" runat="server">Amount</th>
                                <th id="Th6" runat="server">Outstanding</th>
                                <th id="Th7" runat="server">Status</th>
                                 <th colspan="2" id="Th8" class="text-center" runat="server">#</th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </table> 
        </LayoutTemplate>
         
    </asp:ListView>
                          </div>
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                   
                                                     </div>
                 </div>
                </div>
		 
          </div>
</asp:Content>


