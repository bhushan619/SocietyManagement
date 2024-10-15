<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="AddComplaints.aspx.cs" Inherits="Society_Common_AddComplaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="row">
		<div class="col-lg-12 "> 
             <div class="col-md-6"> 
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Add New Complaints</h2>
				</div>
				<div class="panel-body"> 
                    
                        <div  class="form-horizontal">
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> Subject</label>  
									<div class="col-sm-8">
										<asp:TextBox ID="txtTitle" runat="server" onkeyup="checkText(this);" CssClass="form-control"  required="required"></asp:TextBox>
									</div>
									
								</div> 
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Description</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtDescription" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control" TextMode="MultiLine" required="required"></asp:TextBox>
									</div>
								</div>   
                          <div class="form-group">
                              <label for="inputPassword" class="col-sm-3   control-label"></label>
								 		<div class="col-sm-8">
									      <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" Visible="false"  OnClick="btnUpdate_Click"/>
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddComplaints.aspx" >Reset</a>
                                             </div>   
								</div>
                        <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
                        </div>  
                    </div>
                      
					</div>
					
				
				
			</div>
            <div class="col-md-6"> 
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
                                                                 <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="Type" /></td>
                                                             <td>         <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                                    <td> <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="varStartDate" CssClass='<%# Eval("varStatus").ToString() == "Processed" ? "label label-success" :Eval("varStatus").ToString()=="Resolved"? "label label-primary":"label label-warning" %>' /></td>
                                                            
                                                               <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                              <td><asp:LinkButton  ID="lnkListDelete" CommandArgument='<%# Eval("intId") %>' CommandName="Delets"  runat="server"  CssClass=" fa fa-times" ToolTip="Delete"/></td>
                                                               </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Subject</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                                <th id="Th6" runat="server">Status</th> 
                                                                     
                                                                              <th id="Th1" runat="server" colspan="2" >Operation</th>
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
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
	</div>
     
</asp:Content>

