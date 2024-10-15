<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="ViewComplaints.aspx.cs" Inherits="Society_View_ViewComplaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row"> 
<div class="col-md-12"> 
            <div class="panel panel-info"> 
                	<div class="panel-heading">
				<h2>View Complaints</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body   table-responsive"> 
                      <div class="table-responsive">
                                                 <asp:ListView ID="lstRequests" runat="server" OnPagePropertiesChanging="OnPagePropertiesChanging" OnItemCommand="lstRequests_ItemCommand" >
                                                 
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
                                                                 <asp:LinkButton Text='<%# Eval("Name") %>' runat="server" ID="Label3" CommandArgument='<%# Eval("intId")+"-"+Eval("varPersonneId")+"-"+Eval("intPersonelRole") %>' CommandName="viewprofile" /></td> 
                                                                <td> <asp:Label Text='<%# Eval("varDate") %>' runat="server" ID="Label1" /></td>
                                                             <td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="Type" /></td>
                                                             <td>         <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                                 <td> <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="varStartDate" CssClass='<%# Eval("varStatus").ToString() == "Processed" ? "label label-success" :Eval("varStatus").ToString()=="Resolved"? "label label-primary":"label label-warning" %>' /></td>
                                                            
                                                              <td> <asp:Label Text='<%# Eval("varProceedDate") %>' runat="server" ID="Label2" /></td>
                                                               <%--  <td class="text-center"> <asp:LinkButton  ID="LinkButton2" CommandArgument='<%# Eval("intId")+"-"+Eval("varPersonneId")+"-"+Eval("intPersonelRole") %>' CommandName="New"  runat="server"  CssClass=" fa fa-exclamation-circle" style="color:#ff8f00"/>   --%>
                                                             <td class="text-center"> <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId")+"-"+Eval("varPersonneId")+"-"+Eval("intPersonelRole") %>' CommandName="Processed"  runat="server" ToolTip="Processed"  CssClass=" fa fa-check" style="color:#558b2f"/></td>
                                                              <td class="text-center">  <asp:LinkButton  ID="LinkButton1" CommandArgument='<%# Eval("intId")+"-"+Eval("varPersonneId")+"-"+Eval("intPersonelRole") %>' CommandName="Resolved"  runat="server" ToolTip="Resolved"  CssClass=" fa fa-thumbs-up" style="color:#03a9f4"/>   
                                                           </td>
                                                             </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                                <th id="Th10" runat="server">Name</th>
                                                                              <th id="Th5" runat="server">Created Date</th>
                                                                             <th id="Th3" runat="server">Subject</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                                <th id="Th6" runat="server">Status</th> 
                                                                                   
                                                                                   <th id="Th7" runat="server">Modify Date</th> 
                                                                        
                                                                              <th colspan="3" id="Th1" runat="server" >Operation</th>
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
                          </div>
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstRequests" PageSize="10">
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

