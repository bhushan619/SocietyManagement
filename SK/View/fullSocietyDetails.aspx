<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="fullSocietyDetails.aspx.cs" Inherits="SK_View_fullSocietyDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> <div class="row">
   
	<div class="row">
		<div class="col-md-12"> 
            <div class="col-md-8">
					<div class="panel panel-default">
					    <%--<div class="panel-heading">
					    	<h2>About</h2>
					    </div>--%>
						<div class="panel-body">
					      				
                                             <div class="about-area">
						      	<h4><i class=" ti ti-home"></i>&nbsp; Society Information</h4>
								    <div class="table-responsive">
								      <table class="table">
								        <tbody>
                                               <tr>
								            <th>Registration Number</th>
								            <td>
                                                <asp:Label ID="lblssRegistrationno" runat="server" Text=""></asp:Label></td>
								          </tr>
								         <tr>
								            <th>Society Name</th>
								            <td>
                                                <asp:Label ID="lblSSSocietyname" runat="server" Text=""></asp:Label></td>
								          </tr>
								          <tr>
								            <th>Mobile Number</th>
								            <td>
                                                <asp:Label ID="lblssMobileNo" runat="server" Text=""></asp:Label></td>
								          </tr>
                                                <tr>
								            <th>Phone Number</th>
								            <td>
                                                <asp:Label ID="lblssPhone" runat="server" Text=""></asp:Label></td>
								          </tr>
								           <tr>
								            <th> Email-ID</th>
								            <td>
                                                <asp:Label ID="lblssemailid" runat="server" Text=""></asp:Label></td>
								          </tr>
                                               <tr>
								            <th>Fax</th>
								            <td>
                                                <asp:Label ID="lblssfax" runat="server" Text=""></asp:Label></td>
								          </tr>
                                             <tr>
								            <th>State</th>
								            <td>
								            	 <asp:Label ID="lblsscounty" runat="server" Text=""></asp:Label> 
								            </td>
								          </tr>
                                              <tr>
								            <th>State</th>
								            <td>
								            	 <asp:Label ID="lblssstate" runat="server" Text=""></asp:Label> 
								            </td>
								          </tr>
                                             <tr>
								            <th>City</th>
								            <td>
								            	 <asp:Label ID="lblssscity" runat="server" Text=""></asp:Label> 
								            </td>
								          </tr>
                                            
                                             <tr>
								            <th>Society Address</th>
								            <td>
								            	 <asp:Label ID="lblssaddress" runat="server" Text=""></asp:Label> 
								            </td>
								          </tr>
								        
								        </tbody>
								      </table>
								    </div>
                          </div>
                                                  				<div class="about-area">
						      	<h4><i class=" ti ti-user"></i>&nbsp; Society Contact Information</h4>
								    <div class="table-responsive">
								      <table class="table">
								        <tbody>
								         <tr><th>Full Name

								              </th> <td> <asp:Label ID="lblcFullName" runat="server" Text=""></asp:Label>

								                    </td> </tr>
								         
								         
								          <tr>
								            <th>Mobile Number</th>
								            <td>
                                                <asp:Label ID="lblcMobile" runat="server" Text=""></asp:Label></td>
								          </tr>
                                                <tr>
								            <th>Phone Number </th>
								            <td>
                                                <asp:Label ID="lblcphone" runat="server" Text=""></asp:Label></td>
								          </tr>
								           <tr>
								            <th> Email-ID</th>
								            <td>
                                                <asp:Label ID="lblcEmail" runat="server" Text=""></asp:Label></td>
								          </tr>
                                              
								        </tbody>
								      </table>
								    </div>
							</div>
                                              </div>
                     </div>
					</div>
             
                            <div class="col-md-4">
                                 <div class="row">
		<div class="col-md-12">
			<div class="info-tile info-tile-alt tile-success">
				<div class="tile-icon"><i class="ti ti-thumb-up"></i></div>
             
				<div class="tile-heading"><span>Account Summary</span></div>
				<div class="tile-body"><span>
                    <asp:Localize ID="lblAccountSumary" Text="0" runat="server"></asp:Localize></span></div>
				<div class="tile-footer"></div>
			</div>
		</div>
              </div> 
			<div class="row">
		<div class="col-md-12">
            <asp:ListView ID="lstVendorSummary" runat="server">
               
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                 
                <ItemTemplate>
                    <tr style=""> 
                        <td>
                            <asp:Label Text='<%# Eval("ServiceName") %>' runat="server" ID="ServiceNameLabel" /></td> 
                         <td>
                            <asp:Label Text='<%# Eval("Vendors") %>' runat="server" ID="VendorsLabel" /></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate> 
                    <table runat="server" id="itemPlaceholderContainer" class="table table-bordered"  border="0">
                        <tr runat="server" >
                                     
                            <th runat="server">Service Name</th>  
                                <th runat="server">Service used times </th>
                        </tr>
                        <tr runat="server" id="itemPlaceholder"></tr>
                    </table> 
                </LayoutTemplate>
                 
            </asp:ListView>
             
        </div>
          </div>     
                                <div class="row">
                <div class="col-md-12">
			<div class="info-tile info-tile-alt tile-lime">
				<div class="tile-icon"><i class="ti ti-money"></i></div>
				<div class="tile-heading"><span>Healthcare Summary</span></div>
				<div class="tile-body"><span>$2.5k</span></div>
				<div class="tile-footer"><span class="text-success"><a href="SocietyHealthcareSummary.aspx">Read more..</a></span></div>
			</div>
		</div>
                </div>
							</div>
						
				</div>
        </div>
		</div>
   	
</asp:Content>