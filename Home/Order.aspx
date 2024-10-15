<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="Order.aspx.cs" Inherits="Home_Order" MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <section class="main-container">

				<div class="container">
					<div class="row">

						<!-- main start -->
						<!-- ================ -->
						<div class="main col-md-12">

							<!-- page-title start -->
							<!-- ================ -->
							<h1 class="page-title">Service Booking</h1>
							<div class="separator-2"></div>
							<!-- page-title end -->
                        <fieldset>
							 
								<div   class="form-horizontal" id="billing-information"> 
									<div class="row">
										<div class="col-lg-3">
											<h3 class="title">Personal Info</h3>
										</div>
										<div class="col-lg-8 col-lg-offset-1">
											<div class="form-group">
												<label for="billingFirstName" class="col-md-2 control-label">Name<small class="text-default">*</small></label>
												<div class="col-md-10">
													<asp:TextBox ID="txtName" onkeydown = "return isAlpha(event.keyCode);" onpaste = "return false;"   runat="server" required="required" CssClass="form-control" placeholder="Name"></asp:TextBox>  
												</div>
											</div>
										 
											<div class="form-group">
												<label for="billingTel" class="col-md-2 control-label">Mobile<small class="text-default">*</small></label>
												<div class="col-md-10">
													<asp:TextBox ID="txtMobile" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12" required="required" runat="server" CssClass="form-control" placeholder="Mobile No " ></asp:TextBox>  
												</div>
											</div>
											 
											<div class="form-group">
												<label for="billingemail" class="col-md-2 control-label">Email<small class="text-default">*</small></label>
												<div class="col-md-10">
													<asp:TextBox ID="txtEmail" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)"  required="required" runat="server" CssClass="form-control" placeholder="Email-Id"></asp:TextBox>  
												</div>
											</div>
										</div>
									</div>
									<div class="space"></div>
									<div class="row">
										<div class="col-lg-3">
											<h3 class="title">Your Address</h3>
										</div>
										<div class="col-lg-8 col-lg-offset-1">
											
										<div class="form-group">
												<label for="billingCity" class="col-md-2 control-label">Country<small class="text-default">*</small></label>
												<div class="col-md-10">
													  <asp:DropDownList ID="ddlCountry"  required="required"  runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>:: Select Country ::</asp:ListItem> </asp:DropDownList>
												</div>
											</div>
                                            <div class="form-group">
												<label for="billingCity" class="col-md-2 control-label">State<small class="text-default">*</small></label>
												<div class="col-md-10">
													  <asp:DropDownList ID="ddlState"   required="required"  runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>:: Select State ::</asp:ListItem>
                                                   
                                                </asp:DropDownList>			
												</div>
											</div>
										 
												<div class="form-group">
												<label for="billingCity" class="col-md-2 control-label">City<small class="text-default">*</small></label>
												<div class="col-md-10">
													  <asp:DropDownList ID="ddlCity"  required="required"  runat="server" CssClass="form-control">
                                                    <asp:ListItem>:: Select City ::</asp:ListItem>                                                   
                                                </asp:DropDownList>
												</div>
											</div>
                                            <div class="form-group">
												<label for="billingAddress1" class="col-md-2 control-label">Address<small class="text-default">*</small></label>
												<div class="col-md-10">
													<asp:TextBox ID="txtAddress" required="required" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Address "></asp:TextBox>  
												</div>
											</div> 
                                             <div class="form-group">
												<label for="billingAddress1" class="col-md-2 control-label">Landmark </label>
												<div class="col-md-10">
												 <asp:TextBox ID="txtLandmark" runat="server" CssClass="form-control" placeholder="Landmark (Optional)"></asp:TextBox>  
										        </div>
											</div>
										</div>
									</div>
                                    <div class="space"></div>
                                    	<div class="row">
                                       <div class="col-md-3">
                                        <h3 class="title">Service Details</h3>
                                           </div>   
                                            	<div class="col-lg-8 col-lg-offset-1">
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
									<label  class="col-md-3 control-label">Service Name<small class="text-default">:</small></label>
												<div class="col-md-9" style="padding-top:7px">
													<asp:Label Text='<%# Eval("serName") %>' runat="server" ID="varNameLabel" /> 
												</div>
											</div>
                                           <div class="form-group">
											    
									<label  class="col-md-3 control-label">Date<small class="text-default">:</small></label>
												<div class="col-md-9" style="padding-top:7px">
													<asp:Label Text='<%# Eval("varName") %>' runat="server" ID="Label2" />
												</div>
											</div>
                                            
                                              <div class="form-group">
									<label  class="col-md-3 control-label">Fees<small class="text-default">:</small></label>
												<div class="col-md-7" style="padding-top:7px">
													<i class="fa fa-inr" ></i><asp:Label Text='<%# Eval("varCharges") %>' runat="server" ID="varVisitingFeeLabel" />
												</div>
											</div>
                                              <div class="form-group">
									<label  class="col-md-3 control-label">Total Fees<small class="text-default">:</small></label>
												<div class="col-md-7" style="padding-top:7px">
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
									  <div class="space-bottom"></div>
                                    <div class="row">
										<div class="col-lg-3">
											<h3 class="title">Date and Time</h3>
										</div>
										<div class="col-lg-8 col-lg-offset-1">
											
                                    <div class="form-group">
									<label  class="col-md-2 control-label">Date<small class="text-default">*</small></label>
								 <div class="col-md-10"> <asp:TextBox ID="txtDOB" required="required" class="form-control" placeholder=":: Select Date ::" runat="server"></asp:TextBox>
                       <%--  <input type="date" class="form-control" placeholder="Select Date"   id="txtDate" />--%>
                                      </div>
                              
								</div>
                                	<div class="form-group">
									<label  class="col-md-2 control-label">Time<small class="text-default">*</small></label>
								<div class="col-md-10">
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
                                            </div>
                                        
                              
								</div>

								
								</div>
							</fieldset>
							 
							<div class="text-right">	
								<a href="KattaVendor.aspx" class="btn btn-group btn-default">< Go Back To Services</a>
								<asp:Button ID="btnPayment" runat="server" CssClass="btn btn-group btn-success" OnClick="btnPayment_Click" Text="Service Booking Summary >">  </asp:Button>
							</div>

						</div>
						<!-- main end -->

					</div>
				</div>
			</section> 
</asp:Content>



