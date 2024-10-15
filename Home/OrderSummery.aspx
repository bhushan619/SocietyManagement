<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="OrderSummery.aspx.cs" Inherits="Home_OrderSummery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="main-container">

				<div class="container">
					<div class="row">

						<!-- main start -->
						<!-- ================ -->
						<div class="main col-md-12">

							<!-- page-title start -->
							<!-- ================ -->
							<h1 class="page-title">Service Booking Summary</h1>
							<div class="separator-2"></div>
							<!-- page-title end -->

							<fieldset>
								 
								<div   class="form-horizontal" id="billing-information">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label ID="lblmaildate" runat="server" Text="Label" Visible="false"></asp:Label>
                                             <asp:Label ID="lblmailtime" runat="server" Text="Label" Visible="false"></asp:Label>
                                                 <asp:Label ID="lblservicename" runat="server" Text="Label" Visible="false"></asp:Label>
										<div class="row">
											<h3 class="title">Personal Info</h3>
                                            <hr />
										</div>
										<div class="row">

											<div class="form-group">
												<label  class="col-md-2 ">Name:</label>
												<div class="col-md-10">
													<asp:Label ReadOnly="true" ID="txtName" onkeydown = "return isAlpha(event.keyCode);" onpaste = "return false;"   runat="server" required="required" CssClass="" placeholder="Name"></asp:Label>  
												</div>
											</div>
										 
											<div class="form-group">
												<label for="billingTel" class="col-md-2 ">Mobile:</label>
												<div class="col-md-10">
													<asp:Label ReadOnly="true" ID="txtMobile" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12" required="required" runat="server" CssClass="" placeholder="Mobile No " ></asp:Label>  
												</div>
											</div>
											 
											<div class="form-group">
												<label for="billingemail" class="col-md-2 ">Email:</label>
												<div class="col-md-10">
													<asp:Label  ReadOnly="true" ID="txtEmail" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)"  required="required" runat="server" CssClass="" placeholder="Email-Id"></asp:Label>  
												</div>
											</div>
										</div>
									</div>
                                             
                                                                     <div class="col-md-4">

									<div class="row">
											<h3 class="title">Your Address</h3>
                                        <hr />
										</div>
									<div class="row">
											
										<div class="form-group">
												<label for="billingCity" class="col-md-3 ">Country:</label>
												<div class="col-md-9">
													  <asp:Label Enabled="false" ID="ddlCountry"  required="required"  runat="server" CssClass="" >
                                                </asp:Label>
												</div>
											</div>
                                            <div class="form-group">
												<label for="billingCity" class="col-md-3 ">State:</label>
												<div class="col-md-9">
													  <asp:Label Enabled="false" ID="ddlState"   required="required"  runat="server" CssClass="">
                                                 
                                                   
                                                </asp:Label>			
												</div>
											</div>
										 
												<div class="form-group">
												<label for="billingCity" class="col-md-3 ">City:</label>
												<div class="col-md-9">
													  <asp:Label Enabled="false" ID="ddlCity"  required="required"  runat="server" CssClass="">
                                                                                                
                                                </asp:Label>
												</div>
											</div>
                                            <div class="form-group">
												<label for="billingAddress1" class="col-md-3 ">Address:</label>
												<div class="col-md-9">
													<asp:Label ReadOnly="true" ID="txtAddress" required="required" runat="server" TextMode="MultiLine" CssClass="" placeholder="Address "></asp:Label>  
												</div>
											</div> 
                                             <div class="form-group">
												<label for="billingAddress1" class="col-md-3 ">Landmark:</label>
												<div class="col-md-9">
												 <asp:Label ReadOnly="true" ID="txtLandmark" runat="server" CssClass="" placeholder="Landmark (Optional)"></asp:Label>  
										        </div>
											</div>
										</div>
									</div>
                                        <div class="col-md-4">
                                            	<div class="row">
											<h3 class="title">Order Info</h3>
                                                    <hr />
										</div>
                                             <asp:ListView ID="lstOrder" runat="server" DataSourceID="SqlDataSourceServiceByCode">
                                 
                                <EmptyDataTemplate>
                                    <table id="Table1" runat="server" style="">
                                        <tr>
                                            <td>No data was returned.</td>
                                        </tr>
                                    </table>

                                </EmptyDataTemplate> 
                                   <ItemTemplate>
                                       <span >

                                       
                                       <div class="row">  
                                           <div class="form-group">
												<label  class="col-md-5 ">Service Name:</label>
												<div class="col-md-7">
													<asp:Label Text='<%# Eval("serName") %>' runat="server" ID="varNameLabel" /> 
												</div>
											</div>
                                           <div class="form-group">
												<label  class="col-md-5 ">Service Provider:</label>
												<div class="col-md-7">
													<asp:Label Text='<%# Eval("varName") %>' runat="server" ID="Label2" />
												</div>
											</div>
                                           <div class="form-group">
												<label  class="col-md-5 ">Date-Time:</label>
												<div class="col-md-7">
													<asp:Label Text='<%# Eval("Dte") %>' runat="server" ID="Label3" />
												</div>
											</div>
                                           <div class="form-group">
												<label  class="col-md-5 ">Fees:</label>
												<div class="col-md-7">
													<i class="fa fa-inr" ></i><asp:Label Text='<%# Eval("varCharges") %>' runat="server" ID="varVisitingFeeLabel" />
												</div>
											</div>
                                           <div class="form-group">
												<label  class="col-md-5 ">Total Fees:</label>
												<div class="col-md-7">
													<i class="fa fa-inr" ></i><asp:Label Text='<%# Eval("varCharges") %>' runat="server" ID="Label1" />
												</div>
											</div>
                                   </div>
                                           </span>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div runat="server" id="itemPlaceholderContainer" style="">
                                        <span runat="server" id="itemPlaceholder" />

                                    </div>
               

                                </LayoutTemplate>
                                 
                            </asp:ListView>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourceServiceByCode" ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>'></asp:SqlDataSource>
                          
                                        </div>
                                       
                                    </div>
									
									
									  
								</div>
							</fieldset>
							 <div class="space-bottom"></div>
                              
							<div class="text-right">	
								<a href="KattaVendor.aspx" class="btn btn-group btn-default">< Go Back To Services</a>
								<asp:Button ID="btnPayment" runat="server" CssClass="btn btn-group btn-success" OnClick="btnPayment_Click" Text="Book Service >">  </asp:Button>
							</div>

						</div>
						<!-- main end -->

					</div>
				</div>
			</section>
    
</asp:Content>

