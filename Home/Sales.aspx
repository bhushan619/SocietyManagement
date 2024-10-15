<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="Sales.aspx.cs" Inherits="Home_Sales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <!-- main-container start -->
			<!-- ================ -->
			<div class="main-container dark-translucent-bg" style="background-image:url('../Designs/Outside/images/background-img-7.jpg');">
				<div class="container">
					<div class="row">
						<!-- main start -->
						<!-- ================ -->
						<div class="main object-non-visible" data-animation-effect="fadeInUpSmall" data-effect-delay="100">
							<div class="form-block center-block p-30 light-gray-bg border-clear">
								<h2 class="title">Sales Enquiry</h2>
								<div class="form-horizontal">
                                     <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
									<div class="form-group has-feedback">
										<label for="inputName" class="col-sm-3 control-label">Full Name <span class="text-danger small">*</span></label>
										<div class="col-sm-8">
                                    <asp:TextBox ID="txtName" runat="server" class="form-control"  placeholder="Full Name" required="required"  onkeyup="checkText(this);"></asp:TextBox>
										
											<i class="fa fa-user form-control-feedback"></i>
										</div>
									</div>
									
									<div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-3 control-label">Mobile <span class="text-danger small">*</span></label>
										<div class="col-sm-8">
										<asp:TextBox ID="txtmobile" runat="server" class="form-control"  placeholder="Mobile Number" required="required"  onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12"></asp:TextBox>
											<i class="fa fa-mobile form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label for="inputEmail" class="col-sm-3 control-label">Email <span class="text-danger small">*</span></label>
										<div class="col-sm-8">
											<asp:TextBox ID="txtemail" runat="server" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" class="form-control"  placeholder="Email" required="required"></asp:TextBox>
											<i class="fa fa-envelope form-control-feedback"></i>
										</div>
									</div>
								<div class="form-group has-feedback">
										<label for="inputLastName" class="col-sm-3 control-label">Society Name <span class="text-danger small">*</span></label>
										<div class="col-sm-8">
										<asp:TextBox ID="txtservice" runat="server" class="form-control"   onkeyup="checkTextNum(this);" placeholder="Society Name" required="required"></asp:TextBox>
											<i class="fa fa-wrench form-control-feedback"></i>
										</div>
									</div>
                                    	<div class="form-group has-feedback">
										<label for="inputLastName" class="col-sm-3 control-label">Comments</label>
										<div class="col-sm-8">
										<asp:TextBox ID="txtcomment" runat="server" class="form-control" TextMode="MultiLine"  placeholder="Comments"  onkeyup="checkTextNum(this);"></asp:TextBox>
											<i class="fa fa-comment form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-2 col-sm-10">
											<div class="">
												<label>
												Note: If any query write us at business@societykatta.com
												</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-3 col-sm-8">
											 <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" CssClass="btn btn-default" /> 
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