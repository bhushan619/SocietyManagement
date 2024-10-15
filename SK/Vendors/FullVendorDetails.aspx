<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="FullVendorDetails.aspx.cs" Inherits="SK_Vendors_FullVendorDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <div class="row">
<div class="col-md-12">
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSourceVendorList" >
          
           
                       <EmptyDataTemplate>
                        <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                            <tr >
                            <td  >
                                <div class="alert alert-dismissable alert-info "  style="width:100%" >
						            <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					            </div>
                            </td>
                            </tr>
                        </table>
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
											<img src='<%# "../../Services/Vendor/VendorImages/"+ Eval("varImage")%>' alt='<%# Eval("varName") %>' height="350" width="300">
											<a href='<%# "../../Services/Vendor/VendorImages/"+ Eval("varImage")%>'  class="popup-img overlay-link" title='<%# Eval("varName") %>'><i class="icon-plus-1"></i></a>
										</div> 
									</div> 
								</div>
								<div class="col-md-8">
									<h2>Description</h2>
									<p> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="varDescriptionLabel" /></p>
								 	<hr class="mb-10">
									<div class="clearfix mb-20">
								<%--	<span aria-readonly="true">
										<i  class='<%# (int)Eval("intRating")  >= 1 ? "fa fa-star text-default" : "fa fa-star" %>'></i>
										<i  class='<%# (int)Eval("intRating")  >= 2  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
                                        <i  class='<%# (int)Eval("intRating")  >= 3  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
                                        <i  class='<%# (int)Eval("intRating")  >= 4  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
                                        <i  class='<%# (int)Eval("intRating")  >= 5  ? "fa fa-star text-default" : "fa fa-star" %>'></i>
									</span>    
                                         <p>
                                        Timing : <i class='<%# (bool)Eval("intOnTime") == true  ? "fa fa-thumbs-up text-default" : "fa fa-thumbs-down" %>'></i> 
                                            Quality : <i class='<%# (bool)Eval("intQuality") == true  ? "fa fa-thumbs-up text-default" : "fa fa-thumbs-down" %>'></i>
                                    </p>--%>
                                                 
									</div>  
									<div class="light-gray-bg p-20 bordered clearfix">
										<span class="product price"><h4>Visiting Charges</h4>  <i class="fa fa-inr"></i>
            <asp:Label Text='<%# Eval("varCharges") %>' runat="server" ID="Label1" /></span>
										<div class="product elements-list pull-right clearfix">
											<a  title="BACK" href="ViewVendor.aspx" class="margin-clear btn btn-success">BACK</a>
                                        
										</div>
									</div>
								</div>
							</div> 
                      
                  
                </span>
            </ItemTemplate>
            <LayoutTemplate>
                <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                <div style="">
                </div>
            </LayoutTemplate>
            
        </asp:ListView>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourceVendorList"  ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>' ></asp:SqlDataSource>
                       </div>
    </div>
					 
                   <div class="row">
                       <div class="col-lg-12">
<asp:ListView ID="lstRating" runat="server" DataSourceID="SqlDataSource1"> 
                                  <EmptyDataTemplate>
                                       <span>	<div class="alert alert-warning alert-dismissible text-center" role="alert">
								 
								<strong>Opps..!!!</strong> No Reviews yet.
							</div></span>

                                  </EmptyDataTemplate> 
                                   
                                  <ItemTemplate>
                                     <div class="col-sm-6"> 
                                          <p>  <asp:Label Text='<%# Eval("varName") %>' runat="server" ID="varNameLabel" /> Says : <asp:Label Text='<%# Eval("varReview") %>' runat="server" ID="varReviewLabel" /></p>
                                          <p>  
                                                        <span aria-readonly="true">
											                <i  class='<%# (int)Eval("intRating")  >= 1 ? "fa fa-star text-primary" : "fa fa-star" %>'></i>
											                <i  class='<%# (int)Eval("intRating")  >= 2  ? "fa fa-star text-primary" : "fa fa-star" %>'></i>
                                                            <i  class='<%# (int)Eval("intRating")  >= 3  ? "fa fa-star text-primary" : "fa fa-star" %>'></i>
                                                            <i  class='<%# (int)Eval("intRating")  >= 4  ? "fa fa-star text-primary" : "fa fa-star" %>'></i>
                                                            <i  class='<%# (int)Eval("intRating")  >= 5  ? "fa fa-star text-primary" : "fa fa-star" %>'></i>
										                </span> 
													 </p>
                                                    <p>
                                                        Timing : <i class='<%# (bool)Eval("intOnTime") == true  ? "fa fa-thumbs-up text-primary" : "fa fa-thumbs-down" %>'></i> 
                                                         Quality : <i class='<%# (bool)Eval("intQuality") == true  ? "fa fa-thumbs-up text-primary" : "fa fa-thumbs-down" %>'></i>
                                                    </p>
                                      </span>
                                      <hr />
                                         </div>
                                  </ItemTemplate>
                                  <LayoutTemplate>
                                      <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                                      <div style="">
                                      </div> 
                                  </LayoutTemplate> 
                              </asp:ListView>
                       </div>
                             
                             <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ConnectionStringServices %>' ProviderName='<%$ ConnectionStrings:ConnectionStringServices.ProviderName %>'  ></asp:SqlDataSource>
                      
						 </div>         	
						 
						
						 
                         
</asp:Content>



