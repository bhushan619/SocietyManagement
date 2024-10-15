<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="ViewNoticeboard.aspx.cs" Inherits="Society_View_ViewNoticeboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row"> 
    	                <div class="panel panel-info"  data-widget='{"id" : "wiget6", "draggable": "false"}'>
			<div class="panel-heading">
				<h2><i class="ti ti-pin-alt"></i>NoticeBoard </h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''>
				</div>	
			</div>
						                    <div class="panel-body" >	
                                                <div class="row scroll-content">					
                                                    <asp:ListView ID="lstNoticeboard" runat="server" OnPagePropertiesChanging="OnPagePropertiesChanging">
                                                        <EmptyDataTemplate>
                                                            <table id="Table1" runat="server" style="width: 90%" cssclass="table table-bordered table-hover">
                                                                <tr>
                                                                    <td>
                                                                        <div class="alert alert-dismissable alert-info " style="width: 100%">
                                                                            <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..!!&nbsp;
						                                              	                    
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EmptyDataTemplate>
                                                                              <ItemTemplate>
                                                         <tr style="">
                                                            
                                                                   <td>  <asp:Label ID="lblSRNO" runat="server"  Text='<%#Container.DataItemIndex+1 %>'></asp:Label></td>
                                                              <td>
                                                                <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="Label3" /></td>
                                                              
                                                             <td> <asp:Label Text='<%# Eval("varSubject") %>'  runat="server" ID="varSubjectLabel" /></td>
                                                             <td>         <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                                 <td>   <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="IsActive"  CssClass='<%# Eval("varStatus").ToString() == "Approved" ? "label label-success" :Eval("varStatus").ToString()=="Rejected"? "label label-danger":"label label-warning" %>' /></td>
                                                            
                                                              <td><asp:Label Text='<%# Eval("varCreatedDate") %>' runat="server" ID="Label2" /></td>
                                                             
                                                           
                                                             </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                                <th id="Th10" runat="server">Name</th>
                                                                           
                                                                             <th id="Th3" runat="server">Subject</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                                <th id="Th6" runat="server">Status</th> 
                                                                                     <th id="Th5" runat="server">Created Date</th>
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>



                                                   
                                                </div>
							
						                    </div>
                            <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstNoticeboard" PageSize="10">
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

