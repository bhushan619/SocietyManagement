<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/masterpage.master" AutoEventWireup="true" CodeFile="AddProperty.aspx.cs" Inherits="Society_Admin_Property_AddProperty" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <script type="text/javascript">         

          $(document).ready(function () {

              $('#ContentPlaceHolder1_txtAltMobileNos').keyup(function () {
                  var el = $(this),
                      val = el.val();

                  el.val(val.replace(/[^\d\;]/gi, ""));
              }).blur(function () {
                  $(this).keyup();
              });
          });
</script>
      <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Add Property</h2>
				</div>
				<div class="panel-body">
                      <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
					<div  class="form-horizontal">
                      <div runat="server" id="myproerty">
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Wing</label>
									<div class="col-sm-8">
										<asp:DropDownList ID="ddlWing"  runat="server" CssClass="form-control"  required="required">
                               <asp:ListItem>:: Select  Wing ::</asp:ListItem>                                                      
                           </asp:DropDownList>
									</div>									
								</div>   
                         
                         <div class="form-group">
                             
									<label for="focusedinput" class="col-sm-4   control-label">Premises</label>
                                                
									<div class="col-sm-8">
										   <asp:DropDownList ID="ddlPremises" AutoPostBack="true"  runat="server" CssClass="form-control"  required="required" OnSelectedIndexChanged="ddlPremises_SelectedIndexChanged">
                               <asp:ListItem>:: Select Premises ::</asp:ListItem>                                                      
                           </asp:DropDownList>	</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Premises Type</label>
                                       
									<div class="col-sm-8">
										        <asp:DropDownList ID="ddlPremisesType"   runat="server" CssClass="form-control"  required="required">
                               <asp:ListItem>:: Select Premises Type ::</asp:ListItem>                                                      
                           </asp:DropDownList></div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Property/Flat Number</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtflatno" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control" required="required" OnTextChanged="txtflatno_TextChanged" AutoPostBack="true"></asp:TextBox>
									</div>									
								</div>
                             <div class="form-group">
									    <label for="focusedinput" class="col-sm-4   control-label">Extension Number</label>
									    <div class="col-sm-8">
										           <asp:TextBox ID="txtPropertyExtensionNumber" onkeyup="checkTextNum(this);" required="required" runat="server" CssClass="form-control" OnTextChanged="txtPropertyExtensionNumber_TextChanged" AutoPostBack="true"></asp:TextBox>
									    </div>									
								    </div>
                        </div>
                       <div class="about-area">
						      	<h4>Owner Information</h4>
                            </div>
                             <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Owner Full Name</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtowner" runat="server" onkeyup="checkText(this);" CssClass="form-control" required="required"></asp:TextBox>
									</div>									
								</div>
                       <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">     Gender</label>
                                                      
									<div class="col-sm-8">
										 <asp:RadioButton ID="rgbMale" runat="server" Text="Male" CssClass="radio-inline" GroupName="g"/> &nbsp;&nbsp;
                                             <asp:RadioButton ID="rgbFemale" runat="server" CssClass="radio-inline" Text="Female" GroupName="g"/>
                                                
									</div>
									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Phone Number</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtphone" runat="server" CssClass="form-control" MaxLength="12" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:TextBox>
									</div>									
								</div>
                             <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Primary Mobile Number</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" required="required" MaxLength="12" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:TextBox>
									</div>									
								</div>
                        
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Other Mobile Numbers</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtAltMobileNos" runat="server"   CssClass="form-control"  onkeyup="checkOtherMobWithSemicolon(this);"  ></asp:TextBox>
                                        <small>(Ex. 999999999;88888888;77777777)</small>
									</div>									
								</div>
               <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Primary Email-Id</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" required="required"  pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
									</div>									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Other Email-Ids</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtAltEmailIds" runat="server" CssClass="form-control" placeholder="Alternate Email Ids Seprated By ';'"   ></asp:TextBox>
                                                  <small>(Ex.mail@example.com;myname@mydomain.com)</small>
									</div>									
								</div>
                         
                        <%-- <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Username</label>										
                                       
									<div class="col-sm-8">
										      <div class="input-group input-group-icon">
															<span class="input-group-addon">
																<span class="icon"><i class="fa fa-user"></i></span>
															</span>
															<asp:TextBox ID="txtUsername" runat="server" ReadOnly="true" CssClass="form-control" required="required" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
														</div>
									</div>
									
								</div>--%>
                         
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
                                		<div class="col-sm-4  "></div>	
									<div class="col-sm-8">
									<label class="checkbox-inline">	  <asp:CheckBox ID="chkIsActive" runat="server"  /> Is Active 	 </label>
									</div>
                                </div>
							
                        <div class="form-group">
									<div class="col-sm-4  "></div>
									<div class="col-sm-8">
									  <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" Visible="false"  OnClick="btnUpdate_Click"/>
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddProperty.aspx" >Reset</a>
									</div>
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
                                                                 <asp:Label Text='<%# Eval("varPropertyCode") %>' runat="server" ID="Type" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("varName") %>' runat="server" ID="Description" /></td>
                                                               <td>
                                                                 <asp:Label Text='<%# Eval("varMobile") %>' runat="server" ID="varMobile" /></td>
                                                              <td>
                                                                 <asp:Label Text='<%# Eval("intIsActive") %>' runat="server" ID="IsActive" /></td>
                                                           <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                            
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Flat Number</th>
                                                                             <th id="Th4" runat="server">Name</th>
                                                                              <th id="Th6" runat="server">Mobile</th>
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
 