<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Home_Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- banner start -->
			<!-- ================ -->
			<div class="banner dark-translucent-bg" style="background-image:url('../Designs/Outside/images/background-img-3.jpg'); background-position: 50% 30%;">
			 
				<div class="container">
					<div class="row">
						<div class="col-md-8 text-center col-md-offset-2 pv-20">
							<h1 class="page-title text-center">Contact Us</h1>
							<div class="separator"></div>
							<p class="lead text-center">It would be great to hear from you! Just drop us a line and ask for anything with which you think we could be helpful. We are looking forward to hearing from you!</p>
							<ul class="list-inline mb-20 text-center">
								<li><i class="text-default fa fa-map-marker pr-5"></i>Flat No. 1, Akshay Chambers, Samarth Colony, Near Prabhat Chowk, Jalgaon</li>
								<li><a href="#" class="link-dark"><i class="text-default fa fa-phone pl-10 pr-5"></i>+91 9561421489</a></li>
								<li><a href="#" class="link-dark"><i class="text-default fa fa-envelope-o pl-10 pr-5"></i>contact@societykatta.com</a></li>
							</ul>
							<div class="separator"></div>
							<ul class="social-links circle animated-effect-1 margin-clear text-center space-bottom">
								<li class="facebook"><a target="_blank" href="http://www.facebook.com/Societykatta/"><i class="fa fa-facebook"></i></a></li>
								<li class="twitter"><a target="_blank" href="http://www.twitter.com/SocietyKatta"><i class="fa fa-twitter"></i></a></li>
								<li class="googleplus"><a target="_blank" href="https://plus.google.com/u/1/103932599965577561100?hl=en"><i class="fa fa-google-plus"></i></a></li>
								<li class="linkedin"><a target="_blank" href="http://www.linkedin.com"><i class="fa fa-linkedin"></i></a></li>
						 	</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- banner end -->

			<!-- main-container start -->
			<!-- ================ -->
			<section class="main-container">

				<div class="container">
					<div class="row">

						<!-- main start -->
						<!-- ================ -->
						<div class="main col-md-12 space-bottom">
							<h2 class="title text-center">Drop Us a Line</h2>
							<div class="row">
								<div class="col-md-6">
										<div  class="margin-clear"  >
											<div class="form-group has-feedback">
												<label for="name">Name*</label>
												<asp:TextBox CssClass="form-control" ID="name"  onkeyup="checkText(this);" required="required"  placeholder="" runat="server" />
												<i class="fa fa-user form-control-feedback"></i>
											</div>
											<div class="form-group has-feedback">
												<label for="email">Email*</label>
												<asp:TextBox CssClass="form-control" ID="email" required="required"   placeholder="" runat="server" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)"  />
												<i class="fa fa-envelope form-control-feedback"></i>
											</div>
											<div class="form-group has-feedback">
												<label for="subject">Subject*</label>
												<asp:TextBox CssClass="form-control" ID="subject" required="required"  name="sub" placeholder="" runat="server"  onkeyup="checkTextNum(this);"/>
												<i class="fa fa-navicon form-control-feedback"></i>
											</div>
											<div class="form-group has-feedback">
												<label for="message">Message*</label>
												<asp:TextBox CssClass="form-control" ID="message" required="required"  name="adr"  onkeyup="checkTextNum(this);" placeholder="" TextMode="MultiLine" runat="server" />
												<i class="fa fa-pencil form-control-feedback"></i>
											</div>
										 <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="Submit" CssClass="submit-button btn btn-default" />
										</div>
	 
								</div>
						<div class="col-md-6">
                                
									<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3021.525794434787!2d75.55429531423408!3d21.00184399407406!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bd90fb6ac338fed%3A0x40cf465335102115!2sAnuvaa+Softech+Pvt+Ltd!5e1!3m2!1sen!2sin!4v1464590884290" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
								</div>
							</div>
						</div>
						<!-- main end -->
					</div>
				</div>
			</section>
			<!-- main-container end -->

			<%--<!-- section start -->
			<!-- ================ -->
			<section class="section pv-40 parallax background-img-1 dark-translucent-bg" style="background-position:50% 60%;">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="call-to-action text-center">
								<div class="row">
									<div class="col-sm-8 col-sm-offset-2">
										<h2 class="title">Subscribe to Our Newsletter</h2>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellendus error pariatur deserunt laudantium nam, mollitia quas nihil inventore, quibusdam?</p>
										<div class="separator"></div>
										<form class="form-inline margin-clear">
											<div class="form-group has-feedback">
												<label class="sr-only" for="subscribe2">Email address</label>
												<input type="email" class="form-control" id="subscribe2" placeholder="Enter email" name="subscribe2" required="">
												<i class="fa fa-envelope form-control-feedback"></i>
											</div>
											<button type="submit" class="btn btn-gray-transparent btn-animated margin-clear">Submit <i class="fa fa-send"></i></button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>--%>
			<div class="clearfix"></div>
			<!-- section end -->
</asp:Content>

