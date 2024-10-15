<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="SignUp.aspx.cs" Inherits="Home_SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">

        function checkPassCol() {
            //Store the password field objects into variables ...
            var pass1 = document.getElementById('ContentPlaceHolder1_txtPassword');
            var pass2 = document.getElementById('ContentPlaceHolder1_txtConfirmPassword');
            //Store the Confimation Message Object ...
            var message = document.getElementById('confirmcol');
            //Set the colors we will be using ...
            var goodColor = "#66cc66";
            var badColor = "#ff6666";
            //Compare the values in the password field 
            //and the confirmation field
            if (pass1.value == pass2.value) {
                //The passwords match. 
                //Set the color to the good color and inform
                //the user that they have entered the correct password 
                pass2.style.backgroundColor = goodColor;
                message.style.color = goodColor;
                message.innerHTML = "Passwords Match!"
            } else {
                //The passwords do not match.
                //Set the color to the bad color and
                //notify the user.
                pass2.style.backgroundColor = badColor;
                message.style.color = badColor;
                message.innerHTML = "Passwords Do Not Match!"
            }
        }
</script>
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
								<h2 class="title text-center">Sign Up</h2>
								<div class="form-horizontal">
                                       <div id="divMessage" runat="server" class="text-center"  ><asp:Label id="lblMessage" runat="server"  ForeColor="White"/></div><br /> 
                                      <div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">User Type</label>
										<div class="col-sm-8">
                                       <label   class="control-label text-info"> Services User</label> 
										</div>
									</div>
                                    <div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">Name</label>
										<div class="col-sm-8">
                                           <asp:TextBox ID="txtName" placeholder="Name" runat="server" CssClass="form-control" required="required" ></asp:TextBox>   
                                            <i class="fa fa-user form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">Email</label>
										<div class="col-sm-8">
											   <asp:TextBox ID="txtEmail" placeholder="Email" runat="server" CssClass="form-control" required="required" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)"  ></asp:TextBox>   
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
										<label for="inputPassword" class="col-sm-3 control-label">Password</label>
										<div class="col-sm-8">
											<asp:TextBox ID="txtPassword" placeholder="Password"    onkeyup="checkPassCol();"  TextMode="Password" runat="server" CssClass="form-control"  required="required" ></asp:TextBox>   
											<i class="fa fa-lock form-control-feedback"></i>
										</div>
									</div>
                                    <div class="form-group has-feedback">
										<label for="inputPassword" class="col-sm-3 control-label">Password</label>
										<div class="col-sm-8">
											<asp:TextBox ID="txtConfirmPassword"    onkeyup="checkPassCol();"   placeholder="Confirm Password" TextMode="Password" runat="server" CssClass="form-control"  required="required" ></asp:TextBox>   
											<i class="fa fa-lock form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-3 col-sm-8">
											 
                                            <asp:Button ID="btnSubmit" runat="server" Text="Sign Up" OnClick="btnSubmit_Click" CssClass="btn   btn-default " />	  <asp:HyperLink ForeColor="White" NavigateUrl="~/Home/Login.aspx" CssClass="btn btn-success"  ID="aa" runat="server" Text="Login Here"></asp:HyperLink>							
										 
											<%--<ul class="space-top">
												<li></li>
											</ul>
											<span class="text-center text-muted">Login with</span>
											<ul class="social-links colored circle clearfix">
												<li class="facebook"><a target="_blank" href="http://www.facebook.com"><i class="fa fa-facebook"></i></a></li>
												<li class="twitter"><a target="_blank" href="http://www.twitter.com"><i class="fa fa-twitter"></i></a></li>
												<li class="googleplus"><a target="_blank" href="http://plus.google.com"><i class="fa fa-google-plus"></i></a></li>
											</ul>--%>
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

