<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="SK_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- main-container start -->
			<!-- ================ -->
			<div class="main-container dark-translucent-bg" style="background-image:url('../Designs/Outside/images/background-img-4.jpg');">
				<div class="container">
					<div class="row">
						<!-- main start -->
						<!-- ================ -->
						<div class="main object-non-visible" data-animation-effect="fadeInUpSmall" data-effect-delay="100">
							<div class="form-block center-block p-30 light-gray-bg border-clear">
								<h2 class="title text-center">Login</h2>
								<div class="form-horizontal">
                                       <div id="divMessage" runat="server"  ><asp:Label id="lblMessage" runat="server" /></div><br /> 
                                    
									<div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">User Name</label>
										<div class="col-sm-8">
											   <asp:TextBox ID="txtUsername" placeholder="Email/Username" runat="server" CssClass="form-control" required="required" ></asp:TextBox>   
											<i class="fa fa-user form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label for="inputPassword" class="col-sm-3 control-label">Password</label>
										<div class="col-sm-8">
											<asp:TextBox ID="txtPassword" placeholder="Password" TextMode="Password" runat="server" CssClass="form-control"  required="required" ></asp:TextBox>   
											<i class="fa fa-lock form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-3 col-sm-8">
											<div class="checkbox">
												<label>
													<input type="checkbox"> Remember me.  <a href="RetrievePassword.aspx">Forgot your password?</a>
												</label>
											</div>			
                                            <asp:Button ID="btnSubmit" runat="server" Text="Sign In" OnClick="btnSubmit_Click" CssClass="btn   btn-default " />	  <asp:HyperLink ForeColor="White" NavigateUrl="~/Home/SignUp.aspx" CssClass="btn btn-success"  ID="aa" runat="server" Text="Register Here"></asp:HyperLink>							
										  
										</div>
									</div>
								</div>
							</div> 
						</div>
						<!-- main end -->
					</div>
				</div>
			</div>
			<!-- main-container end -->
</asp:Content>

