<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="RetrievePassword.aspx.cs" Inherits="Home_RetrievePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- main-container start -->
			<!-- ================ -->
			<div class="main-container dark-translucent-bg" style="background-image:url('../Designs/Outside/images/background-img-6.jpg');">
				<div class="container">
					<div class="row">
						<!-- main start -->
						<!-- ================ -->
						<div class="main object-non-visible" data-animation-effect="fadeInUpSmall" data-effect-delay="100">
							<div class="form-block center-block p-30 light-gray-bg border-clear">
								<h2 class="title text-center">Retrieve Forget Password</h2>
								<div class="form-horizontal">
                                       <div id="divMessage" runat="server"  ><asp:Label id="lblMessage" runat="server" /></div><br /> 
									<div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">User Name</label>
										<div class="col-sm-8">
											   <asp:TextBox ID="txtUsername" placeholder="User Name" runat="server" CssClass="form-control" required="required" ></asp:TextBox>   
											<i class="fa fa-user form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label for="inputPassword" class="col-sm-3 control-label">Email</label>
										<div class="col-sm-8">
										 <asp:TextBox ID="txtEmail" runat="server" required="required" CssClass="form-control" placeholder="Enter E-mail"></asp:TextBox>
											<i class="fa fa-lock form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-3 col-sm-8">
											 	
                                            <asp:Button ID="btnRetrieve" runat="server" Text="Retrieve" OnClick="btnRetrieve_Click" CssClass="btn btn-default" />		
                                            <a href="Login.aspx" class="btn btn-success" style="color:#fff">Login</a>						
									 
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

