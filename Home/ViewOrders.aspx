<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="ViewOrders.aspx.cs" Inherits="Home_ViewOrders" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    	<section class="main-container" id="Customer" runat="server" visible="false">
             
				<div class="container">	
             <div class="row"> 
              
         	    <h1 class="page-title">My Orders</h1>
				 <div class="separator-2"></div>
                 <div class="row">
    <asp:ListView ID="lstOrders" runat="server" DataSourceID="SqlDataSourceOrders" OnItemCommand="lstOrders_ItemCommand"> 
           <EmptyDataTemplate>
                                <span>	<div class="alert alert-warning alert-dismissible text-center" role="alert">								 
								<strong>Opps..!!!</strong> No Orders Found.
							</div></span>
                            </EmptyDataTemplate>
        <ItemTemplate>
        
                <div class="col-lg-6">
											<div class="listing-item   mb-20 bordered shadow object-non-visible" data-animation-effect="fadeInDownSmall" data-effect-delay="100">
												<div class="row grid-space-0">
													<div class="col-sm-6 col-md-4 col-lg-3">
														<div class="overlay-container pv-20 ph-20"> 
															<asp:Image ID="imgSimilarPic" runat="server"  CssClass=" bordered"  ImageUrl='<%# "~/Services/Vendor/VendorImages/" + Eval("VendorImage") %>' Width="100" Height="100" /> 
															<a class="overlay-link popup-img-single" href='<%# "../Services/Vendor/VendorImages/" + Eval("VendorImage") %>'><i class="fa fa-search-plus"></i></a>
														 </div>
													</div>
													<div class="col-sm-6 col-md-8 col-lg-9">
														<div class="body">
															<h3 class="margin-clear"><asp:Label   Text='<%# Eval("VendorName") %>' runat="server" ID="Label1" /> <asp:Label Text='<%# "#"+ Eval("OrderId") %>' runat="server" ID="Label5" style="float:right" CssClass="text-default" /></h3>
														<p> <asp:Label Text='<%# Eval("varMobileNo") %>' runat="server" ID="Label9" /></p>
                                                             <p><small>Ordered Date </small> : <asp:Label   Text='<%# Eval("CreatedDate") %>' runat="server" ID="Label6" /></p>
                                                            <p><i class="fa fa-calendar-o text-default"></i> <asp:Label   Text='<%# Eval("OrderDate") %>' runat="server" ID="Label3" />, <i class="fa fa-hourglass text-default"></i> <asp:Label   Text='<%# Eval("OrderTime") %>' runat="server" ID="Label4" /></p>
															 <p><span class="price"><i class="fa fa-inr text-default"></i> <asp:Label   Text='<%# Eval("FeesAmount") %>' runat="server" ID="Label2" /></span>
<span class="pull-right">Status :  <asp:Label CssClass='<%# (string)Eval("OrderStatus")=="Cancelled" ?"text-danger"  : (string)Eval("OrderStatus")=="Completed"?"text-success":"text-default" %>'  Text='<%# Eval("OrderStatus") %>' runat="server" ID="Label7" /></p>
															<div class="elements-list clearfix">
																
                                                                <asp:LinkButton ID="LinkButton1" runat="server"  CommandArgument='<%# Eval("OrderId") %>' CommandName="reschedule"  Enabled='<%#  (string)Eval("OrderStatus")=="Completed"?false:true %>' CssClass="btn btn-sm btn-gray-transparent btn-animated">Reschedule<i class="fa fa-calendar"></i></asp:LinkButton>
																<asp:LinkButton ID="ss" runat="server" CommandArgument='<%# Eval("OrderId") %>'  Enabled='<%# (string)Eval("OrderStatus")=="Cancelled" ? false : (string)Eval("OrderStatus")=="Completed"?false:true %>' CommandName="canceled" CssClass="btn btn-sm btn-gray-danger btn-animated">Cancel<i class="fa fa-times"></i></asp:LinkButton>
                                                     		<asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("OrderId") %>' CommandName="review" CssClass="btn btn-sm btn-default-transparent btn-animated">Review<i class="fa fa-star"></i></asp:LinkButton>
                                                       	</div>
														</div>
													</div>
												</div>
											</div>
										</div>
                
            
                <asp:Label Visible="false" Text='<%# Eval("OrderId") %>' runat="server" ID="OrderIdLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("VendorId") %>' runat="server" ID="VendorIdLabel" />
            
                <asp:Label Visible="false" Text='<%# Eval("CreatedDate") %>' runat="server" ID="CreatedDateLabel" />
          
                <asp:Label Visible="false" Text='<%# Eval("OrderDate") %>' runat="server" ID="OrderDateLabel" />
             
                <asp:Label Visible="false" Text='<%# Eval("OrderTime") %>' runat="server" ID="OrderTimeLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("FeesAmount") %>' runat="server" ID="FeesAmountLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("Recieved") %>' runat="server" ID="RecievedLabel" />
             
                <asp:Label Visible="false" Text='<%# Eval("[Payment Status]") %>' runat="server" ID="Payment_StatusLabel" />
              
                <asp:Label Visible="false" Text='<%# Eval("TransactionID") %>' runat="server" ID="TransactionIDLabel" />
                <asp:Label Visible="false" Text='<%# Eval("TransactionStatus") %>' runat="server" ID="TransactionStatusLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("Paymode") %>' runat="server" ID="PaymodeLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("OrderStatus") %>' runat="server" ID="OrderStatusLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("VendorCode") %>' runat="server" ID="VendorCodeLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("VendorName") %>' runat="server" ID="VendorNameLabel" />
                
                <asp:Label Visible="false" Text='<%# Eval("varContactPerson") %>' runat="server" ID="varContactPersonLabel" />
              
                <asp:Label Visible="false" Text='<%# Eval("varPhoneNo") %>' runat="server" ID="varPhoneNoLabel" />
                 
                <asp:Label Visible="false" Text='<%# Eval("varMobileNo") %>' runat="server" ID="varMobileNoLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("VendorEmail") %>' runat="server" ID="VendorEmailLabel" />
                
                <asp:Label Visible="false" Text='<%# Eval("CustomerName") %>' runat="server" ID="CustomerNameLabel" />
                 
                <asp:Label Visible="false" Text='<%# Eval("CustomerMobile") %>' runat="server" ID="CustomerMobileLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("CustomerEmail") %>' runat="server" ID="CustomerEmailLabel" />
              
                <asp:Label Visible="false" Text='<%# Eval("VendorImage") %>' runat="server" ID="VendorImageLabel" />
              
                <asp:Label Visible="false" Text='<%# Eval("ServiceName") %>' runat="server" ID="ServiceNameLabel" />
           
                <asp:Label Visible="false" Text='<%# Eval("ServiceDescription") %>' runat="server" ID="ServiceDescriptionLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("CountryName") %>' runat="server" ID="CountryNameLabel" />
             
                <asp:Label Visible="false" Text='<%# Eval("CityName") %>' runat="server" ID="CityNameLabel" />
           
                <asp:Label Visible="false" Text='<%# Eval("StateName") %>' runat="server" ID="StateNameLabel" />
             
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
            <div style="">
            </div>
        </LayoutTemplate>
        
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceOrders" ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>'  >
        
    </asp:SqlDataSource>
         </div>
                         </div>
                    </div>
            </section>

    <section class="main-container" id="Vendor" runat="server" visible="false"> 
				<div class="container">	
             <div class="row"> 
         	    <h1 class="page-title">My Orders</h1>
				 <div class="separator-2"></div>
                 <div class="row masonry-grid-fitrows grid-space-10 col-lg-offset-1  ">
    <asp:ListView ID="lstVendorOrder" runat="server" DataSourceID="SqlDataSourceVendorOrder" OnItemCommand="lstVendorOrder_ItemCommand"> 
          <EmptyDataTemplate>
                                <span>	<div class="alert alert-warning alert-dismissible text-center" role="alert">
								 
								<strong>Opps..!!!</strong>No Orders Found.
							</div></span><br /><br />
                            </EmptyDataTemplate>
        <ItemTemplate>
        
                <div class="col-md-6 masonry-grid-item">
											<div class="listing-item bordered light-gray-bg mb-20 bordered shadow  object-non-visible" data-animation-effect="fadeInDownSmall" data-effect-delay="100">
												<div class="row grid-space-0">
													<div class="col-sm-6 col-md-4 col-lg-3">
														<div class="overlay-container pv-20 ph-20"> 
															<asp:Image ID="imgSimilarPic" runat="server" CssClass=" bordered"   ImageUrl='<%# "~/Services/Customer/CustomerImages/" + Eval("CustomerImage") %>' Width="100" Height="100" /> 
															<a class="overlay-link popup-img-single" href='<%# "../Services/Customer/CustomerImages/" + Eval("CustomerImage") %>'><i class="fa fa-search-plus"></i></a>
														 </div>
													</div>
													<div class="col-sm-6 col-md-8 col-lg-9">
														<div class="body">
															<h3 class="margin-clear"><asp:Label   Text='<%# Eval("CustomerName") %>' runat="server" ID="Label1" /> <asp:Label Text='<%# "#"+ Eval("OrderId") %>' runat="server" ID="Label5" style="float:right" CssClass="text-default" /></h3>
														 <p><asp:Localize Text='<%# Eval("CustomerMobile") %>' runat="server" ID="Label8" /></p>
                                                            <p><small>Ordered Date </small> : <asp:Label   Text='<%# Eval("CreatedDate") %>' runat="server" ID="Label6" /></p>
                                                            <p><i class="fa fa-calendar-o text-default"></i> <asp:Label   Text='<%# Eval("OrderDate") %>' runat="server" ID="Label3" />, <i class="fa fa-hourglass text-default"></i> <asp:Label   Text='<%# Eval("OrderTime") %>' runat="server" ID="Label4" /></p>
															 <p><span class="price"><i class="fa fa-inr text-default"></i> <asp:Label   Text='<%# Eval("FeesAmount") %>' runat="server" ID="Label2" /></span>
                                                                <span class="pull-right">Status :  <asp:Label CssClass='<%# (string)Eval("OrderStatus")=="Cancelled" ?"text-danger"  : (string)Eval("OrderStatus")=="Completed"?"text-success":"text-default" %>'  Text='<%# Eval("OrderStatus") %>' runat="server" ID="Label7" /></p>
															<div class="elements-list clearfix">
																
                                                                <asp:LinkButton ID="res" runat="server"  CommandArgument='<%# Eval("OrderId") %>' CommandName="reschedule"  Enabled='<%#  (string)Eval("OrderStatus")=="Completed"?false:true %>' CssClass="btn btn-sm btn-gray-transparent btn-animated">Reschedule/Update<i class="fa fa-calendar"></i></asp:LinkButton>
																<asp:LinkButton ID="can" runat="server" CommandArgument='<%# Eval("OrderId") %>'  Enabled='<%# (string)Eval("OrderStatus")=="Cancelled" ? false : (string)Eval("OrderStatus")=="Completed"?false:true %>' CommandName="canceled" CssClass="btn btn-sm btn-default-transparent btn-animated">Cancel<i class="fa fa-times"></i></asp:LinkButton>
                                                        	</div>
														</div>
													</div>
												</div>
											</div>
										</div>
                
            
                <asp:Label Visible="false" Text='<%# Eval("OrderId") %>' runat="server" ID="OrderIdLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("VendorId") %>' runat="server" ID="VendorIdLabel" />
            
                <asp:Label Visible="false" Text='<%# Eval("CreatedDate") %>' runat="server" ID="CreatedDateLabel" />
          
                <asp:Label Visible="false" Text='<%# Eval("OrderDate") %>' runat="server" ID="OrderDateLabel" />
             
                <asp:Label Visible="false" Text='<%# Eval("OrderTime") %>' runat="server" ID="OrderTimeLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("FeesAmount") %>' runat="server" ID="FeesAmountLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("Recieved") %>' runat="server" ID="RecievedLabel" />
             
                <asp:Label Visible="false" Text='<%# Eval("[Payment Status]") %>' runat="server" ID="Payment_StatusLabel" />
              
                <asp:Label Visible="false" Text='<%# Eval("TransactionID") %>' runat="server" ID="TransactionIDLabel" />
                <asp:Label Visible="false" Text='<%# Eval("TransactionStatus") %>' runat="server" ID="TransactionStatusLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("Paymode") %>' runat="server" ID="PaymodeLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("OrderStatus") %>' runat="server" ID="OrderStatusLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("VendorCode") %>' runat="server" ID="VendorCodeLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("VendorName") %>' runat="server" ID="VendorNameLabel" />
                
                <asp:Label Visible="false" Text='<%# Eval("varContactPerson") %>' runat="server" ID="varContactPersonLabel" />
              
                <asp:Label Visible="false" Text='<%# Eval("varPhoneNo") %>' runat="server" ID="varPhoneNoLabel" />
                 
                <asp:Label Visible="false" Text='<%# Eval("varMobileNo") %>' runat="server" ID="varMobileNoLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("VendorEmail") %>' runat="server" ID="VendorEmailLabel" />
                
                <asp:Label Visible="false" Text='<%# Eval("CustomerName") %>' runat="server" ID="CustomerNameLabel" />
                 
                <asp:Label Visible="false" Text='<%# Eval("CustomerMobile") %>' runat="server" ID="CustomerMobileLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("CustomerEmail") %>' runat="server" ID="CustomerEmailLabel" />
              
                <asp:Label Visible="false" Text='<%# Eval("VendorImage") %>' runat="server" ID="VendorImageLabel" />
              
                <asp:Label Visible="false" Text='<%# Eval("ServiceName") %>' runat="server" ID="ServiceNameLabel" />
           
                <asp:Label Visible="false" Text='<%# Eval("ServiceDescription") %>' runat="server" ID="ServiceDescriptionLabel" />
               
                <asp:Label Visible="false" Text='<%# Eval("CountryName") %>' runat="server" ID="CountryNameLabel" />
             
                <asp:Label Visible="false" Text='<%# Eval("CityName") %>' runat="server" ID="CityNameLabel" />
           
                <asp:Label Visible="false" Text='<%# Eval("StateName") %>' runat="server" ID="StateNameLabel" />
             
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
            <div style="">
            </div>
        </LayoutTemplate>
        
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceVendorOrder" ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>' >
        </asp:SqlDataSource>
         </div>
                         </div>
                    </div>
            </section>

    <br /><br /><br /><br />
</asp:Content>

