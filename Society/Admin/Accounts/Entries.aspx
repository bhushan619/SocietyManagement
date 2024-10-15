<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/masterpage.master" AutoEventWireup="true" CodeFile="Entries.aspx.cs" Inherits="Society_Admin_Accounts_Entries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


     <div class="row">
		<div class="col-md-5 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Add / Update Entries</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3 control-label">Opening Balance</label>
									<div class="col-sm-9">
										  <asp:TextBox ID="txtInitialBalance" ReadOnly="true" required="required" runat="server" CssClass="form-control" placeholder="Initial Balance"></asp:TextBox>
									</div>
									
								</div>
                               <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Date</label>
                                                                                  
									<div class="col-sm-9">										       
                                        <asp:TextBox ID="txtDOB" runat="server" data-plugin-datepicker="data-plugin-datepicker" CssClass="form-control" required="required" placeholder="Select Date"></asp:TextBox>	
									</div>
									
								</div> 
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-3 control-label">Entry Type</label>
									<div class="col-sm-9">
                                        <asp:DropDownList ID="ddlEntryType" runat="server" CssClass="form-control" required="required">
                                            <asp:ListItem Value="">:: Select Entry Type ::</asp:ListItem>
                                            <asp:ListItem Value="0">Debit</asp:ListItem>
                                            <asp:ListItem Value="1">Credit</asp:ListItem>
                                        </asp:DropDownList>
									</div>
									
								</div> 
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-3 control-label">Account Name</label>
									<div class="col-sm-9">
                                        <asp:DropDownList ID="ddlAccount" runat="server" required="required" CssClass="form-control" AppendDataBoundItems="true">
                                            <asp:ListItem Value="">:: Select Account ::</asp:ListItem>
                                        </asp:DropDownList>
									</div>
									
								</div> 
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-3 control-label">Voucher/Cheque</label>
									<div class="col-sm-9">
										  <asp:TextBox ID="txtVoucher" required="required" onkeyup="checkTextNum(this);" runat="server" CssClass="form-control" placeholder="Voucher/Cheque"></asp:TextBox>
									</div>
									
								</div> 
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3 control-label">Reason</label>
									<div class="col-sm-9">
										  <asp:TextBox ID="txtReason" required="required" onkeyup="checkTextNum(this);" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Reason"></asp:TextBox>
									</div>
									
								</div> 
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3 control-label">Amount</label>
									<div class="col-sm-9">
										  <asp:TextBox ID="txtAmount" required="required" onkeyup="checkDec(this);"  runat="server" CssClass="form-control" placeholder="Amount"></asp:TextBox>
									</div>
									
								</div> 
                       <div class="form-group">
									<label for="focusedinput" class="col-sm-3 control-label">&nbsp; </label>
										
									<div class="col-sm-9">
                                            <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"/>
                                           <asp:Button ID="btnUpdate" Visible="false" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" OnClick="btnUpdate_Click"/>
                                        
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="Entries.aspx" >Reset</a>
                                        </div>
                           </div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3 control-label">Closing Balance</label>
									<div class="col-sm-9">
										  <asp:TextBox ID="txtClosingBalance" ReadOnly="true" required="required" runat="server" CssClass="form-control" placeholder="Closing Balance"></asp:TextBox>
									</div>
									
								</div> 
                        </div>
                           <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
                    </div>
                </div>
            </div>
               <div class="col-md-7 ">
			<div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View</h2>
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
                                                           <asp:ListView ID="lstEntries" runat="server" OnPagePropertiesChanging="lstEntries_PagePropertiesChanging" OnItemCommand="lstEntries_ItemCommand" DataKeyNames="intId" DataSourceID="SqlDataSourceEntries">
                                                                
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
                                                                       <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId")+":"+Eval("varAmount")+":"+ Eval("varDate")+":"+ Eval("varEntryType") %>' CommandName="Deletes"  runat="server"  CssClass="text-danger fa fa-trash"/></td>
                                                           
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
                                                                             <asp:Label ID="Localize1" runat="server" Text='<%# (bool)Eval("varEntryType")==true ?"Credit":"Debit" %>' ></asp:Label>   
                                                                       <td>
                                                                           <asp:Label Text='<%# Eval("varAmount") %>' runat="server" ID="varAmountLabel" /></td>
                                                                             <td>
                                                                           <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                                                                        
                                                                          
                                                                     
                                                                   </tr>
                                                               </ItemTemplate>
                                                               <LayoutTemplate>

                                                                
                                                                               <table runat="server" id="itemPlaceholderContainer" class="table table-bordered" style="" border="0">
                                                                                   <tr runat="server" style="">
                                                                                        <th runat="server">#</th> 
                                                                                        <th runat="server">Sr. No.</th>
                                                                                       <th runat="server">Date</th>
                                                                                       <th runat="server">Account Name</th>
                                                                                       <th runat="server">Voucher / Cheque</th>
                                                                                       <th runat="server">Reason</th> 
                                                                                       <th runat="server">Entry Type</th>
                                                                                       <th runat="server">Amount</th> 
                                                                                       <th runat="server">Entry Done By</th>
                                                                                    
                                                                                   </tr>
                                                                                   <tr runat="server" id="itemPlaceholder"></tr>
                                                                               </table>
                                                                          

                                                                   </table>
                                                               </LayoutTemplate>

                                                                
                                                           </asp:ListView>
                                                           <asp:SqlDataSource runat="server" ID="SqlDataSourceEntries" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' ></asp:SqlDataSource>
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
               <asp:Label ID="lblroleid" runat="server" Text=""></asp:Label>
               <asp:Label ID="lblmemid" runat="server" Text=""></asp:Label>
               </div>
</asp:Content>

