<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="MyProfile.aspx.cs" Inherits="Society_Common_MyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function validateEmail(field) {
            //var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,5}$/;
            var regex = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;
            return (regex.test(field)) ? true : false;
        }

        function validateMultipleEmailsCommaSeparated(emailcntl, seperator) {
            var value = emailcntl.value;
            if (value != '') {
                var result = value.split(seperator);
                for (var i = 0; i < result.length; i++) {
                    if (result[i] != '') {
                        if (!validateEmail(result[i])) {
                            emailcntl.focus();
                            alert('Please check, `' + result[i] + '` email addresses not valid!');
                            return false;
                        }
                    }
                }
            }
            return true;
        }
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div data-widget-group="group1">
	<div class="row">
		<div class="col-sm-3">
			<div class="panel panel-default panel-profile">
                
			  <div class="panel-body">
			
                    <asp:Image ID="ImgProfile" CssClass="fileupload-preview  img-circle " Height="140px" Width="140px"   runat="server" ImageUrl="~/Society/Media/ProfilePhoto/NoProfile.png" />
			    <div class="name">
                    <asp:Label ID="lblPName" runat="server" Text=""></asp:Label></div>
			    <div class="info"> </div>
			    <ul class="list-inline text-center">
			    	<li><asp:HyperLink runat="server" ID="hppfb"  class="profile-facebook-icon" Target="_blank"><i class="ti ti-facebook"></i></asp:HyperLink></li>
			    	<li><asp:HyperLink runat="server" ID="hpptwitter" class="profile-twitter-icon" Target="_blank"><i class="ti ti-twitter"></i></asp:HyperLink></li>
			    	<li><asp:HyperLink runat="server" ID="hppgoogle" class="profile-dribbble-icon " Target="_blank"><i class="ti ti-google"></i></asp:HyperLink></li>
			    </ul>
			  </div>
			</div><!-- panel -->
			<asp:HiddenField ID="TabName" runat="server" /> 
                    <script type="text/javascript">
                        $(function () {
                            var tabName = $("[id*=ContentPlaceHolder1_TabName]").val() != "" ? $("[id*=ContentPlaceHolder1_TabName]").val() : "tab-about";
                            $('#Tabs a[href="#' + tabName + '"]').tab('show');
                            $("#Tabs a").click(function () {
                                $("[id*=ContentPlaceHolder1_TabName]").val($(this).attr("href").replace("#", ""));
                            });
                        });


</script>
             <div id="Tabs" role="tabpanel">
			<div class="list-group list-group-alternate mb-n nav nav-tabs">
                	<a href="#tab-about" aria-controls="tab-about"	role="tab" data-toggle="tab" class="list-group-item"><i class="ti ti-user"></i> About </a>
		<a href="#tab-photos" aria-controls="tab-photos"	role="tab" data-toggle="tab" class="list-group-item"><i class="ti ti-view-grid"></i> Photos</a>
				<a href="#tab-edit" aria-controls="tab-edit"	role="tab" data-toggle="tab" class="list-group-item"><i class="ti ti-pencil"></i> Edit Profile</a>
                		<a href="#tab-timeline" aria-controls="tab-timeline" role="tab" data-toggle="tab" class="list-group-item"><i class="ti ti-lock"></i> Change Password</a>
			</div>
                 </div>

		</div><!-- col-sm-3 -->
		<div class="col-sm-9">
			<div class="tab-content">
				 <!-- #tab-projects -->

				<div class="tab-pane active" id="tab-about">
					<div class="panel panel-default">
					    <%--<div class="panel-heading">
					    	<h2>About</h2>
					    </div>--%>
						<div class="panel-body">					      
							<div class="about-area">
						      	<h4><i class=" ti ti-tablet"></i>&nbsp;Basic Information</h4>
								    <div class="table-responsive">
								      <table class="table">
								        <tbody>
								        
								       
								        <%--  <tr>
								            <th>Phone Number</th>
								            <td>
                                                <asp:Label ID="lblpphone" runat="server" Text=""></asp:Label></td>
								          </tr>--%>
								          <tr>
								            <th>Mobile Number</th>
								            <td>
                                                <asp:Label ID="lblpPrimaryMobile" runat="server" Text=""></asp:Label></td>
								          </tr>
                                                <tr>
								            <th>Other Mobile</th>
								            <td>
                                                <asp:Label ID="lblpOtherMobile" runat="server" Text=""></asp:Label></td>
								          </tr>
								           <tr>
								            <th>Primary Email-ID</th>
								            <td>
                                                <asp:Label ID="lblpPrimaryEmail" runat="server" Text=""></asp:Label></td>
								          </tr>
                                               <tr>
								            <th>Other Email-IDs</th>
								            <td>
                                                <asp:Label ID="lblpOtheremail" runat="server" Text=""></asp:Label></td>
								          </tr>
								          <tr>
								            <th>Social Link</th>
								            <td>
								            	<ul class="list-inline m-n">								            	
								            		<li><asp:HyperLink runat="server" ID="hptwitter" Target="_blank" ><i class="ti ti-twitter"></i></asp:HyperLink></li>
								            		<li><asp:HyperLink runat="server" ID="hpgoogle" Target="_blank"><i class="ti ti-google"></i></asp:HyperLink></li>								            		
								            		<li><asp:HyperLink runat="server" ID="hpfb" Target="_blank"><i class="ti ti-facebook"></i></asp:HyperLink></li>
								            	</ul>
								            </td>
								          </tr>
								        </tbody>
								      </table>
								    </div>
							</div>
							<div class="about-area">
						      	<h4><i class=" ti ti-user"></i>&nbsp; Personal Information</h4>
								    <div class="table-responsive">
								      <table class="table about-table">
								        <tbody>
								          <tr>
								            <th>Full Name</th>
								            <td> <asp:Label ID="lblpFullName" runat="server" Text=""></asp:Label></td>
								          </tr>
								          <tr>
								            <th>Username</th>
								            <td>
                                                <asp:Label ID="lblpUsername" runat="server" Text=""></asp:Label></td>
								          </tr>
								          
								          <tr>
								            <th>Gender</th>
								            <td>
                                                <asp:Label ID="lblpGender" runat="server" Text=""></asp:Label></td>
								          </tr>
								         
								          <tr>
								            <th>Address</th>
								            <td>
                                                <asp:Label ID="lblpAddress" runat="server" Text="Label"></asp:Label></td>
								          </tr>								         
								        </tbody>
								      </table>
								    </div>
							</div>
						</div>
					</div>
				</div>

				<div class="tab-pane" id="tab-photos">				
    	                        <div class="panel"  >
						                    <div class="panel-heading">
							                    <h4><i class=" ti ti-gallery"></i>&nbsp; Image Gallary </h4>
                                             
						                    </div>
						                    <div class="panel-body profile-photos">	
                                                <div class="row ">					
                                                    <asp:ListView ID="LstGallary" runat="server" DataSourceID="sqlGallery"> 
                                                       <EmptyDataTemplate>
                                                                <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                                    <tr >
                                                                    <td  >
                                                                 	    <div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                    <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Gallary Images Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	                    
					                                                    </div>
                                                                    </td>
                                                                    </tr>
                                                                </table>
                                                               </EmptyDataTemplate>
                                                        <ItemTemplate>
                                                        	
							
                                                                <div  class="col-md-3 ">
									                    <asp:Image ID="imgSimilarPic" runat="server" CssClass="img-thumbnail img-responsive mb-xl fancybox"   Height="150px" Width="180px"   ImageUrl='<%# "~/Society/Media/Gallary/" + Eval("varGallaryImage") %>' />  <br />
								                   </div>

                                                        </ItemTemplate>
                                                        <LayoutTemplate>
                                      
                                                                <div runat="server" id="itemPlaceholderContainer">
                                                                    <div runat="server" id="itemPlaceholder"></div>
                                                                </div>
                                    
                                                            <div style="">
                                                            </div>
                                                        </LayoutTemplate>
                                     
                                                    </asp:ListView>
                            <asp:SqlDataSource ID="sqlGallery" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  >       
                             
                            </asp:SqlDataSource>
							                    </div>
							
						                    </div>
					                    </div>                       
				</div>

				 <div class="tab-pane" id="tab-edit">
					<div class="panel">
						<div class="panel-heading">
							<h4><i class=" ti  ti-pencil"></i>&nbsp; Edit Information</h4>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-md-12">
									<div class="form-horizontal "> <div class="form-group"> 
                                          
                                                        <div id="divMessage" class="col-sm-3" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                                                </div>
                                        <ul class="timeline">
                                             
										<li class="timeline-primary">
											<div class="timeline-icon"><i class="ti ti-user"></i></div>
											<div class="timeline-body">
                                                	<h4>Personal Information</h4>
                                                
										        <div class="form-group">
											        <label for="form-name" class="col-sm-3 control-label">Full Name</label>
											        <div class="col-sm-8 tabular-border">
												          <asp:TextBox ID="txtowner" runat="server" CssClass="form-control"  onkeyup="checkText(this);" required="required"></asp:TextBox>
											        </div>
										        </div>
                                            <div class="form-group">
									            <label for="focusedinput" class="col-sm-3   control-label">Username</label>	
									            <div class="col-sm-8">
										          <div class="input-group input-group-icon">
															    <span class="input-group-addon">
																    <span class="icon"><i class="fa fa-user"></i></span>
															    </span>
															    <asp:TextBox ID="txtUsername" runat="server"  CssClass="form-control" required="required"    ></asp:TextBox>
														    </div>
									                </div>
								            </div>
                                       
										    <div class="form-group">
											    <label for="form-name" class="col-sm-3 control-label">Gender</label>
											    <div class="col-sm-8 tabular-border">
													     <asp:RadioButton ID="rgbMale" runat="server" Text="Male" CssClass="radio-inline" GroupName="g"/> &nbsp;&nbsp;
                                                 <asp:RadioButton ID="rgbFemale" runat="server" CssClass="radio-inline" Text="Female" GroupName="g"/>
											    </div>
										    </div>
                                                   
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Police Verification Number</label>
                                       
									<div class="col-sm-8">
										         <asp:TextBox ID="txtPoliceVerify" runat="server" CssClass="form-control" onkeyup="checkTextNum(this);"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Marital Status</label>
                                                      
									<div class="col-sm-8">
										  <asp:RadioButton ID="rgbMarried" runat="server" GroupName="m" Text="Married" CssClass="radio-inline"/> &nbsp;&nbsp;
                                             <asp:RadioButton ID="rgbUnmarried" runat="server"  GroupName="m" CssClass="radio-inline" Text="Unmarried "/>
                                                
									</div>
									
								</div>
                                                      <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Father/Husband</label>
											 
                                       
									<div class="col-sm-8">
										       <asp:TextBox ID="txtFatherHusband" runat="server" CssClass="form-control" onkeyup="checkText(this);"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> Spouse Name</label>  
									<div class="col-sm-8">
										       <asp:TextBox ID="txtSpouse" runat="server" CssClass="form-control" onkeyup="checkText(this);"></asp:TextBox>
									</div>
								</div>
                                                 <div class="form-group">
									                    <label for="focusedinput" class="col-sm-3   control-label">Date Of Birth</label>
                                                        <div class="col-sm-8">										       
                                                                            <asp:TextBox ID="txtDOB" runat="server"   data-plugin-datepicker="data-plugin-datepicker" CssClass="form-control" required="required"></asp:TextBox>	
                                                         </div>
									
								                </div>
                                                    <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> PAN Number</label>   
									<div class="col-sm-8">
										          <asp:TextBox ID="txtPANNo" runat="server" CssClass="form-control" onkeyup="checkTextNum(this);"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">PF Number</label>
									<div class="col-sm-8">
										         <asp:TextBox ID="txtPFNo" runat="server" CssClass="form-control" onkeyup="checkTextNum(this);"></asp:TextBox>
									</div>
									
								</div>
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">ESI Number</label>
									<div class="col-sm-8">
										                    <asp:TextBox ID="txtESINo" runat="server" CssClass="form-control" onkeyup="checkTextNum(this);"></asp:TextBox>
									</div>
									
								</div>
                                      </div>

										</li>
                                            	<li class="timeline-warning">
											<div class="timeline-icon"><i class="fa fa-phone"></i></div>
											<div class="timeline-body">
                                                <h4>Contact Information</h4>
                                              <%--    <div class="form-group">
											            <label for="form-name" class="col-sm-3 control-label">Phone</label>
											            <div class="col-sm-8 tabular-border">
												               <asp:TextBox ID="txtphone" runat="server" CssClass="form-control" MaxLength="12" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:TextBox>
											            </div>
										            </div>--%>
                                                  <div class="form-group">
											            <label for="form-name" class="col-sm-3 control-label">Mobile</label>
											            <div class="col-sm-8 tabular-border">
											              <asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" required="required" MaxLength="12" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:TextBox>
											            </div>
										            </div>
                                                    <div class="form-group">
											            <label for="form-name" class="col-sm-3 control-label">Other Mobile</label>
											            <div class="col-sm-8 tabular-border">
											             <asp:TextBox ID="txtAltMobileNos" runat="server"   CssClass="form-control"  onkeyup="checkOtherMobWithSemicolon(this);"  ></asp:TextBox>
                                                        <small>(Ex. 999999999;88888888;77777777)</small>
											            </div>
										            </div>
                                                            <div class="form-group">
									                            <label for="focusedinput" class="col-sm-3   control-label">Primary Email-Id</label>
									                            <div class="col-sm-8 tabular-border">
										                                   <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" required="required"  pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
									                            </div>									
								                           </div>
                                                      <div class="form-group">
									                        <label for="focusedinput" class="col-sm-3   control-label">Other Email-Ids</label>
									                        <div class="col-sm-8 tabular-border">
										                               <asp:TextBox ID="txtAltEmailIds" runat="server" CssClass="form-control" onblur="validateMultipleEmailsCommaSeparated(this,';');" placeholder="Alternate Email Ids Seprated By ';'"   ></asp:TextBox>
                                                                          <small>(Ex. mail@example.com;myname@mydomain.com)</small>
									                        </div>									
								                        </div>
                                                  <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Country</label>                                          
									<div class="col-sm-8">
										            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>:: Select Country ::</asp:ListItem> </asp:DropDownList>
									</div>
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">State</label>
									<div class="col-sm-8">
										           <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>:: Select State ::</asp:ListItem>
                                                   
                                                </asp:DropDownList>													
									</div>									
								</div>  
                         
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">City</label>
									<div class="col-sm-8">
										         <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-control">
                                                    <asp:ListItem>:: Select City ::</asp:ListItem>                                                   
                                                </asp:DropDownList>
									</div>
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> Pin/Zip Code</label>
									<div class="col-sm-8">
										               <asp:TextBox ID="txtPinZip" runat="server" CssClass="form-control" MaxLength="6" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')"></asp:TextBox>
									</div>									
								</div>
                          <div class="form-group">
											    <label for="form-name" class="col-sm-3 control-label">Address</label>
											    <div class="col-sm-8 tabular-border">
                                                	      <asp:TextBox ID="txtaddress" runat="server" CssClass="form-control" onkeyup="checkTextNum(this);" TextMode="MultiLine"></asp:TextBox>
                                                    </div>
										    </div>
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Permanent  Address</label>
									<div class="col-sm-8">
										        <asp:TextBox ID="txtPermanentAddress" runat="server" CssClass="form-control" onkeyup="checkTextNum(this);" TextMode="MultiLine"></asp:TextBox>
									
									</div>
									
								</div>
                                       </div>

                                            	</li>
								<li class="timeline-info">
											<div class="timeline-icon"><i class="fa fa-dribbble"></i></div>
											<div class="timeline-body">
                                                <h4>Social Information</h4>
                                        	            <div class="form-group">
											                <label for="form-website" class="col-sm-3 control-label">Facebook Link</label>
											                <div class="col-sm-8 tabular-border">
                                                                <asp:TextBox ID="txtfb" runat="server"  type="url" class="form-control" pattern="^http(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(\/?)([a-zA-Z0-9\-\.\?\,\'\/\\\+&amp;%\$#_]*)?$" ></asp:TextBox>
                                                                    <small>(Ex. http://fb.com/Societykatta)</small>
											                </div>
										            </div>
                                        	<div class="form-group">
											    <label for="form-website" class="col-sm-3 control-label">Google Plus Link</label>
											    <div class="col-sm-8 tabular-border">
												         <asp:TextBox ID="txtgoogle" runat="server"  type="url" class="form-control"  pattern="^http(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(\/?)([a-zA-Z0-9\-\.\?\,\'\/\\\+&amp;%\$#_]*)?$"></asp:TextBox>
                                                            <small>(Ex. http://plus.google.com/Societykatta)</small>
											    </div>
										    </div>
                                        	<div class="form-group">
											    <label for="form-website" class="col-sm-3 control-label">Twitter Link</label>
											    <div class="col-sm-8 tabular-border">
												         <asp:TextBox ID="txttwitter" runat="server"  type="url" class="form-control" pattern="^http(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(\/?)([a-zA-Z0-9\-\.\?\,\'\/\\\+&amp;%\$#_]*)?$" ></asp:TextBox>
                                                            <small>(Ex. http://twiiter.com/Societykatta)</small>
											    </div>
										</div>
									</div>
                                    </li>
	                                <li class="timeline-danger">
									<div class="timeline-icon"><i class="ti ti-camera"></i></div>
									<div class="timeline-body">
                                        <h4>Profile Photo</h4>
                                            <div class="form-group">
									                    <label  for="inputPassword1" class=" col-sm-3 control-label"> Upload Photo</label>
									                    <div class="col-sm-4 tabular-border">
										                          <input id="fupProPic" type="file" name="file" class="fileinput-new"  onchange="previewFile()"  runat="server" accept='image/*' />
                                                      <br />  
                                                             <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                       
									                    <a class="btn-default btn" href="MyProfile.aspx" >Reset</a>
                                                     </div> 
                                            	    <div class="col-sm-4 text-right">
                                                         <asp:Image ID="imguploadpic" CssClass="fileupload-preview thumbnail" style="width: 120px; height: 120px;float:none"  runat="server" ImageUrl="~/Society/Media/ProfilePhoto/NoProfile.png" />
                                                     </div>
                                                </div>
                                               
                                            <script type="text/javascript">
                                                function previewFile() {

                                                    var preview = document.querySelector('#<%=imguploadpic.ClientID %>');
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
                            </li>
                           </ul>
								</div>
									</div>	
								</div>
							</div>
						</div>
						
					</div>

                <div class="tab-pane" id="tab-timeline">
					<div class="panel">
						<div class="panel-heading">
								<h4><i class=" ti  ti-lock"></i>&nbsp;Change Password</h4>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-md-12">
                                               
									<div class="form-horizontal ">
                                                	<div class="form-group">
											<label for="form-password" class="col-sm-3 control-label">Old Password</label>
											<div class="col-sm-8 tabular-border">
                                                <asp:TextBox ID="txtOld" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
											</div>
										</div>
												<div class="form-group">
											<label for="form-password" class="col-sm-3 control-label">New Password</label>
											<div class="col-sm-8 tabular-border">
											 <asp:TextBox ID="txtNew" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
											</div>
										</div>
										<div class="form-group">
											<label for="form-confirmpass" class="col-sm-3 control-label">Confrim Password</label>
											<div class="col-sm-8 tabular-border">
												 <asp:TextBox ID="txtNewCon" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
											</div>
										</div>
                                                	<div class="form-group">
											<label for="form-confirmpass" class="col-sm-3 control-label"></label>
											<div class="col-sm-8 tabular-border">
												 <asp:Button ID="btnpasschange" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnpasschange_Click"  />
											</div>
										</div>
                                         <div class="form-group"> 
                                          
                      <div id="divMessage1" class="col-sm-3" runat="server"><asp:Label id="lblMessage1" runat="server" /></div>
                    </div>
                                        </div>
                                    </div>
                                 
							</div>
						</div>
					</div>
				</div>
				</div>
        </div>
			</div><!-- .tab-content -->
		
	</div>
</asp:Content>

