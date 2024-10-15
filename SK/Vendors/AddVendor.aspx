<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeFile="AddVendor.aspx.cs" Inherits="SK_Vendors_AddVendor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row">
		<div class="col-md-12 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Add Vendor</h2>
				</div>
				<div class="panel-body">
                    
					<div  class="form-horizontal"> 
                        <div class="col-lg-6">
                       
                        <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Full Name</label>
						    <div class="col-sm-8">
								     <asp:TextBox ID="txtFirstName" runat="server" onkeyup="checkTextInvertedComma(this);" required="required" CssClass="form-control"></asp:TextBox>
						    </div> 
						 </div>
                     
                        <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Contact Person</label>
						    <div class="col-sm-8">
								     <asp:TextBox ID="txtContactName" runat="server" onkeyup="checkTextInvertedComma(this);" CssClass="form-control"></asp:TextBox>
						    </div> 
						 </div>
                        <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Mobile Number</label>
						    <div class="col-sm-8">
								    <asp:TextBox ID="txtMobile" runat="server" required="required" CssClass="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')"></asp:TextBox>
						    </div> 
						 </div>
                        <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Phone Number</label>
						    <div class="col-sm-8">
								    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')"></asp:TextBox>
						    </div> 
						 </div>
                        <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Email-Id</label>
						    <div class="col-sm-8">
								    <asp:TextBox ID="txtEmail" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)"   runat="server" required="required" CssClass="form-control"></asp:TextBox>
						    </div> 
						 </div>
                      <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">About Us</label>
						    <div class="col-sm-8">
								   <asp:TextBox ID="txtAbout" runat="server" CssClass="form-control" onkeyup="checkText(this);" TextMode="MultiLine"></asp:TextBox>
						    </div> 
						 </div>
                             <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Select Service</label>
						    <div class="col-sm-8">
								     <asp:DropDownList ID="ddlService" runat="server"    class="form-control"  required="required" AppendDataBoundItems="true">
        <asp:ListItem Value="">:: Select Service ::</asp:ListItem>
                                </asp:DropDownList>
						    </div> 
						 </div>
                             <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Description of Service</label>
						    <div class="col-sm-8">
								   <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" onkeyup="checkTextInvertedCommaNum(this);"></asp:TextBox>
						    </div> 
						 </div>
                   <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Visiting Charges</label>
						    <div class="col-sm-8">
								     <asp:TextBox ID="txtVisitCharges" runat="server" required="required" CssClass="form-control" onkeyup="checkTextInvertedCommaNum(this);"></asp:TextBox>
						    </div> 
						 </div>
                      </div>
                        <div class="col-lg-6">
                                     <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Country</label>
						    <div class="col-sm-8">
								     <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>:: Select Country ::</asp:ListItem> </asp:DropDownList>
						    </div> 
						 </div>
                        <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">State</label>
						    <div class="col-sm-8">
								<asp:DropDownList ID="ddlState" runat="server" 
                        OnSelectedIndexChanged="state_SelectedIndexChanged" AutoPostBack="True" 
                         CssClass="form-control" required="required" AppendDataBoundItems="true">
                                     <asp:ListItem Value="">:: Select State ::</asp:ListItem>
                    </asp:DropDownList>
						    </div> 
						 </div>
                            <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">City</label>
						    <div class="col-sm-8">
								     <asp:DropDownList ID="cmbcity" runat="server"    class="form-control"  required="required" AppendDataBoundItems="true">
        <asp:ListItem Value="">:: Select City ::</asp:ListItem>
                                </asp:DropDownList>
						    </div> 
						 </div>
                        <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Pin/Zip Code</label>
						    <div class="col-sm-8">
								     <asp:TextBox ID="txtPin" runat="server" CssClass="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')"></asp:TextBox>
						    </div> 
						 </div>
                      
                      
                        <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Address</label>
						    <div class="col-sm-8">
								   <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" onkeyup="checkTextInvertedCommaNum(this);"></asp:TextBox>
						    </div> 
						 </div>
                              <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Neighbourhood</label>
						    <div class="col-sm-8">
								     <asp:TextBox ID="txtNeighbourhood" runat="server" CssClass="form-control" onkeyup="checkTextInvertedCommaNum(this);"></asp:TextBox>
						    </div> 
						 </div> 
                       
                        <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Username(EmailId)</label>
						    <div class="col-sm-8">
								 <asp:TextBox ID="txtUsername" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)"   required="required" runat="server" CssClass="form-control"></asp:TextBox>
						    </div> 
						 </div>
                        <div class="form-group">
						    <label for="focusedinput" class="col-sm-4   control-label">Password</label>
						    <div class="col-sm-8">
								   <asp:TextBox ID="txtPassword" runat="server" required="required" CssClass="form-control" TextMode="Password"></asp:TextBox>
						    </div> 
						 </div>
                        
                             <div class="form-group">
						    <label for="focusedinput" class="col-sm-4 control-label">Image</label>
						    <div class="col-sm-5">
							              <input id="fupProPic" title=" " type="file" name="file" class="fileinput-new"  onchange="previewFile()"  runat="server" accept='image/*' />
                                <br />
                                	<asp:CheckBox ID="chkIsActive" runat="server" />  	
																<label class="control-label">Is Active</label>	 
                                     	  <br /> <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" Visible="false"  OnClick="btnUpdate_Click"/>
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddVendor.aspx" >Reset</a>	</div>   <div class="col-sm-2">
                                               <asp:Image ID="ImgProfile" CssClass="fileupload-preview thumbnail" style="width: 120px; height: 120px;float:none"  runat="server" ImageUrl="~/Services/Vendor/VendorImages/NoProfile.png" />
                                        	</div>
						    </div> 
						 </div>
                               <div class="form-group">
								
									<div class="col-sm-6 col-offset-sm-3">
								  <div id="divMessage"  runat="server"><asp:Label id="lblMessage"   runat="server" /></div>   
								</div>
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
                       </div>   
                 
					</div>
					
				</div>
				
			</div>
 <div class="row">
        <div class="col-md-12 ">
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
                    <asp:ListView ID="lstVendors" runat="server" OnItemCommand="lstVendors_ItemCommand" OnPagePropertiesChanging="OnPagePropertiesChanging" DataKeyNames="intId">

                         
                         
                        <EmptyDataTemplate>
                            <table runat="server" style="">
                                <tr>
                                    <td>No data was returned.</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>

                         
                        <ItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("[Contact Person]") %>' runat="server" ID="Contact_PersonLabel" /></td>
                                          <td>
                                    <asp:Label Text='<%# Eval("[Service Name]") %>' runat="server" ID="Service_NameLabel" /></td>
                                 <td>
                                    <asp:Label Text='<%# Eval("[Ph no]") %>' runat="server" ID="Ph_noLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("Mobile") %>' runat="server" ID="MobileLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel" /></td>
                                <td>
                            <asp:Label Text='<%# Eval("StateName") %>' runat="server" ID="StateNameLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("CityName") %>' runat="server" ID="CityNameLabel" /></td>
                                  <td> <asp:Label Text='<%# Eval("varIsActive").ToString() == "1" ? "ACTIVE" :Eval("varIsActive").ToString()=="0"? "INACTIVE":"label label-warning" %>' runat="server" ID="varStartDate" CssClass='<%# Eval("varIsActive").ToString() == "1" ? "label label-success" :Eval("varIsActive").ToString()=="0"? "label label-danger":"label label-warning" %>'  /></td>
                                    <td  class="text-center"><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Edits"  runat="server"  ToolTip="Edit Full Details" CssClass=" fa  fa-edit"/></td>  
                                  </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                             
                                        <table runat="server" id="itemPlaceholderContainer" class="table table-bordered" style="" border="0">
                                            <tr runat="server" style="">
                                                <th runat="server">Name</th>
                                                <th runat="server">Contact Person</th> 
                                                <th runat="server">Service Name</th> 
                                                <th runat="server">Ph no</th>
                                                <th runat="server">Mobile</th>
                                                <th runat="server">Email</th>                                                  
                                                <th runat="server">State</th> 
                                                <th runat="server">City</th>
                                                <th runat="server">Status</th>
                                                <th runat="server">Edit</th>
                                            </tr>
                                            <tr runat="server" id="itemPlaceholder"></tr>
                                        </table>
                                     
                        </LayoutTemplate>

                         
                    </asp:ListView>
                     
                </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                     <asp:DataPager ID="DataPager1" runat="server" PagedControlID="lstVendors" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                            ShowNextPageButton="false" />
                        <asp:NumericPagerField ButtonType="Link" />
                        <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false" ShowPreviousPageButton = "false" />
                    </Fields>
                </asp:DataPager>
               </div>
                 </div>
                </div>
            </div>
 </div>
</asp:Content>

