<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="AssignNotification.aspx.cs" Inherits="Society_Admin_Employee_AssignNotification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        
           <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Assign Notifications</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
 
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Select Personnel</label>
									<div class="col-sm-8">
										  <asp:DropDownList ID="ddlRole" runat="server"   CssClass="form-control" required="required"  AppendDataBoundItems="true"  >
                                                    <asp:ListItem Value="">:: Select Personnel ::</asp:ListItem>
                                                    
                                                  
                                                </asp:DropDownList>
									</div>
									
								</div> 
                       
                       <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">&nbsp; </label>
										
									<div class="col-sm-8">
                                           <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" OnClick="btnUpdate_Click"/>
                                        
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AssignNotification.aspx" >Reset</a>
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
                                                       <div class="table-responsive">
                                                 <asp:ListView ID="lstType" runat="server"  >
                                                 
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
                                                             <td>   <asp:Label Text='<%# Eval("EMP") %>' runat="server" ID="Type" /></td>
                                                               <td>   <asp:Label Text='<%# Eval("Mob") %>' runat="server" ID="Label1" /></td>
                                                            
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Name</th> 
                                                                                 <th id="Th4" runat="server">Mobi</th> 
                                                                           
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
               <asp:Label ID="lblroleid" runat="server" Text=""></asp:Label>
               <asp:Label ID="lblmemid" runat="server" Text=""></asp:Label>
               </div>
   
</asp:Content>

