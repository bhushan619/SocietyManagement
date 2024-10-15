<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="AddHelpline.aspx.cs" Inherits="Society_Admin_MasterData_AddHelpline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2> HelpLine Information</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
                      
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Helpline Name</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtHname" runat="server"  onkeyup="checkTextNum(this);" CssClass="form-control"  required="required"></asp:TextBox>
									</div>
									
								</div>
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> Helpline Number</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtHPhone" runat="server"    CssClass="form-control"  required="required"  MaxLength="12" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:TextBox>
									</div>
									
								</div>
                                 <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Contact Person</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtcontcatperson" onkeyup="checkText(this);" runat="server" CssClass="form-control" ></asp:TextBox>
									</div>
									
								</div>
                              
                                 <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Mobile Number</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" MaxLength="12" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:TextBox>
									</div>
									
								</div>
                                <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Email-Id</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtemail" runat="server"  CssClass="form-control" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
									</div>
									
								</div>        <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Address</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtaddress" runat="server"  onkeyup="checkTextNum(this);" CssClass="form-control"    TextMode="MultiLine"></asp:TextBox>
									</div>
									
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Description</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtDescription"  onkeyup="checkTextNum(this);" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
									</div>
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label"> Remarks</label>
									<div class="col-sm-8">
										 <asp:TextBox ID="txtRemark" runat="server"  onkeyup="checkTextNum(this);" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
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
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddHelpline.aspx" >Reset</a>
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
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("varHelplineName") %>' runat="server" ID="HelplineName" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("varHelpPhone") %>' runat="server" ID="HelplineNumber" /></td>
                                                              <td>
                                                                 <asp:Label Text='<%# Eval("intIsActive") %>' runat="server" ID="IsActive" /></td>
                                                           <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                            
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Helpline Name</th>
                                                                             <th id="Th4" runat="server">Helpline Number</th>
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


