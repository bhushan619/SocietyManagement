<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="Notifications.aspx.cs" Inherits="Society_Common_Notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="row">
		<div class="col-md-12 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Notification Information</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
                          <div class="form-group text-right">
      <asp:LinkButton ID="btnReadAll" runat="server" CssClass="btn btn-success btn-xs"  Text="Mark all as read" OnClick="btnReadAll_Click" />&nbsp;&nbsp;
                  <asp:LinkButton ID="lnkDeleteAll" CssClass="btn btn-danger btn-xs"  runat="server" Text="Delete all" OnClick="lnkDeleteAll_Click" />  

                         
                  
                    </div>
                 <div  class="table-responsive">   
 <asp:ListView ID="lstNotification" runat="server" 
                                DataSourceID="SqlDataSourceNotifications" DataKeyNames="intId" 
                                onitemcommand="lstNotification_ItemCommand" 
                               onpagepropertieschanging="lstNotification_PagePropertiesChanging" 
                           > 
                              
                                                       <EmptyDataTemplate>
                                                         <table id="Table1" runat="server"  CssClass="table table-bordered table-hover">
                                                             <tr >
                                                               <td  >
                                                                 	<div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No New Notification Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                </div>
                                                               </td>
                                                              </tr>
                                                         </table>
                                                     </EmptyDataTemplate> 
                                <ItemTemplate> 
                                        	<div class='<%# Eval("varStatus").ToString() == "Unread" ? "alert alert-dismissable alert-danger" : "alert alert-dismissable alert-success" %>' >
						<i class="ti ti-check"></i>&nbsp;   <asp:LinkButton ID="varNotTextLabel" runat="server"  CommandName="Views"   
                                            CommandArgument='<%#Eval("intId")+","+Eval("varLink")+","+Eval("intNotFromId")+","+Eval("varRemark")+","+Eval("varNotType")+","+Eval("varNotText")%>'
                                                Text='<%# Eval("varNotText") %>' />       
					                            </div> 
                                </ItemTemplate>
                                <LayoutTemplate> 
                                                <div ID="itemPlaceholderContainer" runat="server"   > 
                                                    <div ID="itemPlaceholder" runat="server">
                                                    </div>
                                                </div>
                                        
                                </LayoutTemplate>
                                  
                            </asp:ListView>
                     </div>
                            <asp:SqlDataSource ID="SqlDataSourceNotifications" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                              >
                                 
                            </asp:SqlDataSource>
                                                                               
</div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstNotification" PageSize="10">
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
            </div> </div>
</asp:Content>

