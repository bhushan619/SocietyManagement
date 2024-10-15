<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="AssignRoleFeatures.aspx.cs" Inherits="SK_Employee_AssignRoleFeatures" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Assign Role With Features</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">  
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Role</label>
									<div class="col-sm-8">
										 <asp:DropDownList ID="ddlEmployee"  required="required" AppendDataBoundItems="true"   CssClass="form-control " runat="server">
                                              <asp:ListItem Value="">:: Select Employee ::</asp:ListItem>
                                          </asp:DropDownList>
									</div>
									
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-4   control-label">Feature</label>
									<div class="col-sm-8">
                                        
										<select id="ddlFeature" placeholder= ":: Select Feature ::"  multiple="true" style="width:100% !important"   runat="server"   >
                                         </select> 
                                         
									</div>
								</div>
                        	 
                        	<div class="form-group">
                                	<label for="inputPassword" class="col-sm-4  control-label">Select Status</label>
									<div class="col-sm-8">
									 <asp:DropDownList ID="ddlisActive"  required="required" runat="server"  CssClass="form-control">
            <asp:ListItem Value="">:: Select Status ::</asp:ListItem>
            <asp:ListItem Value="1" >Active</asp:ListItem>
            <asp:ListItem Value="0" >Inactive</asp:ListItem>
        </asp:DropDownList>	</div>
                                </div>
							 
                        <div class="form-group">
									<div class="col-sm-4  "></div>
									<div class="col-sm-8">
 
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddFeature.aspx" >Reset</a>
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
                                                     
                                          <%--       <asp:GridView ID="grdFeatures" runat="server" AllowPaging="true" PageSize="5"  CssClass="table table-bordered table-hover" OnPageIndexChanging="grdFeatures_PageIndexChanging">
                                                      <HeaderStyle CssClass="info" />
                                                      <PagerStyle HorizontalAlign = "left" CssClass = "pager" />
                                                 </asp:GridView>--%>                                              
                       <div class="table-responsive">  
                              <asp:GridView ID="grdRolesAssigned" runat="server" HeaderStyle-CssClass="info"  AllowPaging="true" PageSize="20" OnPageIndexChanging="grdRolesAssigned_PageIndexChanging"  CssClass="table table-bordered table-hover"  >
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
                      </asp:GridView>
                           </div>
  </div>
                <div class="panel-footer"></div>
                 
                 
                </div>
            </div>
	</div> 
     
</asp:Content>
 

