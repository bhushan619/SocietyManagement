<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="CustomerProfile.aspx.cs" Inherits="Home_CustomerProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
			<!-- main-container start -->
			<!-- ================ -->
			<section class="main-container">

				<div class="container">
					<div class="row">
                        <div class="woocommerce-billing-fields">
						<!-- main start -->
						<!-- ================ -->
						<div class="main col-md-12">

							<!-- page-title start -->
							<!-- ================ -->
							<h1 class="page-title">My Profile</h1>
							<div class="separator-2"></div>
							<!-- page-title end -->

							<div class="row">
									<div class="col-md-3"> 
									<div class="owl-carousel content-slider-with-large-controls">
										<div class="overlay-container overlay-visible">
										  <asp:Image ID="ImgProfilecust" CssClass="fileupload-preview thumbnail"  runat="server"  />
										
										</div> 
									</div> 
								</div>
								<div class="col-md-8 ">								
									<div class="">
											<div class="form-horizontal">
                                       <div id="divMessage" runat="server" class="text-center"  ><asp:Label id="lblMessage" runat="server"  ForeColor="White"/></div><br /> 
                                    <div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">Name</label>
										<div class="col-sm-8">
                                           <asp:TextBox ID="txtName" placeholder="Name" runat="server"  onkeyup="checkText(this);"  CssClass="form-control" required="required" ></asp:TextBox>   
                                            <i class="fa fa-user form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">Email</label>
										<div class="col-sm-8">
											   <asp:TextBox ID="txtEmail" placeholder="Email" runat="server" ReadOnly="true" CssClass="form-control" required="required" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)"  ></asp:TextBox>   
											<i class="fa fa-inbox form-control-feedback"></i>
										</div>
									</div>
                                    <div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">Mobile</label>
										<div class="col-sm-8">
											   <asp:TextBox ID="txtMobile" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12" placeholder="Mobile" runat="server" CssClass="form-control" required="required" ></asp:TextBox>   
											<i class="fa fa-mobile form-control-feedback"></i>
										</div>
									</div>
                                                 <div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">Landline</label>
										<div class="col-sm-8">
                                           <asp:TextBox ID="txtlandline"   onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="15" placeholder="Landline" runat="server" CssClass="form-control"  ></asp:TextBox>   
                                            <i class="fa fa-mobile form-control-feedback"></i>
										</div>
									</div><div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">County</label>                                          
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
                                                    <div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">Address</label>
										<div class="col-sm-8">
                                           <asp:TextBox ID="txtaddress" placeholder="Address" runat="server"  onkeyup="checkTextNum(this);" CssClass="form-control" required="required" ></asp:TextBox>   
                                            <i class="fa fa-map-marker form-control-feedback"></i>
										</div>
									</div>
                                                   
                                                    <div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">Landmark</label>
										<div class="col-sm-8">
                                           <asp:TextBox ID="txtLandmark" placeholder="Landmark" runat="server"  onkeyup="checkTextNum(this);" CssClass="form-control"  ></asp:TextBox>   
                                            <i class="fa fa-map-marker form-control-feedback"></i>
										</div>
									</div>
                                                  <%--  <div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">Neighbourhood</label>
										<div class="col-sm-8">
                                           <asp:TextBox ID="txtNeighbourhood" placeholder="Neighbourhood" runat="server" CssClass="form-control" required="required" ></asp:TextBox>   
                                            <i class="fa fa-map-marker form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label for="inputPassword" class="col-sm-3 control-label">Password</label>
										<div class="col-sm-8">
											<asp:TextBox ID="txtPassword" placeholder="Password" TextMode="Password" runat="server" CssClass="form-control"   ></asp:TextBox>   
											<i class="fa fa-lock form-control-feedback"></i>
										</div>
									</div>--%>
                                 
                                                 <div class="form-group has-feedback">
										<label for="inputPassword" class="col-sm-3 control-label">Profile Photo</label>
										<div class="col-sm-8">
										 <input id="fupProPic" type="file" name="file" class="fileinput-new"  onchange="previewFile()"  runat="server" accept='image/*' />          
										</div>
									</div>
                                          
    <script type="text/javascript">
                              function previewFile() {

                                  var preview = document.querySelector('#<%=ImgProfilecust.ClientID %>');
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
										<div class="col-sm-offset-3 col-sm-8">
											 
                                            <asp:Button ID="btnupdate" runat="server" Text="Update" OnClick="btnupdate_Click" CssClass="btn   btn-default " />	 
										 
										</div>
									</div>
									</div>
								
								</div>
							</div>
						</div>
						<!-- main end -->

					</div>
                            </div>
				</div>
			</section>
			<!-- main-container end -->

</asp:Content>

