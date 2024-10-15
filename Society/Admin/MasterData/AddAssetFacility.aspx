<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="AddAssetFacility.aspx.cs" Inherits="Society_Admin_MasterData_AddAssetFacility" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
     <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2> Asset Facility Information</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
                      
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Asset Facility Type</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtType" runat="server" CssClass="form-control" onkeyup="checkTextNum(this);" required="required"></asp:TextBox>
									</div>
									
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Description</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtDescription" onkeyup="checkTextNum(this);" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
									</div>
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label"> Remarks</label>
									<div class="col-sm-8">
										 <asp:TextBox ID="txtRemark" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
									</div>
								</div>
                      
                        	<div class="form-group">
                                		<div class="col-sm-3  "></div>	
									<div class="col-sm-8">
									<label class="checkbox-inline">	  <asp:CheckBox ID="chkIsActive" runat="server"  /> Is Active 	 </label>
									</div>
                                </div>
							
                        <div class="form-group">
									<div class="col-sm-3  "></div>
									<div class="col-sm-8">
									  <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" Visible="false"  OnClick="btnUpdate_Click"/>
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddAssetFacility.aspx" >Reset</a>
									</div>
								</div>
                          <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
					
					</div>
					
				</div>
				
			</div>
		</div>
        <div class="col-md-6 ">
				<div class="panel panel-info"  data-widget='{"id" : "wiget9", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View</h2>
				<div class="panel-ctrls button-icon-bg" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body no-padding table-responsive">
                
                                                   <div class="table-responsive">
                                                 <asp:ListView ID="lstAccountType" runat="server" OnPagePropertiesChanging="OnPagePropertiesChanging" OnItemCommand="lstAccountType_ItemCommand" >
                                                 
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
                                                         <td>  <asp:Label ID="lblSRNO" runat="server"  Text='<%#Container.DataItemIndex+1 %>'></asp:Label></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("Type") %>' runat="server" ID="Type" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Description" /></td>
                                                              <td>
                                                                 <asp:Label Text='<%# Eval("IsActive") %>' runat="server" ID="IsActive" /></td>
                                                           
                                                                 <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("ID") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                            
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered m-n" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                           
                                                                       
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Type</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                             <th id="Th5" runat="server">IsActive</th> 
                                                                              <th id="Th1" runat="server" >Operation</th>
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
               </div>
                  

                    </div> 
                	<div class="panel-footer">
                 <div class="text-right">
                                                   <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstAccountType" PageSize="10">
                      <Fields  >
                                                           <asp:NextPreviousPagerField ButtonType="Link" ButtonCssClass="btn btn-primary btn-xs" ShowFirstPageButton="True" ShowPreviousPageButton="False"   FirstPageText="< First "      ShowNextPageButton="false" />
                                                              <asp:NumericPagerField ButtonType="Link"  />
                                                             <asp:NextPreviousPagerField ButtonType="Link" ButtonCssClass="btn btn-primary btn-xs" ShowNextPageButton="False" ShowLastPageButton="True" ShowPreviousPageButton = "false"  LastPageText=" Last >"/>
                                                      </Fields>
                </asp:DataPager>
                                                     </div></div>
                </div>
            </div>
	</div>

</asp:Content>

