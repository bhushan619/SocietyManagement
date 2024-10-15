<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Home_ChangePassword" %>

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
								<h2 class="title text-center">Change Password</h2>
								<div class="form-horizontal">
                                     <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
									<div class="form-group has-feedback">
										<label for="inputName" class="col-sm-4 control-label">Old Password <span class="text-danger small">*</span></label>
										<div class="col-sm-8">
                                    <asp:TextBox ID="txtOldPass" runat="server" class="form-control" TextMode="Password"   placeholder="Old Password" required="required"></asp:TextBox>
										
											<i class="fa fa-user form-control-feedback"></i>
										</div>
									</div>
									
									<div class="form-group has-feedback">
										<label for="inputUserName" class="col-sm-4 control-label">New Password <span class="text-danger small">*</span></label>
										<div class="col-sm-8">
										<asp:TextBox ID="txtNewPass" runat="server" class="form-control" TextMode="Password"  placeholder="New Password" required="required"   ></asp:TextBox>
											<i class="fa fa-mobile form-control-feedback"></i>
										</div>
									</div>
									<div class="form-group has-feedback">
										<label for="inputEmail" class="col-sm-4 control-label">Confirm New Pass <span class="text-danger small">*</span></label>
										<div class="col-sm-8">
											<asp:TextBox ID="txtConfNew" runat="server" class="form-control" TextMode="Password"  placeholder="Confirm New Password" required="required"></asp:TextBox>
											<i class="fa fa-envelope form-control-feedback"></i>
										</div>
									</div>
							 
									<div class="form-group">
										<div class="col-sm-offset-4 col-sm-8">
											 <asp:Button ID="btnSubmit" runat="server"  Text="Change Password" OnClick="btnSubmit_Click" CssClass="btn btn-default" /> 
										</div>
									</div>
                                 <div class="form-group">
										<div class="col-sm-offset-1 col-sm-12">   <label>Note: If any query write us at support@societykatta.com</label>
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

