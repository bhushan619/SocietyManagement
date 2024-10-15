<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ViewEmpolyee.aspx.cs" Inherits="Society_Admin_Employee_ViewEmpolyee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
         <div class="col-md-12 ">
			<div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>Employee Information</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body no-padding  table-responsive">
                                                   <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>      <div class="table-responsive">
                                                 <asp:ListView ID="lstType" runat="server" OnPagePropertiesChanging="OnPagePropertiesChanging" OnItemCommand="lstType_ItemCommand" >
                                                 
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
                                                             <td>   <asp:Label Text='<%# Eval("EmpName") %>' runat="server" ID="Type" /></td>
                                                               
                                                               <td> <asp:Label Text='<%# Eval("varDepartmentName") %>' runat="server" ID="IsActive" /></td>
                                                             <td>   <asp:Label Text='<%# Eval("RoleName") %>' runat="server" ID="Label2" /></td>
                                                                     <%--   <td>   <asp:Label Text='<%# Eval("StateName") %>' runat="server" ID="Label6" /></td>--%>
                                                               <td> <asp:Label Text='<%# Eval("CityName") %>' runat="server" ID="Label3" /></td>
                                                             <td>   <asp:Label Text='<%# Eval("varMbPrimary") %>' runat="server" ID="Label1" /></td>
                                                             <td> <asp:Label Text='<%# Eval("varPrimaryEmail") %>' runat="server" ID="Label4" /></td>
                                                                        <td> <asp:Label Text='<%# Eval("varDateOfJoin") %>' runat="server" ID="Label5" /></td>
                                                           <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intEmpCode") %>' CommandName="View"  runat="server"  CssClass=" fa fa-eye">&nbsp;View Full</asp:LinkButton></td>
              
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Name</th> 
                                                                             <th id="Th5" runat="server">Department</th>
                                                                             <th id="Th6" runat="server">Designation</th> 
                                                                             <%--  <th id="Th10" runat="server">State</th>--%>
                                                                             <th id="Th7" runat="server">City</th>
                                                                              <th id="Th4" runat="server">Mobile Number</th> 
                                                                              <th id="Th8" runat="server">Email-ID</th>
                                                                               <th id="Th9" runat="server">Join Date</th>
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
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstType" PageSize="10">
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
