<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="RescheduleOrder.aspx.cs" Inherits="Home_RescheduleOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    	<section class="main-container"> 
				<div class="container">	
             <div class="row"> 
         	    <h1 class="page-title">
                     <asp:Localize ID="lblOrderOp" runat="server"></asp:Localize> Order #<asp:Label CssClass="text-default" ID="lblOrderNo" runat="server" ></asp:Label></h1> 
				 <div class="separator-2"></div>
                 <div class="row col-lg-offset-1">
                     <div class="col-md-8">
  <asp:ListView ID="lstOrders" runat="server" DataSourceID="SqlDataSourceOrders">
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate> 
        <ItemTemplate>
        
                <div class="col-md-10 ">
											<div class="listing-item bordered light-gray-bg mb-20">
												<div class="row grid-space-0">
													<div class="col-sm-6 col-md-4 col-lg-3">
														<div class="overlay-container pv-20 ph-20"> 
															<asp:Image ID="imgSimilarPic" runat="server" CssClass=" bordered"    ImageUrl='<%# "~/Services/Vendor/VendorImages/" + Eval("VendorImage") %>' Width="100" Height="100" /> 
															<a class="overlay-link popup-img-single" href='<%# "../Services/Vendor/VendorImages/" + Eval("VendorImage") %>'><i class="fa fa-search-plus"></i></a>
														 </div>
													</div>
													<div class="col-sm-6 col-md-8 col-lg-9">
														<div class="body">
															<h3 class="margin-clear"><asp:Label   Text='<%# Eval("VendorName") %>' runat="server" ID="Label1" />  </h3>
														<p> <asp:Label Text='<%# Eval("varMobileNo") %>' runat="server" ID="Label9" /></p>
                                                             <p><small>Ordered Date </small> : <asp:Label   Text='<%# Eval("CreatedDate") %>' runat="server" ID="Label6" /></p>
                                                            <p><i class="fa fa-calendar-o text-default"></i> <asp:Label   Text='<%# Eval("OrderDate") %>' runat="server" ID="Label3" />, <i class="fa fa-hourglass text-default"></i> <asp:Label   Text='<%# Eval("OrderTime") %>' runat="server" ID="Label4" /></p>
															 <p><span class="price"><i class="fa fa-inr text-default"></i> <asp:Label   Text='<%# Eval("FeesAmount") %>' runat="server" ID="Label2" /></span>
<span class="pull-right">Status :  <asp:Label CssClass='<%# (string)Eval("OrderStatus")=="Cancelled" ?"text-danger"  : (string)Eval("OrderStatus")=="Completed"?"text-success":"text-default" %>'  Text='<%# Eval("OrderStatus") %>' runat="server" ID="Label7" /></p>
															<div class="elements-list clearfix">
																
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
             
                <asp:Label Visible="false" Text='<%# Eval("PaymentStatus") %>' runat="server" ID="Payment_StatusLabel" />
              
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

                         <asp:ListView ID="lstVendorOrder" runat="server" DataSourceID="SqlDataSourceVendorOrder"> 
          <EmptyDataTemplate>
                                <span>	<div class="alert alert-warning alert-dismissible text-center" role="alert">
								 
								<strong>Opps..!!!</strong>No Orders Found.
							</div></span><br /><br />
                            </EmptyDataTemplate>
        <ItemTemplate>
        
                  <div class="col-md-10 ">
											<div class="listing-item bordered light-gray-bg mb-20">
												<div class="row grid-space-0">
													<div class="col-sm-6 col-md-4 col-lg-3">
														<div class="overlay-container pv-20 ph-20"> 
															<asp:Image ID="imgSimilarPic" runat="server"  CssClass=" bordered"  ImageUrl='<%# "~/Services/Customer/CustomerImages/" + Eval("CustomerImage") %>' Width="100" Height="100" /> 
															<a class="overlay-link popup-img-single" href='<%# "../Services/Customer/CustomerImages/" + Eval("CustomerImage") %>'><i class="fa fa-search-plus"></i></a>
														 </div>
													</div>
													<div class="col-sm-6 col-md-8 col-lg-9">
														<div class="body">
															<h3 class="margin-clear"><asp:Label   Text='<%# Eval("CustomerName") %>' runat="server" ID="Label1" /> <asp:Label Text='<%# "#"+ Eval("OrderId") %>' runat="server" ID="Label5" style="float:right" CssClass="text-default" /></h3>
														<p><asp:Label Text='<%# Eval("CustomerMobile") %>' runat="server" ID="Label8" /></p>
                                                             <p><small>Ordered Date </small> : <asp:Label   Text='<%# Eval("CreatedDate") %>' runat="server" ID="Label6" /></p>
                                                            <p><i class="fa fa-calendar-o text-default"></i> <asp:Label   Text='<%# Eval("OrderDate") %>' runat="server" ID="Label3" />, <i class="fa fa-hourglass text-default"></i> <asp:Label   Text='<%# Eval("OrderTime") %>' runat="server" ID="Label4" /></p>
															 <p><span class="price"><i class="fa fa-inr text-default"></i> <asp:Label   Text='<%# Eval("FeesAmount") %>' runat="server" ID="Label2" /></span>
                                                                <span class="pull-right">Status :  <asp:Label CssClass='<%# (string)Eval("OrderStatus")=="Cancelled" ?"text-danger"  : (string)Eval("OrderStatus")=="Completed"?"text-success":"text-default" %>'  Text='<%# Eval("OrderStatus") %>' runat="server" ID="Label7" /></p>
															 
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
             
                <asp:Label Visible="false" Text='<%# Eval("PaymentStatus") %>' runat="server" ID="Payment_StatusLabel" />
              
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
    <asp:SqlDataSource runat="server" ID="SqlDataSourceOrders" ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>' ></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="SqlDataSourceVendorOrder" ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>'></asp:SqlDataSource>
                     </div>
                     <div class="col-md-4"  >
                         <div class="form-horizontal">
                               <div id="vendor" runat="server" visible="false">
                             <div class="form-group">
									<label>Status</label>
								 <asp:DropDownList ID="ddlStatus" runat="server" required="required" CssClass="form-control " AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged"   >
                                    <asp:ListItem Value="">:: Select Status ::</asp:ListItem>
                                         <asp:ListItem Value="Started"> Start/Reschedule  </asp:ListItem> 
                                       <asp:ListItem Value="Completed"> Completed </asp:ListItem> 
                            </asp:DropDownList>
                     </div>

                                   <div class="form-group">
									<label>Description</label>
								  <asp:TextBox ID="txtUpdate" required="required" class="form-control" placeholder="Update Description" runat="server"></asp:TextBox>
                      
								</div>
                                   </div>
                               <div id="reschedule" runat="server" visible="false">
                         <div class="form-group">
									<label>Date</label>
								  <asp:TextBox ID="txtDOB" required="required" class="form-control" placeholder=":: Select Date ::" runat="server"></asp:TextBox>
                       <%--  <input type="date" class="form-control" placeholder="Select Date"   id="txtDate" />--%>
                                      
                              
								</div>
                                	<div class="form-group">
									<label>Time</label>
								 <asp:DropDownList ID="ddlTime" runat="server" required="required" CssClass="form-control "    >
                                    <asp:ListItem Value="">:: Select Time ::</asp:ListItem>
                                       <asp:ListItem Value="1">9AM to 11AM</asp:ListItem>
                                       <asp:ListItem Value="2">11AM to 1PM</asp:ListItem>
                                       <asp:ListItem Value="3">1PM to 3PM</asp:ListItem>
                                       <asp:ListItem Value="4">3PM to 5PM</asp:ListItem>
                                       <asp:ListItem Value="5">5PM to 7PM</asp:ListItem>                            
                                    </asp:DropDownList>
                                </div>
                             	</div>
                             <div id="review" runat="server" visible="false">                         
                                	<div class="form-group">
									<label>Rating</label>
								 <asp:DropDownList ID="ddlRating" runat="server" required="required" CssClass="form-control "    >
                                    <asp:ListItem Value="">:: Select Rating ::</asp:ListItem>
                                       <asp:ListItem Value="1"> Bad  </asp:ListItem>
                                       <asp:ListItem Value="2"> Fair </asp:ListItem>
                                       <asp:ListItem Value="3"> Good </asp:ListItem>
                                       <asp:ListItem Value="4"> Very good </asp:ListItem>
                                       <asp:ListItem Value="5"> Excellent </asp:ListItem>                            
                                    </asp:DropDownList>
                                </div>
                                 <div class="form-group">
									<label>Review</label>
								  <asp:TextBox ID="txtReview" required="required" class="form-control" placeholder="Please give review.." runat="server"></asp:TextBox>
                               </div>
                             	
                              <div class="form-group">                                  
									 <label>&nbsp;&nbsp;&nbsp;</label>
                                        <asp:CheckBox ID="cbkTime" runat="server"  Checked="true" Text="Timing" /> <asp:CheckBox ID="cbkQuality" runat="server" Checked="true" Text="Quality of Service" />
							    </div>
                            
                             	</div>
                         </div>
                               <div class="form-group"> 
                                     <asp:Button ID="btnReschedule"  CssClass="btn btn-default" OnClick="btnReschdule_Click" Visible="false" runat="server" Text="Update Booking Schedule" />
                                   <asp:Button ID="btnReview"  CssClass="btn btn-default" OnClick="btnReview_Click" Visible="false" runat="server" Text="Submit Review" />
                                   <a href="ViewOrders.aspx" class="btn btn-success">Back</a>
                                   </div>
                             </div>
                            </div> 
                         </div>
                         </div> 
            </section>
</asp:Content>

