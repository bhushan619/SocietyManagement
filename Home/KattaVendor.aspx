<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="KattaVendor.aspx.cs" Inherits="Home_KattaVendor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <!-- banner start -->
			<!-- ================ -->
			<div class="banner  pv-40 dark-translucent-bg hovered"> 
                  <div style="position: absolute; z-index: -1; top: 0px; left: 0px; bottom: 0px; right: 0px; overflow: hidden; background-image: url('../Designs/Outside/images/kattavendor.jpg'); background-color: transparent; background-size: cover; background-position: 50% 50%; background-repeat: no-repeat;">
                  </div> 
				<div class="container">
					<div class="row">
						<div class="col-md-8 text-center col-md-offset-2 pv-20">
							<h2 class="title object-non-visible" data-animation-effect="fadeIn" data-effect-delay="100">Hello & Welcome to <br />
Katta Vendor Services
</h2>
							<div class="separator object-non-visible mt-10" data-animation-effect="fadeIn" data-effect-delay="100"></div>
							<p class="text-center object-non-visible" data-animation-effect="fadeIn" data-effect-delay="100">
Verified vendors to deal with household maintenance & provide 100% satisfaction as per your suitable timings. </p>
						</div>
					</div>
				</div>
                 <!-- section start -->
				<!-- ================ -->
				 <div class=" section">
					<div class="container">
						<!-- filters start -->
						<div class="sorting-filters text-center mb-20">
							<div class="form-inline">
								  
						 
								<div class="form-group">
									<label>Location</label>
                                    <asp:DropDownList ID="ddlLocation"  required="required"  AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged" runat="server" AppendDataBoundItems="true" title=":: Your Location ::" CssClass="form-control  " DataSourceID="SqlDataSourceServicedCities" DataTextField="CityName" DataValueField="CityId">
                                        <asp:ListItem Value="">:: Your Location ::</asp:ListItem>
                                        
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="SqlDataSourceServicedCities" ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>' SelectCommand="SELECT DISTINCT citymaster.CityName, citymaster.CityId
FROM            tblvendor INNER JOIN
                         citymaster ON tblvendor.varCity = citymaster.CityId"></asp:SqlDataSource>
                                </div>
                                <div class="form-group">
									<label>Area</label>
                                    <asp:DropDownList ID="ddlArea"  required="required" runat="server" AppendDataBoundItems="true" title=":: Your Location ::" CssClass="form-control  " DataSourceID="SqlDataSourceArea" DataTextField="Area" DataValueField="Area">
                                        <asp:ListItem Value="">:: Your Area ::</asp:ListItem>
                                        
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="SqlDataSourceArea" ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>'  ></asp:SqlDataSource>
                                </div>
								<div class="form-group">
									<label>Services</label>
                                    <asp:DropDownList ID="ddlService" runat="server" required="required" CssClass="form-control " AppendDataBoundItems="true" DataSourceID="SqlDataSourceServices" DataTextField="Service Name" DataValueField="Service Id">
                                    <asp:ListItem Value="">:: Select Service ::</asp:ListItem>
                            
                            </asp:DropDownList>
                                   <asp:SqlDataSource ID="SqlDataSourceServices" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:ConnectionStringServices %>"
                                     ProviderName="<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>" 
                                    SelectCommand="SELECT DISTINCT tblvendorservices.varName AS `Service Name`, tblvendorservices.intServiceCode AS `Service Id`, tblvendorservices.varImage
FROM            tblvendor INNER JOIN
                         tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN
                         tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode"></asp:SqlDataSource>
                              
								</div>
                                	 
                                	 
								<div class="form-group">								
									<asp:Button ID="lnkSearch" runat="server" OnClick="lnkSearch_Click" CssClass="btn btn-info form-control" Text="SEARCH"> </asp:Button>
								</div>
							</div>
						</div>
						<!-- filters end -->
					</div>
				</div>
				<!-- section end -->
			</div>
			<!-- banner end -->
   
    	 
    
    	<!-- footer top start -->
			<!-- ================ -->
			<%--<div class="dark-translucent-bg  footer-top animated-text default-hovered" style="background-color:rgba(0,0,0,0.6);">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="call-to-action text-center">
								<div class="row">
									<div class="col-sm-8">
										<h2>Looking for Vendor</h2>
										<h2>   Install Android & ios Application</h2>
									</div>
									<div class="col-sm-4">
										<p class="mt-10"><a href="KattaVendor.aspx" class="btn btn-animated btn-lg btn-gray-transparent">Book Now<i class="fa  fa-paper-plane-o pl-20"></i></a></p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>--%>
			<!-- footer top end -->
    <section class="-bg pv-40 border-clear">
				<div class="container">
					<div class="col-md-8 col-md-offset-2">
						<h2 class="text-center title">OUR <strong>SERVICES</strong></h2>
					<%--	<div class="separator"></div>
						<p class="large text-center">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Numquam voluptas facere vero ex tempora saepe perspiciatis ducimus sequi animi.</p>--%>
					</div>
				</div>
				<div class="container-fluid">
					<div class="row">
                        <div class="col-md-2"></div>
							<div class="col-md-8 text-center">
					 <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSourceServices" OnItemCommand="lstVendors_ItemCommand">
                                 
                                 <EmptyDataTemplate>
                                <span>	<div class="alert alert-warning alert-dismissible text-center" role="alert">
								 
								<strong>Sorry...!!!</strong> We are working on it...!!!
							</div></span>
                            </EmptyDataTemplate>
                                 
                                <ItemTemplate>
                                    	 
                                 <div class="col-md-3">
						  <div class="image-box shadow bordered mb-20">
										<div class="overlay-container">
											<asp:Image ID="imgSimilarPic" runat="server" CssClass="cntr" ImageUrl='<%# "~/SK/MasterData/serviceimages/" + Eval("varImage") %>' Width="160" Height="150" /> 
									
											<div class="overlay-top">
												<div class="text">
													<h3><asp:Label ID="intServiceCodeLabel" runat="server" Text='<%# Eval("[Service Id]") %>' Visible="false" /> Ask Now </h3>
													
											</div>
                                                </div>
											<div class="overlay-bottom">
												<div class="links">

<asp:LinkButton style="font-size: 1.0em;" runat="server" ID="LinkButton1"  CommandArgument='<%# Eval("[Service Id]") %>' Text=""  class="btn btn-default-transparent btn-animated "> Book<i class="fa fa-send"></i> </asp:LinkButton>
												</div>
											</div>
										</div>
									</div>
								<div >
											<%--<p ><asp:LinkButton style="font-size: 0.9em;color: black;" runat="server" ID="j"  CommandArgument='<%# Eval("[Service Id]") %>' Text='<%# Eval("[Service Name]") %>'> </asp:LinkButton> </p>--%>
										
								</div>  
						</div> 
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div id="itemPlaceholderContainer" runat="server" style="">
                                        <span runat="server" id="itemPlaceholder" />
                                    </div>
                                    
                                </LayoutTemplate> 

                            </asp:ListView>
                              
					</div>
                        </div>
				</div>
			</section>

    	<!-- section start -->
			<!-- ================ -->
			<section class="light-gray-bg pv-30 clearfix">
				<div class="container">
					<div class="row">
						<div class="col-md-8 col-md-offset-2">
							<h2 class="text-center">How it works?</h2>
							<div class="separator"></div>
							<p class="large text-center"> Passion, Dedication & Transperancy leads us to deliver 100% client satisfactory services.</p>
						</div>
						<div class="col-md-4">
	<div class="pv-30 ph-20 feature-box bordered shadow text-center object-non-visible" data-animation-effect="fadeInDownSmall" data-effect-delay="100">
								<span class="icon default-bg circle"><i class="fa fa-wrench"></i></span>
								<h3>Select Service</h3>
								<div class="separator clearfix"></div>
								<p>Select the service you require</p>

								
							</div>
						</div>
						<div class="col-md-4">
            	<div class="pv-30 ph-20 feature-box bordered shadow text-center object-non-visible" data-animation-effect="fadeInDownSmall" data-effect-delay="150">
						
								<span class="icon default-bg circle"><i class="fa fa-calendar-plus-o"></i></span>
								<h3>Schedule Appointment</h3>
								<div class="separator clearfix"></div>
								<p>Schedule appointment as per your convenience</p>

								
							</div>
						</div>
						<div class="col-md-4">
								<div class="pv-30 ph-20 feature-box bordered shadow text-center object-non-visible" data-animation-effect="fadeInDownSmall" data-effect-delay="200">
								<span class="icon default-bg circle"><i class="fa fa-smile-o"></i></span>
								<h3>Say Hello</h3>
								<div class="separator clearfix"></div>
								<p>Service provider will be at your doorstep</p>
								
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- section end -->
    	<!-- section start -->
   			<!-- main-container start -->
			<!-- ================ -->
			<section class="main-container padding-bottom-clear">

				<div class="container">
					<div class="row">

						<!-- main start -->
						<!-- ================ -->
						<div class="main col-md-12">
							<h3 class="title">Why us?	</h3>
							<div class="separator-2"></div>
							<div class="row">
								<div class="col-md-7">
								    <br />
								 1.	Genuine Vendor Profiles :
                                    We provide genuine & verified listing of vendors.<br /> <br />

									2.	Reviews & ratings : check out reviews & ratings of vendors before you book.<br /><br />
3.	Best Pricing : Quality service & affordable price.<br /> <br />
4.	Passionate people : for delivering quality in work.<br /> <br />
5.	Respect to time : time bound work culture & valuation. <br /> <br />
6.	Our ethics : transparency, clarity & client satisfaction is ultimate goal.<br /> <br />

								</div>
								<div class="col-md-5">
									<div class="overlay-container overlay-visible">
										<img src="../Designs/Outside/images/whyus.jpg" alt="">
										<div class="overlay-bottom hidden-xs">
											<div class="text">
												<h3 class="title">Why us?</h3>
											</div>
										</div>
										<a href="../Designs/Outside/images/whyus.jpg" class="popup-img overlay-link" title="image title"><i class="icon-plus-1"></i></a>
									</div>
								</div>
                            
							</div>    <br />
						</div>
						<!-- main end -->

					</div>
				</div>
			</section>
			<!-- section end -->
			<!-- section start -->
			<!-- ================ -->
			<section class="section default-bg  clearfix">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="call-to-action text-center">
								<div class="row">
									<div class="col-sm-12">
										<h3 class="">
Get In Touch &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-phone"></i>&nbsp;&nbsp;&nbsp;&nbsp;+91 7066660206&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-envelope-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;contact@societykatta.com </h3></div>
							
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- section end -->	
			

</asp:Content>

