<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="VendorServicesTypes.aspx.cs" Inherits="SK_MasterData_VendorServicesTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2> Service Type Information</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
                      
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Service Type Code</label>
									<div class="col-sm-8">
										 <asp:TextBox ID="txtMainCode" ReadOnly="true" runat="server" CssClass="form-control"></asp:TextBox>
									</div>
									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Service  </label>
									<div class="col-sm-8">
									 <asp:DropDownList  ID="ddlServiceType" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                                           <asp:ListItem Value="">:: Select Service ::</asp:ListItem>
                                       </asp:DropDownList>
									</div>
									
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Service Name</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtName" required="required" onkeyup="checkTextNum(this);" runat="server" CssClass="form-control"></asp:TextBox>
									</div>
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label"> Description</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtDescription" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
									</div>
								</div>
                 
                        <div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Remarks</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtRemark" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
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
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="VendorServicesTypes.aspx" >Reset</a>
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
                                                     
                                              <asp:ListView ID="ListView1" runat="server" OnItemCommand="ListView1_ItemCommand" OnPagePropertiesChanging="OnPagePropertiesChanging" >
                                                 
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
                                                            <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intServicetypeCode") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                               <td><asp:LinkButton  ID="lnkListDelet" CommandArgument='<%# Eval("intServicetypeCode") %>' CommandName="Delets"  runat="server"  CssClass=" fa fa-trash-o"/></td>
                                                           
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("intId") %>' runat="server" ID="Id" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("Service") %>' runat="server" ID="Service" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("Type") %>' runat="server" ID="Type" /></td>
                                                           
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                             <th id="Th1" runat="server" colspan="2">Operation</th>
                                                                       
                                                                             <th id="Th2" runat="server">Id</th>
                                                                             <th id="Th3" runat="server">Service</th>
                                                                             <th id="Th4" runat="server">Type</th>
                                                                             
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="ListView1" PageSize="10">
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
	</div>

</asp:Content>




