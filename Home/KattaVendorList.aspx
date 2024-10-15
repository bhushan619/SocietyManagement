<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="KattaVendorList.aspx.cs" Inherits="Home_KattaVendorList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <!-- banner start -->
			<!-- ================ -->
			<div class="banner video-background-banner pv-40 dark-translucent-bg hovered"> 
				 <div class="container">
					<div class="row">
						<div class="col-md-8 text-center col-md-offset-2 pv-20">
							<h2 class="title object-non-visible" data-animation-effect="fadeIn" data-effect-delay="100">Your Searched Service and Vendors<br /
</h2>
							<div class="separator object-non-visible mt-10" data-animation-effect="fadeIn" data-effect-delay="100"></div>
							 
						</div>
					</div>
				</div>
                 <!-- section start -->
				<!-- ================ -->
				 <div class=" section">
					<div class="container">
						<!-- filters start -->
						<div class="sorting-filters text-center">
							<div class="form-inline">
								  
						 
								
								<div class="form-group">
									<label>Location</label>
                                    <asp:DropDownList ID="ddlLocation" required="required" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged" runat="server" AppendDataBoundItems="true" title=":: Your Location ::" CssClass="form-control  " DataSourceID="SqlDataSourceServicedCities" DataTextField="CityName" DataValueField="CityId">
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
   
    	<section class="main-container" runat="server" id="vendorlisting" visible="false">

				<div class="container">
					<div class="row">

                        <asp:ListView ID="lstVendors" runat="server" OnItemCommand="lstVendors_ItemCommand">
                         <LayoutTemplate>
                                <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                                <div style="">
                                </div>
                            </LayoutTemplate>   
                             
                          
                            <ItemTemplate>
                                <span style="">
                                    
                                    <div class="col-md-6 feature-box">
                                <div class="listing-item mb-20 bordered shadow  object-non-visible" data-animation-effect="fadeInDownSmall" data-effect-delay="100">
										<div class="row grid-space-0">

											<div class="col-sm-6 col-md-4 col-lg-3 ">
												<div class="overlay-container  ph-20"> 
                                                    <br />
                                                    <asp:Image ID="imgSimilarPic" runat="server" CssClass="fancybox bordered" Height="100" Width="170"  ImageUrl='<%# "~/Services/Vendor/VendorImages/" + Eval("varImage") %>' /> 
												 	 
											  </div>
											</div>
											<div class="col-sm-6 col-md-8 col-lg-9">
												<div class="body">
													<h3 class="margin-clear"><asp:Label Text='<%# Eval("varName") %>' runat="server" ID="varNameLabel" /></h3>
													<p>  
                                                        <span aria-readonly="true">
											                <i  class='<%# (decimal)Eval("intRating")  >= 1 ? "fa fa-star text-default" : "fa fa-star" %>'></i>
											                <i  class='<%# (decimal)Eval("intRating")  >= 2  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
                                                            <i  class='<%# (decimal)Eval("intRating")  >= 3  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
                                                            <i  class='<%# (decimal)Eval("intRating")  >= 4  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
                                                            <i  class='<%# (decimal)Eval("intRating")  >= 5  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
										                </span> 
														<asp:LinkButton ID="ViewProfile" runat="server" CommandName="ViewVendor" CommandArgument='<%# Eval("intVendorCode")+ ":"+  Eval("intServiceId")  %>' CssClass="btn-sm-link"><i class="icon-link pr-5"></i>View Details</asp:LinkButton>
													</p>
                                                    <p>
                                                        Timing : <i class='<%# (decimal)Eval("intOnTime") == 1  ? "fa fa-thumbs-up text-default" : "fa fa-thumbs-down" %>'></i> 
                                                         Quality : <i class='<%# (decimal)Eval("intQuality") == 1  ? "fa fa-thumbs-up text-default" : "fa fa-thumbs-down" %>'></i>
                                                    </p>
                                                    
													 
													<div class="elements-list clearfix">
														 <span class="price"> Visiting Charge : <i class="fa fa-inr" ></i> <asp:Label Text='<%# Eval("varCharges") %>' runat="server" ID="Label1" /></span>
														<asp:LinkButton runat="server" Text="BOOK" CommandName="Book" CommandArgument='<%# Eval("intVendorCode")+ ":"+  Eval("intServiceId")  %>' CssClass="margin-clear btn btn-default" style="float:right" ID="Button1" />
													</div>
												</div>
											</div>
										</div>
									</div>
                            </div>
                 
                                </span>
                            </ItemTemplate>

                             
                            <EmptyDataTemplate>
                                <span>	<div class="alert alert-warning alert-dismissible text-center" role="alert">
								 
								<strong></strong> Will Get You Vendor Soon...!!!
							</div></span>
                            </EmptyDataTemplate>
                             
                             
                        </asp:ListView>
                        <asp:SqlDataSource runat="server" ID="SqlDataSourceVendorList" ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>' ></asp:SqlDataSource>
                        
							 
                        </div> 
				</div>
			</section>


    	<!-- footer top start -->
			<!-- ================ -->
			 
			<!-- footer top end -->
     
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

