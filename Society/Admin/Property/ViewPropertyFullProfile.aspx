<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/masterpage.master" AutoEventWireup="true" CodeFile="ViewPropertyFullProfile.aspx.cs" Inherits="Society_Admin_Property_ViewPropertyFullProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div data-widget-group="group1">
	<div class="row">
		<div class="col-sm-3">
			<div class="panel panel-profile">
                
			  <div class="panel-body">
			
                    <asp:Image ID="ImgProfile" CssClass="fileupload-preview  img-circle " Height="140px" Width="140px"   runat="server" ImageUrl="~/Society/Media/ProfilePhoto/NoProfile.png" />
			    <div class="name">
                    <asp:Label ID="lblPName" runat="server" Text=""></asp:Label></div>
			    <div class="info"> </div>
			    <ul class="list-inline text-center">
			    	<li><asp:HyperLink runat="server" ID="hppfb"  class="profile-facebook-icon" Target="_blank"><i class="ti ti-facebook"></i></asp:HyperLink></li>
			    	<li><asp:HyperLink runat="server" ID="hpptwitter" class="profile-twitter-icon" Target="_blank"><i class="ti ti-twitter"></i></asp:HyperLink></li>
			    	<li><asp:HyperLink runat="server" ID="hppgoogle" class="profile-dribbble-icon " Target="_blank"><i class="ti ti-google"></i></asp:HyperLink></li>
                    <li><asp:HyperLink runat="server" ID="HyperLink1" NavigateUrl="~/Society/Admin/Property/ViewPropertyList.aspx" class="profile-back-icon " ><i class="ti ti-back-left"></i></asp:HyperLink></li>
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
                	<a href="#tab-about" aria-controls="tab-about"	role="tab" data-toggle="tab" class="list-group-item "><i class="ti ti-user"></i> About </a>
		<a href="#tab-photos" aria-controls="tab-photos"	role="tab" data-toggle="tab" class="list-group-item"><i class="ti ti-view-grid"></i> Photos</a>
				<a href="#tab-edit" aria-controls="tab-edit"	role="tab" data-toggle="tab" class="list-group-item"><i class="fa fa-file-text-o"></i> Full Profile</a>
                	
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
						      	<h4><i class=" ti ti-tablet"></i>&nbsp; Basic Information</h4>
								    <div class="table-responsive">
								      <table class="table">
								        <tbody>
								        
								       
								          <tr>
								            <th>Phone Number</th>
								            <td>
                                                <asp:Label ID="lblpphone" runat="server" Text=""></asp:Label></td>
								          </tr>
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
				
    	                    <div class="panel "  >
						                    <div class="panel-heading">
							                    <h4><i class=" ti ti-gallery"></i>&nbsp; Image Gallary </h4>
                                             
						                    </div>
						                    <div class="panel-body profile-photos">	
                                                <div class="row ">	
                                                      <div class="table-responsive">				
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
                                                          </div>
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
							<h4><i class="fa fa-file-text-o"></i>&nbsp; View Information</h4>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-md-12">
									<div class="form-horizontal ">
                                        <ul class="timeline">
										<li class="timeline-primary">
											<div class="timeline-icon"><i class="ti ti-user"></i></div>
											<div class="timeline-body">
                                                	<h4>Personal Information</h4>
                                                 <table class="table about-table">
								        <tbody>
										        <tr><th>
											        <label for="form-name" class=" control-label">Full Name  </label></th> <td>
											     
												          <asp:Label ID="txtowner" runat="server" CssClass="" required="required"></asp:Label>
											      <tr><th>
									            <label for="focusedinput" class="   control-label">Username   </label></th> <td>
									           
															    <asp:Label ID="txtUsername" runat="server"  CssClass="" required="required"    ></asp:Label>
														  <tr><th>
											    <label for="form-name" class=" control-label">Gender   </label></th> <td>
											 
													     <asp:RadioButton ID="rgbMale" runat="server" Text="Male" CssClass="radio-inline" GroupName="g"/> &nbsp;&nbsp;
                                                 <asp:RadioButton ID="rgbFemale" runat="server" CssClass="radio-inline" Text="Female" GroupName="g"/>
											  <tr><th>
											    <label for="form-name" class=" control-label">Address   </label></th> <td>
											 
                                                	      <asp:Label ID="txtaddress" runat="server" CssClass="" TextMode="MultiLine"></asp:Label>
                                                  </td> </tr>
										 
                                            </tbody></table>
                                      </div>
                                           
										</li>
                                            	<li class="timeline-warning">
											<div class="timeline-icon"><i class="fa fa-phone"></i></div>
											<div class="timeline-body">
                                                <h4>Contact Information</h4>
                                                 <table class="table about-table">
								        <tbody>
                                                      <tr><th>
											            <label for="form-name" class=" control-label">Phone    </label></th> <td>
											         
												               <asp:Label ID="txtphone" runat="server" CssClass="" MaxLength="12" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:Label>
											           <tr><th>
											            <label for="form-name" class=" control-label">Mobile   </label>></th> <td>
											         
											              <asp:Label ID="txtmobile" runat="server" CssClass="" required="required" MaxLength="12" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:Label>
											         <tr><th>
											            <label for="form-name" class=" control-label">Other Mobile  </label></th> <td>
											         
											             <asp:Label ID="txtAltMobileNos" runat="server"   CssClass=""    ></asp:Label>
                                                     
											          <tr><th>
									                            <label for="focusedinput" class="   control-label">Primary Email-Id   </label></th> <td>
									                         
										                                   <asp:Label ID="txtEmail" runat="server" CssClass="" required="required"  pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:Label>
									                       <tr><th>
									                        <label for="focusedinput" class="   control-label">Other Email-Ids  </label></th> <td>
									                     
										                               <asp:Label ID="txtAltEmailIds" runat="server" CssClass="" placeholder="Alternate Email Ids Seprated By ';'"   ></asp:Label>
                                                                       
									                      </td> </tr>									
								                      
                                            </tbody></table>
                                  </div>

                                            	</li>
								<li class="timeline-info">
											<div class="timeline-icon"><i class="fa fa-dribbble"></i></div>
											<div class="timeline-body">
                                                <h4>Social Information</h4>
                                                 <table class="table about-table">
								        <tbody>
                                        	               <tr><th>
											                <label for="form-website" class=" control-label">Facebook Link  </label></th> <td>
											             
                                                                <asp:Label ID="txtfb" runat="server" class=""  ></asp:Label>
                                                                   
											              </td> </tr>
										          <tr><th>
                                        	 
											    <label for="form-website" class=" control-label">Google Plus Link  </label></th> <td>
											 
												         <asp:Label ID="txtgoogle" runat="server" class="" ></asp:Label>
                                                          
											   <tr><th>
                                    
											    <label for="form-website" class=" control-label">Twitter Link  </label></th> <td>
											 
												         <asp:Label ID="txttwitter" runat="server" class=""  ></asp:Label>
                                                        
											  </td> </tr> </tbody></table>
										</div>
                                           
                                    </li>
	                               
                           </ul>
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
	
</asp:Content>


