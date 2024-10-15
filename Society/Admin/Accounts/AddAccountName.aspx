<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="AddAccountName.aspx.cs" Inherits="Society_Admin_Accounts_AddAccountName" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
           <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Add Accounts to be handled</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
 
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Account Name</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtAccountName" runat="server"  onkeyup="checkTextNum(this);" CssClass="form-control" placeholder="Account Name"></asp:TextBox>
									</div>
									
								</div> 
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Account Description</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtAccountDesc" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control" placeholder="Account Description"></asp:TextBox>
									</div>
									
								</div> 
                       <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">&nbsp; </label>
										
									<div class="col-sm-8">
                                            <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"/>
                                           <asp:Button ID="btnUpdate" Visible="false" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" OnClick="btnUpdate_Click"/>
                                        
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddAccountName.aspx" >Reset</a>
                                        </div>
                           </div>
                        </div>
                           <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
                    </div>
                </div>
            </div>
               <div class="col-md-6 ">
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
                                                           <asp:ListView ID="lstAccountNames" runat="server"  OnPagePropertiesChanging="OnPagePropertiesChanging" OnItemCommand="lstAccountNames_ItemCommand" DataKeyNames="intId">

                                                             
                                                               <EmptyDataTemplate>
                                                                   <table runat="server" style="" cssclass="table table-bordered table-hover">
                                                                       <tr>
                                                                           <td><div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                </div>
                                                                           </td>
                                                                       </tr>
                                                                   </table>
                                                               </EmptyDataTemplate> 
                                                               <ItemTemplate>
                                                                   <tr style="">
                                                                    
                                                                       <td>
                                                                           <asp:Label Text='<%# Eval("varAccountName") %>' runat="server" ID="varAccountNameLabel" /></td>
                                                                       <td>
                                                                           <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="varDescriptionLabel" /></td>   
                                                                        <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId")+":"+Eval("varAccountName")+":"+  Eval("varDescription") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                         
                                                                   </tr>
                                                               </ItemTemplate>
                                                               <LayoutTemplate>
                                                                  
                                                                               <table runat="server" class="table table-bordered" id="itemPlaceholderContainer" style="" border="0">
                                                                                   <tr runat="server" style="">
                                                                                     
                                                                                     
                                                                                       <th runat="server">Account Name</th>
                                                                                       <th runat="server">Description</th>
                                                                                       <th runat="server">#</th>
                                                                                   </tr>
                                                                                   <tr runat="server" id="itemPlaceholder"></tr>
                                                                               </table>
                                                                            
                                                                   </table>
                                                               </LayoutTemplate>
                                                                
                                                           </asp:ListView>
                                                                </div>
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstAccountNames" PageSize="10">
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

