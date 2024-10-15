<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="Invoices.aspx.cs" Inherits="SK_SocietyAccounts_Invoices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="col-lg-12"> 
            <div class="panel panel-info"> 
                <div class="panel-heading">
					<h2>View Invoices</h2>
				</div>
				<div class="panel-body"> 

                    <asp:HiddenField ID="TabName" runat="server" />
 <script type="text/javascript">
     $(function () {
         var tabName = $("[id*=ContentPlaceHolder1_TabName]").val() != "" ? $("[id*=ContentPlaceHolder1_TabName]").val() : "Flat";
         $('#Tabs a[href="#' + tabName + '"]').tab('show');
         $("#Tabs a").click(function () {
             $("[id*=ContentPlaceHolder1_TabName]").val($(this).attr("href").replace("#", ""));
         });
     });
         </script>
                    
         <div id="Tabs" role="tabpanel">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
       <li class="active"><a aria-controls="Society" href="#Society" role="tab" data-toggle="tab">Society &nbsp;<i class="fa fa-home" style="color:#558b2f;"></i></a></li>
        <li><a href="#Vendors" aria-controls="Vendors" role="tab" data-toggle="tab">Vendors &nbsp;<i class="fa fa-users"  style="color:#ba68c8;"></i></a></li>  
	   </ul>
    <!-- Tab panes -->
    
    </div>
        <br />
        <div class="tab-content">
				<div class="tab-pane active"  role="tabpanel"  id="Society">  
                    
			<div class="tab-pane active"  role="tabpanel"  id="UnApprovedReq"> 
                     <div class="col-lg-12"> 
            <div class="panel panel-info"> 
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
                 <td class="text-center"> <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId")+":"+ Eval("SocOrVen") %>' CommandName="view"  runat="server"  CssClass=" fa fa-eye fa-2x" style="color:#558b2f"/></td>
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
                                 <th id="Th8" class="text-center" runat="server">#</th>
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
				</div>	
          
	  </div> 
             <div class="tab-pane"  role="tabpanel"  id="Vendors"> 
                     
			<div class="tab-pane active"  role="tabpanel"  id="UnApprovedNot"> 
                     <div class="col-lg-12"> 
            <div class="panel panel-info"> 
				<div class="panel-body no-padding  table-responsive"> 
                      <div class="table-responsive">
                                           <asp:ListView ID="lstVendorInvoices" runat="server"   OnItemCommand="lstInvoices_ItemCommand">
         
         
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
                 <td class="text-center"> <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId") +":"+ Eval("SocOrVen")%>' CommandName="view"  runat="server"  CssClass=" fa fa-eye fa-2x" style="color:#558b2f"/></td>
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
                                 <th id="Th8" class="text-center" runat="server">#</th>
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
				</div>	
          
				</div>
  	
 
  </div>
                     
                    </div>
                </div>
          </div>
</asp:Content>

