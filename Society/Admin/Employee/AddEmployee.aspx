<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/masterpage.master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeFile="AddEmployee.aspx.cs" Inherits="Society_Admin_Employee_AddEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
          <div class=" col-md-6 form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
        </div>
           <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Add Employee</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
                      
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Type of employee</label>
									<div class="col-sm-8">
										<asp:DropDownList ID="ddlEmpType" AutoPostBack="true" OnSelectedIndexChanged="ddlEmpType_SelectedIndexChanged" runat="server" CssClass="form-control"  required="required">
                               <asp:ListItem>:: Select Employee Type ::</asp:ListItem>
                                                      
                           </asp:DropDownList>
									</div>
									
								</div>
                       
                        <div id="TypeOfEmp" runat="server" visible="false">
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Provider name</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtProviderName"  onkeyup="checkTextNum(this);" runat="server" CssClass="form-control"></asp:TextBox>
									</div>
									
								</div>
                            <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Provider Contact Person</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtPContactPerson" runat="server" CssClass="form-control" onkeyup="checkText(this);"></asp:TextBox>
									</div>
									
								</div>
                       
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Provider Contact Details</label>
                                           
									<div class="col-sm-8">
										<asp:TextBox ID="txtPcontactDetail" runat="server" CssClass="form-control"  onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12" ></asp:TextBox>  
									</div>
									
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Provider Address</label>
                                                
                                                
									<div class="col-sm-8">
										<asp:TextBox ID="txtpAddress" runat="server"  onkeyup="checkTextNum(this);" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
									</div>
									
								</div>
                         
                          </div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">  Employee Name</label>
                                                
									<div class="col-sm-8">
										    <asp:TextBox ID="txtEmpName" runat="server"  CssClass="form-control" onkeyup="checkText(this);" required="required"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Police Verification Number</label>
                                       
									<div class="col-sm-8">
										         <asp:TextBox ID="txtPoliceVerify" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Status</label>
                                                      
									<div class="col-sm-8">
										  <asp:RadioButton ID="rgbMarried" runat="server" GroupName="m" Text="Married" CssClass="radio-inline"/> &nbsp;&nbsp;
                                             <asp:RadioButton ID="rgbUnmarried" runat="server"  GroupName="m" CssClass="radio-inline" Text="Unmarried "/>
                                                
									</div>
									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Gender</label>
                                                      
									<div class="col-sm-8">
										 <asp:RadioButton ID="rgbMale" runat="server" GroupName="gender" Text="Male" CssClass="radio-inline"/> &nbsp;&nbsp;
                                             <asp:RadioButton ID="rgbFemale" runat="server" GroupName="gender" CssClass="radio-inline" Text="Female"/>
                                                
									</div>
									
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Father/Husband</label>
											 
                                       
									<div class="col-sm-8">
										       <asp:TextBox ID="txtFatherHusband" runat="server" onkeyup="checkText(this);" CssClass="form-control"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Spouse Name</label>
                                               
                                       
									<div class="col-sm-8">
										       <asp:TextBox ID="txtSpouse" runat="server" onkeyup="checkText(this);" CssClass="form-control"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Date Of Joining</label>
                                             
									<div class="col-sm-8">
										         
                                                        <asp:TextBox ID="txtDateofJoin" runat="server"  data-plugin-datepicker="data-plugin-datepicker"  CssClass="form-control"></asp:TextBox>	
													 
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Date Of Birth</label>
                                                                                     
									<div class="col-sm-8">										       
                                                        <asp:TextBox ID="txtDOB" runat="server" data-plugin-datepicker="data-plugin-datepicker" CssClass="form-control" required="required"></asp:TextBox>	
													 
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Primary Contact Number</label>                                                
                                       
									<div class="col-sm-8">
										      <asp:TextBox ID="txtPrimaryContact" runat="server" CssClass="form-control" required="required" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Contact Number(other)</label>
                                              
                                       
									<div class="col-sm-8">
										          <asp:TextBox ID="txtOtherContact" runat="server" CssClass="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12"></asp:TextBox>
						
									</div>
									
								</div>
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Primary Email-Id</label>
                                       
									<div class="col-sm-8">
															<asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" required="required" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
														
									</div>
									
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Other Email-Ids</label>
                                              
                                       
									<div class="col-sm-8">
										        <asp:TextBox ID="txtOtherEmail" runat="server" CssClass="form-control" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
									
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> PAN Number</label>
                                              
                                       
									<div class="col-sm-8">
										          <asp:TextBox ID="txtPANNo" runat="server" CssClass="form-control"  onkeyup="checkTextNum(this);"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label" >PF Number</label>
                                              
                                       
									<div class="col-sm-8">
										         <asp:TextBox ID="txtPFNo" runat="server"   onkeyup="checkTextNum(this);" CssClass="form-control"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">ESI Number</label>
                                     
                                       
									<div class="col-sm-8">
										                    <asp:TextBox ID="txtESINo"  onkeyup="checkTextNum(this);" runat="server" CssClass="form-control"></asp:TextBox>
									</div>
									
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">County</label>                                          
									<div class="col-sm-8">
										            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>:: Select Country ::</asp:ListItem> </asp:DropDownList>
									</div>
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">State</label>
									<div class="col-sm-8">
										           <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" required="required" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>:: Select State ::</asp:ListItem>
                                                   
                                                </asp:DropDownList>													
									</div>									
								</div>  
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">City</label>
									<div class="col-sm-8">
										         <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-control" required="required">
                                                    <asp:ListItem>:: Select City ::</asp:ListItem>                                                   
                                                </asp:DropDownList>
									</div>
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Pin/Zip Code</label>
									<div class="col-sm-8">
										               <asp:TextBox ID="txtPinZip" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="6"  runat="server" CssClass="form-control"></asp:TextBox>
									</div>									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Address</label>
                                               
									
                                       
									<div class="col-sm-8">
										       <asp:TextBox ID="txtAddress" runat="server"  onkeyup="checkTextNum(this);" CssClass="form-control" TextMode="MultiLine" ></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Permanent  Address</label>
                                              
                                       
									<div class="col-sm-8">
										        <asp:TextBox ID="txtPermanentAddress" runat="server"  onkeyup="checkTextNum(this);" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
									
									</div>
									
								</div>
                         
                       
                       
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Department</label>
                                             
                                       
									<div class="col-sm-8">
										        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control"  OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" AutoPostBack="true" required="required">
                                                    <asp:ListItem Value="">:: Select Department ::</asp:ListItem>
                                         
                                                  
                                                </asp:DropDownList>
									</div>
									
								</div>

                            <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Designation</label>
                                             
                                       
									<div class="col-sm-8">
                                      
                                          <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control" required="required"  AppendDataBoundItems="true">
                                                    <asp:ListItem Value="">:: Select Role ::</asp:ListItem>
                                                    
                                                  
                                                </asp:DropDownList>
                                             
										       
									</div>
									
								</div>
                          
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Password</label>
										
									<div class="col-sm-8">
										      	<div class="input-group input-group-icon">
															<span class="input-group-addon">
																<span class="icon"><i class="fa fa-key"></i></span>
															</span>
														 <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" required="required" TextMode="Password"></asp:TextBox>
														</div>
                                       
									</div>
									
								</div>

                         <div class="form-group">
									<label  for="inputPassword1" class=" col-sm-4 control-label">Employee Image</label>
									<div class="col-sm-4">
										      <input id="fupProPic" type="file" name="file" class="fileinput-new"  onchange="previewFile()"  runat="server" accept='image/*' />
                                        <br />	<label class="checkbox-inline">	  <asp:CheckBox ID="chkIsActive" runat="server"  /> Is Active 	 </label>
                                        <br />
                                         <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" Visible="false"  OnClick="btnUpdate_Click"/>
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddEmployee.aspx" >Reset</a>
                                             </div> 	<div class="col-sm-4">
                                         <asp:Image ID="ImgProfile" CssClass="fileupload-preview thumbnail" style="width: 120px; height: 120px;float:none"  runat="server" ImageUrl="~/Society/Media/ProfilePhoto/NoProfile.png" />
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
                              </script>      </div>
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
                                                             <td>   <asp:Label Text='<%# Eval("varEmpName") %>' runat="server" ID="Type" /></td>
                                                               <td>   <asp:Label Text='<%# Eval("varMbPrimary") %>' runat="server" ID="Label1" /></td>
                                                               <td> <asp:Label Text='<%# Eval("intIsActive") %>' runat="server" ID="IsActive" /></td>
                                                           <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                             <td><asp:LinkButton  ID="LinkButton1" CommandArgument='<%# Eval("intId") %>' CommandName="Delets"  runat="server"  CssClass=" fa fa-times"/></td>
                                                           
                                                            
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Name</th> 
                                                                                 <th id="Th4" runat="server">Mobile Number</th> 
                                                                             <th id="Th5" runat="server">IsActive</th>
                                                                              <th id="Th1" runat="server" colspan="2" >Operation</th>
                                                                       
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
