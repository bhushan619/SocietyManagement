<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="Ledger.aspx.cs" Inherits="Society_Admin_Accounts_Ledger" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


     <div class="row"> 
            
			<div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>Ledger</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body no-padding  table-responsive">
                                                       <div class="table-responsive">
                                                           <asp:ListView ID="lstEntries" runat="server" OnPagePropertiesChanging="lstEntries_PagePropertiesChanging"  DataKeyNames="intId" DataSourceID="SqlDataSourceEntries">
                                                                
                                                               <EmptyDataTemplate>
                                                                   <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                             <tr >
                                                               <td  >
                                                                 	<div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                </div>
                                                               </td>
                                                              </tr>
                                                         </table>
                                                               </EmptyDataTemplate> 
                                                               <ItemTemplate>
                                                                   <tr style=""> 
                                                                     
                                                                       <td class="text-center">
                                                                           <asp:Label Text='<%# Container.DataItemIndex+1 %>' runat="server" ID="intIdLabel" /></td>
                                                                        <td>
                                                                           <asp:Label Text='<%# Eval("varDate") %>' runat="server" ID="varDateLabel" /></td>
                                                                       <td>
                                                                           <asp:Label Text='<%# Eval("varAccountName") %>' runat="server" ID="varAccountNameLabel" /></td>
                                                                     <td>
                                                                           <asp:Label Text='<%# Eval("varVoucher") %>' runat="server" ID="varVoucherLabel" /></td>
                                                                       <td>
                                                                           <asp:Label Text='<%# Eval("varReason") %>' runat="server" ID="varReasonLabel" /></td>
                                                                          <td>
                                                                             <asp:Label ID="Label1" runat="server" Text='<%# (bool)Eval("varEntryType")==true ?Eval("varAmount"):"0" %>' ></asp:Label>   
                                                                   
                                                                         <td>
                                                                             <asp:Label ID="Localize1" runat="server" Text='<%# (bool)Eval("varEntryType")==true ?"0":Eval("varAmount") %>' ></asp:Label>   
                                                                              <td>
                                                                         
                                                                     
                                                                   </tr>
                                                               </ItemTemplate>
                                                               <LayoutTemplate>

                                                                
                                                                               <table runat="server" id="itemPlaceholderContainer" class="table table-bordered" style="" border="0">
                                                                                   <tr id="Tr1" runat="server" style="">
                                                                                       
                                                                                        <th id="Th2" runat="server">Sr. No.</th>
                                                                                       <th id="Th3" runat="server">Date</th>
                                                                                       <th id="Th4" runat="server">Account Name</th>
                                                                                       <th id="Th5" runat="server">Voucher / Cheque</th>
                                                                                       <th id="Th6" runat="server">Reason</th> 
                                                                                       <th id="Th7" runat="server">Credit Amount</th>
                                                                                       <th id="Th10" runat="server">Debit Amount</th>
                                                                                     
                                                                                    
                                                                                   </tr>
                                                                                   <tr runat="server" id="itemPlaceholder"></tr>
                                                                               </table>
                                                                          

                                                                   </table>
                                                               </LayoutTemplate>

                                                                
                                                           </asp:ListView>
                                                           <asp:SqlDataSource runat="server" ID="SqlDataSourceEntries" ConnectionString='<%$ ConnectionStrings:ConnectionStringSKAdmin %>' ProviderName='<%$ ConnectionStrings:ConnectionStringSKAdmin.ProviderName %>' ></asp:SqlDataSource>
                                                       </div>
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstEntries" PageSize="10">
                                                          <Fields  >
                                                           <asp:NextPreviousPagerField ButtonType="Link" ButtonCssClass="btn btn-primary btn-xs" ShowFirstPageButton="True" ShowPreviousPageButton="False"   FirstPageText="< First "      ShowNextPageButton="false" />
                                                              <asp:NumericPagerField ButtonType="Link"  />
                                                             <asp:NextPreviousPagerField ButtonType="Link" ButtonCssClass="btn btn-primary btn-xs" ShowNextPageButton="False" ShowLastPageButton="True" ShowPreviousPageButton = "false"  LastPageText=" Last >"/>
                                                      </Fields>
                                                          </asp:DataPager>
                                                     </div>
                 </div>
                </div>
            </div>
               
</asp:Content>

