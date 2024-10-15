<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="ViewFullEmpProfile.aspx.cs" Inherits="SK_Employee_ViewFullEmpProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    	<div class="row">
		<div class="col-sm-3">
			<div class="panel panel-default panel-profile">
                
			  <div class="panel-body">
			
                    <asp:Image ID="ImgProfile" CssClass="fileupload-preview  img-circle " Height="140px" Width="140px"   runat="server" ImageUrl="~/Society/Media/ProfilePhoto/NoProfile.png" />
			    <div class="name">
                    <asp:Label ID="lblPName" runat="server" Text=""></asp:Label></div>
			    <div class="info"><asp:Label ID="lblDepartment" runat="server" Text=""></asp:Label>&nbsp;( <asp:Label ID="lblRole" runat="server" Text=""></asp:Label> )</div>
			   
			  </div>
			</div>
            </div>
            <div class="col-sm-9">
    			<div class="panel panel-default">
					
						<div class="panel-body">
							<div class="row">
								<div class="col-md-12">
									<div class="form-horizontal ">
                                       	<div class="">
						      	<h4><i class=" ti ti-user"></i>&nbsp; Full Information</h4>
                                        <div class="table-responsive">
								      <table class="table">
								        <tbody>
										    <tr>
                                                <td> <label for="form-name" class=" control-label">Full Name</label>
											        </td><td>  <asp:Label ID="txtowner" runat="server" Class="control-label"  onkeyup="checkText(this);" required="required"></asp:Label>											       </td>
                                                </tr>
                                             <tr>
                                                 <td>	<label for="focusedinput" class="   control-label">Department</label>
									                </td><td> <asp:Label ID="lbldept" runat="server" Class="control-label" onkeyup="checkTextNum(this);"></asp:Label>
								                 </td>
                                             </tr>
                         
                                    <tr>
                                        <td><label for="focusedinput" class="   control-label">Role</label>
									</td><td>  <asp:Label ID="lblrol" runat="server" Class="control-label" onkeyup="checkTextNum(this);"></asp:Label>
									 </td>
                                 </tr>

                                        <tr>
                                            <td><label for="focusedinput" class="   control-label">Username</label>	
									            </td><td>  <asp:Label ID="txtUsername" runat="server"  Class="control-label"  required="required"    ></asp:Label>
													 </td>
                                            </tr>
                                       
										<tr>
                                            <td><label for="form-name" class=" control-label">Gender</label>
											    </td><td> <asp:Label ID="rgbMale" runat="server" > </asp:Label>
                                                </td>
                                            </tr>
                         
                                     <tr>
                                         <td><label for="focusedinput" class="   control-label">Marital Status</label></td>
                                         <td> <asp:Label ID="rgbMarried" runat="server" > </asp:Label></td>
                                   </tr>
                               <tr>
                                  <td><label for="focusedinput" class="   control-label">Father/Husband</label>
								    </td><td>  <asp:Label ID="txtFatherHusband" runat="server" Class="control-label" onkeyup="checkText(this);"></asp:Label>
									     </td>
                             </tr>   
                            <tr><td>  <label for="focusedinput" class="   control-label">Date Of Birth</label>
                                        </td><td>   <asp:Label ID="txtDOB" runat="server"    CssClass="control-label" required="required"></asp:Label>											       
                                        </td>
                            </tr>
                                <tr><td>
										<label for="form-name" class=" control-label">Mobile Number</label>
										</td><td>
											<asp:Label ID="txtmobile" runat="server" Class="control-label" required="required" MaxLength="12" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:Label>
										</td>
                                    </tr>
                                <tr>
                                    <td> <label for="form-name" class=" control-label">Other Mobile Numbers</label>
										</td><td>   <asp:Label ID="txtAltMobileNos" runat="server"   Class="control-label"  onkeyup="checkOtherMobWithSemicolon(this);"  ></asp:Label>
                                                </td>
                                    </tr>
                                        <tr>
                                            <td><label for="focusedinput" class="   control-label">Primary Email-Id</label>
									            </td><td>  <asp:Label ID="txtEmail" runat="server" Class="control-label" required="required"  pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:Label>
									            </td>
                                            </tr>
                                    <tr>
                                        <td> <label for="focusedinput" class="   control-label">Other Email-Ids</label>
									        </td><td> <asp:Label ID="txtAltEmailIds" runat="server" Class="control-label" onblur="validateMultipleEmailsCommaSeparated(this,';');" placeholder="Alternate Email Ids Seprated By ';'"   ></asp:Label>
                                            </td>
                                        </tr>
                                <tr>
                                    <td>	<label for="focusedinput" class="   control-label">Country</label>                                          
									</td><td><asp:Label ID="ddlCountry" runat="server" Text=""></asp:Label>
								    </td>
                                </tr>
                             <tr>
                                 <td><label for="focusedinput" class="   control-label">State</label>
									</td><td><asp:Label ID="ddlState" runat="server" Text=""></asp:Label>								         										        											
									 </td>
                           </tr>
                         
                             <tr>
                                <td><label for="focusedinput" class="   control-label">City</label>
									</td><td> <asp:Label ID="ddlCity" runat="server" Text=""></asp:Label> </td>
                           </tr>
                     <tr>
                         <td><label for="focusedinput" class="   control-label"> Pin/Zip Code</label>
									</td><td>    <asp:Label ID="txtPinZip" runat="server" Class="control-label" MaxLength="6" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')"></asp:Label>
								 </td>
                           </tr>
                         <tr>
                                 <td>  <label for="form-name" class=" control-label">Address</label>
							    </td><td> <asp:Label ID="txtaddress" runat="server" Class="control-label" onkeyup="checkTextNum(this);" TextMode="MultiLine"></asp:Label>
                                  </td>
                           </tr>
                             <tr>
                                  <td><label for="focusedinput" class="   control-label">Permanent  Address</label>
									</td><td>  <asp:Label ID="txtPermanentAddress" runat="server" Class="control-label" onkeyup="checkTextNum(this);" TextMode="MultiLine"></asp:Label>
								 </td>
                           </tr>
                                <tr><td><label for="focusedinput" class="   control-label"> PAN Number</label>   
									</td><td> <asp:Label ID="txtPANNo" runat="server" Class="control-label" onkeyup="checkTextNum(this);"></asp:Label>
									 </td>
                           </tr>
                         
                     <tr><td>	<label for="focusedinput" class="   control-label">PF Number</label>
									</td><td>  <asp:Label ID="txtPFNo" runat="server" Class="control-label" onkeyup="checkTextNum(this);"></asp:Label>
								 </td>
                           </tr>
                         
                     <tr><td><label for="focusedinput" class="   control-label">ESI Number</label>
									</td><td>    <asp:Label ID="txtESINo" runat="server" Class="control-label" onkeyup="checkTextNum(this);"></asp:Label>
									 </td>
                           </tr>
                                   </tbody>
								      </table>                   
                                       </div>
</div>
								
								</div>
									</div>	
								</div>
							</div>
						</div>
                </div>
            </div>
    
</asp:Content>

