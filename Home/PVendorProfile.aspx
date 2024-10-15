<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="PVendorProfile.aspx.cs" Inherits="Home_PVendorProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- main-container start -->
			<!-- ================ -->
			<section class="main-container">

				<div class="container">
					<div class="row">

						<!-- main start -->
						<!-- ================ -->
						<div class="main col-md-12">
                                     <br />
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSourceVendorList" OnItemCommand="ListView1_ItemCommand">
          
            <EmptyDataTemplate>
                <span>No data was returned.</span>
            </EmptyDataTemplate>
            
            <ItemTemplate>
                <span style="">
                
                    	<h1 class="page-title">
         <asp:Label Text='<%# Eval("varName") %>' runat="server" ID="varNameLabel" /></h1>
							<div class="separator-2"></div>
							<!-- page-title end -->

							<div class="row">
								<div class="col-md-4"> 
									<div class="owl-carousel content-slider-with-large-controls">
										<div class="overlay-container overlay-visible">
											<img src='<%# "../Services/Vendor/VendorImages/"+ Eval("varImage")%>' alt='<%# Eval("varName") %>'  height="220" width="270">
											<a href='<%# "../Services/Vendor/VendorImages/"+ Eval("varImage")%>'  class="popup-img overlay-link" title='<%# Eval("varName") %>'><i class="icon-plus-1"></i></a>
										</div> 
									</div> 
                                    <div>
                                      </div>
								</div>
								<div class="col-md-8 pv-30">
									<h2>Description</h2>
									<p> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="varDescriptionLabel" /></p>
								 	<hr class="mb-10">
									 
									<div class="light-gray-bg p-20 bordered clearfix">
										<span class="product price"> Visiting Charge : <i class="fa fa-inr"></i>
            <asp:Label Text='<%# Eval("varCharges") %>' runat="server" ID="Label1" /></span>
										<div class="product elements-list pull-right clearfix">
											<asp:LinkButton runat="server" Text="BACK" CommandArgument='<%# Eval("intVendorCode")+ ":"+  Eval("intServiceId")  %>' CommandName="Back" CssClass="margin-clear btn btn-success" ID="LinkButton1"  style="float:right"  /><asp:LinkButton runat="server" Text="BOOK" CommandArgument='<%# Eval("intVendorCode")+ ":"+  Eval("intServiceId")  %>' CommandName="Book" CssClass="margin-clear btn btn-default" ID="Button1"  style="float:right"  />
                                            
										</div>
									</div>
								</div>
							</div> 
                        <asp:Label Text='<%# Eval("intRating") %>' runat="server" ID="intRatingLabel"  Visible="false"/> 
                    <asp:CheckBox  Visible="false" Checked='<%# (decimal)Eval("intOnTime") == 1  ? true : false %>' runat="server" ID="intOnTimeCheckBox" Enabled="false" Text="intOnTime" /> 
                    <asp:CheckBox  Visible="false" Checked='<%# (decimal)Eval("intQuality") == 1  ? true : false %>' runat="server" ID="intQualityCheckBox" Enabled="false" Text="intQuality" /> 
                
                    <asp:Label  Visible="false" Text='<%# Eval("intVendorCode") %>' runat="server" ID="intVendorCodeLabel" /> 
                   
                    <asp:Label  Visible="false" Text='<%# Eval("intServiceId") %>' runat="server" ID="intServiceIdLabel" /> 
                 
                    <asp:Label  Visible="false" Text='<%# Eval("varAbout") %>' runat="server" ID="varAboutLabel" /> 
                   
                    <asp:Label  Visible="false" Text='<%# Eval("varImage") %>' runat="server" ID="varImageLabel" /> 
                  
                    <asp:Label  Visible="false" Text='<%# Eval("varCharges") %>' runat="server" ID="varChargesLabel" /> 
                </span>
            </ItemTemplate>
            <LayoutTemplate>
                <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
           
            </LayoutTemplate>
            
        </asp:ListView>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourceVendorList"  ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>' ></asp:SqlDataSource>
                   
						
						</div>
						<!-- main end -->
                        </div>

                    <section class="pv-30">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<!-- Nav tabs -->
							<ul class="nav nav-tabs style-4" role="tablist">
								<li class="active"><a href="#h2tab2" role="tab" data-toggle="tab"><i class="fa fa-files-o pr-5"></i>Specifications</a></li>
								<li><a href="#h2tab3" role="tab" data-toggle="tab"><i class="fa fa-star pr-5"></i>   Latest reviews</a></li>
							</ul>
							<!-- Tab panes -->
							<div class="tab-content padding-top-clear padding-bottom-clear">
								<div class="tab-pane fade in active" id="h2tab2"> 
                                    Service providers associated with www.societykatta.com are highly professional & dedicated towards delivering quality services.  We do not claim that they will be the cheapest service vendors compare to market but they will be reasonable as quality services cannot be delivered without costing. 
We strongly recommend that kindly review & rate the service vendors & services provided by them to improve the service quality. For any suggestion or feedback you can write to support@societykatta.com

(t&c) <hr>
								</div>
								<div class="tab-pane fade" id="h2tab3">
									<!-- comments start -->
                                   <div class="row"> 
                                   
						        <asp:ListView ID="lstRating" runat="server" DataSourceID="SqlDataSource1"> 
                                  <EmptyDataTemplate>
                                       <span>	<div class="alert alert-warning alert-dismissible text-center" role="alert">
								 
								<strong></strong> We are associated recently.. Reviews yet to come..!!!
							</div></span>

                                  </EmptyDataTemplate> 
                                   
                                  <ItemTemplate>
                                      <div class="col-lg-5 col-sm-offset-1 bordered pv-20"> 
                                           <div class="comment">
											<div class="comment-avatar">
												<asp:Image runat="server" ID="sd" CssClass="img-circle" ImageUrl='<%#"~/Services/Customer/CustomerImages/"+ (Eval("imgImage").ToString().Equals("NoProfile.png") ? "NoProfileSmall.jpg" : "NoProfileSmall.jpg" ) %>' AlternateText='<%# Eval("varName") %>' />
											</div>
											<header>
												<h3><asp:Label Text='<%# Eval("varName") %>' runat="server" ID="varNameLabel" /></h3>
												<div class="comment-meta"> <span aria-readonly="true">
											                <i  class='<%# (decimal)Eval("intRating")  >= 1 ? "fa fa-star text-default" : "fa fa-star" %>'></i>
											                <i  class='<%# (decimal)Eval("intRating")  >= 2  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
                                                            <i  class='<%# (decimal)Eval("intRating")  >= 3  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
                                                            <i  class='<%# (decimal)Eval("intRating")  >= 4  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
                                                            <i  class='<%# (decimal)Eval("intRating")  >= 5  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
										                </span>  | <asp:Label Text='<%# Eval("Date") %>' runat="server" ID="Label2" /></div>
											</header>
											<div class="comment-content">
												<div class="comment-body">
                                                    <p>
                                                        Timing : <i class='<%#  (Eval("intOnTime").ToString().Equals("1"))  ? "fa fa-thumbs-up text-default" : "fa fa-thumbs-down" %>'></i> 
                                                         Quality : <i class='<%# (Eval("intQuality").ToString().Equals("1"))  ? "fa fa-thumbs-up text-default" : "fa fa-thumbs-down" %>'></i>
                                                    </p>
													<p><asp:Label Text='<%# Eval("varReview") %>' runat="server" ID="varReviewLabel" /></p>
												 	</div>
											</div>
										</div>
									 </div> 
                                  </ItemTemplate>
                                  <LayoutTemplate>
                                      <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                                      <div style="">
                                      </div> 
                                  </LayoutTemplate> 
                              </asp:ListView>
                                        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>'  ></asp:SqlDataSource>
                      </div>
								</div>
							</div>
						</div>

					
					</div>
				</div>
			</section>
                    </div>
				 
			</section>
			<!-- main-container end -->
</asp:Content>

