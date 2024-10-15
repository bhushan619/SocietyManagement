<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="ViewEmpolyee.aspx.cs" Inherits="SK_Employee_ViewEmpolyee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
           <div class="row">
		<div class="col-md-12 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>View Employees</h2>
				</div>
			
				<div class="panel-body  table-responsive">
                  <div class="table-responsive">
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
                                                             <td>   <asp:Label Text='<%# Eval("varEmpName") %>' runat="server" ID="Type" /></td>
                                                                <td>   <asp:Label Text='<%# Eval("varDepartmentName") %>' runat="server" ID="Label5" /></td>
                                                               <td>   <asp:Label Text='<%# Eval("RoleName") %>' runat="server" ID="Label4" /></td>
                                                               <td>   <asp:Label Text='<%# Eval("varMbPrimary") %>' runat="server" ID="Label1" /></td>
                                                               <td>   <asp:Label Text='<%# Eval("varPrimaryEmail") %>' runat="server" ID="Label2" /></td>
                                                               <td> <asp:Label Text='<%# Eval("intIsActive").ToString() == "1" ? "ACTIVE" :Eval("intIsActive").ToString()=="0"? "INACTIVE":"label label-warning" %>' runat="server" ID="varStartDate" CssClass='<%# Eval("intIsActive").ToString() == "1" ? "label label-success" :Eval("intIsActive").ToString()=="0"? "label label-danger":"label label-warning" %>'  /></td>
                                  
                                                          <td  class="text-center"><asp:LinkButton  ID="lnkapprove" CommandArgument='<%# Eval("intId")  %>' CommandName="Approve"  runat="server"  ToolTip="Approve" CssClass=" fa  fa-check"  style="color:#558b2f"/></td>
                                                                <td  class="text-center"><asp:LinkButton  ID="lnkreject" CommandArgument='<%# Eval("intId")  %>' CommandName="Reject"  runat="server"  ToolTip="Reject" CssClass=" fa  fa-times " style="color:#ff0000" /></td>
                                                               <td  class="text-center"><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId")  %>' CommandName="Views"  runat="server"  ToolTip="View Full Details" CssClass=" fa  fa-eye"/></td>
                                                          
                                                           
                                                            
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Name</th>
                                                                             <th id="Th9" runat="server">Department</th>      
                                                                              <th id="Th8" runat="server">Role</th> 
                                                                                 <th id="Th4" runat="server">Mobile Number</th> 
                                                                                <th id="Th6" runat="server">Email-Id</th> 
                                                                               
                                                                             <th id="Th5" runat="server">IsActive</th>
                                                                              <th id="Th1" runat="server" colspan="3" >Operation</th>
                                                                       
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

