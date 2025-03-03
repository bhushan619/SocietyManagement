﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="EventAndAnouncement.aspx.cs" Inherits="Society_Extras_EventAndAnouncement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div class="row">
		<div class="col-lg-12 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2> Event & Anouncement Information</h2>
				</div>
				<div class="panel-body">

					<div  class="form-horizontal">
                    <div class="col-md-6">  
                           <%-- <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Event Type</label>
									<div class="col-sm-8">
										<asp:DropDownList ID="ddlEventType" runat="server" CssClass="form-control" required="required">
                                                    <asp:ListItem Value="">:: Select Event Type ::</asp:ListItem>                                                   
                                                </asp:DropDownList>
									</div>									
								</div> --%>
                        
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Event Title</label>  
									<div class="col-sm-8">
										<asp:TextBox ID="txtTitle" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control"  required="required"></asp:TextBox>
									</div>
									
								</div> 
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Description</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtDescription" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control" TextMode="MultiLine" required="required"></asp:TextBox>
									</div>
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Start Date</label>
									<div class="col-sm-8">
											<div class="input-group">
														<span class="input-group-addon">
															<i class="fa fa-calendar"></i>
														</span>
                                                        <asp:TextBox ID="txtStartDate" runat="server"  CssClass="form-control" required="required"></asp:TextBox>	
                                             </div>
									</div>									
								</div>    
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Start Time</label>
									<div class="col-sm-8">
											<div class="input-group">
														<span class="input-group-addon">
															<i class="fa fa-clock-o"></i>
														</span>  
                                                        <asp:TextBox ID="txtStartTime" runat="server"  CssClass="form-control"></asp:TextBox>	
                                             </div>
									</div>									
								</div>    
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">End Date</label>
									<div class="col-sm-8">
											<div class="input-group">
														<span class="input-group-addon">
															<i class="fa fa-calendar"></i>
														</span>
                                                        <asp:TextBox ID="txtEndDate" runat="server"  CssClass="form-control"></asp:TextBox>	
                                             </div>
									</div>									
								</div> 
                          
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">End Time</label>
									<div class="col-sm-8">
											<div class="input-group">
														<span class="input-group-addon">
															<i class="fa fa-clock-o"></i>
														</span>
                                                        <asp:TextBox ID="txtEndTime" runat="server"  CssClass="form-control"></asp:TextBox>	
                                             </div>
									</div>									
								</div>  
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Contact Name </label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtEContactName" runat="server" CssClass="form-control"  onkeyup="checkText(this);" required="required"></asp:TextBox>
									</div>
									
								</div>
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> Mobile Number</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtEMobile" runat="server" CssClass="form-control" MaxLength="12"  required="required" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:TextBox>
									</div>
									
								</div>
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> Email</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtEEmail" runat="server" CssClass="form-control" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
									</div>									
								</div>
                     
                        </div>  
                        <div class="col-md-6">
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">County</label>                                          
									<div class="col-sm-8">
										            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control"  required="required" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem Value="">:: Select Country ::</asp:ListItem> </asp:DropDownList>
									</div>
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">State</label>
									<div class="col-sm-8">
										           <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control"  required="required"  OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem Value="">:: Select State ::</asp:ListItem>
                                                   
                                                </asp:DropDownList>													
									</div>									
								</div>  
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">City</label>
									<div class="col-sm-8">
										         <asp:DropDownList ID="ddlCity" runat="server"  required="required" CssClass="form-control">
                                                    <asp:ListItem Value="">:: Select City ::</asp:ListItem>                                                   
                                                </asp:DropDownList>
									</div>
								</div>

                             <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Event Location</label>  
									<div class="col-sm-8">
										<asp:TextBox ID="txtEventLocation" runat="server" CssClass="form-control" onkeyup="checkTextNum(this);" TextMode="MultiLine"  required="required"></asp:TextBox>
									</div>
									
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> Pin/Zip Code</label>
									<div class="col-sm-8">
										               <asp:TextBox ID="txtPinZip" runat="server" CssClass="form-control" MaxLength="6"  onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')"></asp:TextBox>
									</div>									
								</div>     
                             <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> Event Capacity</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtEventCapacity" runat="server" CssClass="form-control" onkeyup="checkTextNum(this);" ></asp:TextBox>
									</div>
									
								</div>
                           
                           <div class="form-group">
									<label  for="inputPassword1" class=" col-sm-3 control-label">Event Image</label>
									<div class="col-sm-5">
										      <input id="fupProPic" type="file" name="file" class="fileinput-new"  onchange="previewFile()"  runat="server" accept='image/*' />
                                        <br />	<label class="checkbox-inline">	  <asp:CheckBox ID="chkIsActive" runat="server"  /> Is Active 	 </label>
                                        <br />
                                         <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" Visible="false"  OnClick="btnUpdate_Click"/>
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="EventAndAnouncement.aspx" >Reset</a>
                                             </div> 	<div class="col-sm-4">
                                         <asp:Image ID="ImgProfile" CssClass="fileupload-preview thumbnail" style="width: 120px; height: 120px;float:none"  runat="server" ImageUrl="~/Society/Media/Event/NoProfile.png" />
                                       </div>
								
								</div>
                         
                          <script type="text/javascript">
                              function previewFile() {

                                  var preview = document.querySelector('#<%=ImgProfile.ClientID %>');
                                  var file = document.querySelector('#<%=fupProPic.ClientID %>').files[0];
                                  var reader = new FileReader();

                                  reader.onloadend = function () {
                                      preview.src = reader.result;
                                  }

                                  if (file) {
                                      reader.readAsDataURL(file);
                                  } else {
                                      preview.src = "";
                                  }
                              }
                              </script>

                     
                          <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
					</div> 
					</div>
					
				</div>
				
			</div>
		</div>
        <div class="col-lg-12 ">
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
                                                                 <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="Type" /></td>
                                                             <td>         <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                                  <td>         <asp:Label Text='<%# Eval("varStartDate") %>' runat="server" ID="varStartDate" /></td>
                                                              <td>
                                                                 <asp:Label Text='<%# Eval("intIsActive") %>' runat="server" ID="IsActive" /></td>
                                                           <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                            
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Event Title</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                                <th id="Th6" runat="server">Event Date</th>
                                                                             <th id="Th5" runat="server">IsActive</th>
                                                                              <th id="Th1" runat="server" >Operation</th>
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
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





