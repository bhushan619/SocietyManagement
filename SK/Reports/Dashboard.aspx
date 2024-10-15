<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="SK_Reports_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid">
		
 <div class="row">
     <div class="col-md-3">
			<div class="info-tile tile-lime">
				<div class="tile-icon"><i class="ti ti-support"></i></div>
				<div class="tile-heading"><span>Event</span></div>
				<div class="tile-body"><span><asp:Label ID="lblTotalevent" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"></span></div>
			</div>
		</div>
    <div class="col-md-3">
				<div class="info-tile tile-purple">
				<div class="tile-icon"><i class="ti ti-gift"></i></div>
				<div class="tile-heading"><span>Requests</span></div>
				<div class="tile-body"><span>  <asp:Label ID="lblTopRequests" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"></div>
			</div>
		</div> 
    <div class="col-md-3">
			<div class="info-tile  tile-info">
				<div class="tile-icon"><i class="ti ti-view-list-alt"></i></div>
				<div class="tile-heading"><span>Classifieds</span></div>
				<div class="tile-body"><span>  <asp:Label ID="lblTopClassifieds" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"></div>
			</div>
		</div>
     
     <div class="col-md-3">
			<div class="info-tile tile-blue">
				<div class="tile-icon"><i class="ti ti-comments"></i></div>
				<div class="tile-heading"><span>Total Complaints</span></div>
				<div class="tile-body"><span><asp:Label ID="lblcomplaints" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"></span></div>
			</div>
		</div>
       </div>
 <div class="row">
      <div class="col-md-3">
			<div class="info-tile tile-brown">
				<div class="tile-icon"><i class="ti ti-shopping-cart"></i></div>
				<div class="tile-heading"><span>Support</span></div>
				<div class="tile-body"><span><asp:Label ID="lbltotsupport" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-danger"></span></div>
			</div>
		</div>
     		<div class="col-md-3">
			<div class="info-tile tile-lime">
				<div class="tile-icon"><i class="ti ti-support"></i></div>
				<div class="tile-heading"><span>Enquiry</span></div>
				<div class="tile-body"><span><asp:Label ID="lblTotalenquiry" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"></span></div>
			</div>
		</div>
    
		<div class="col-md-3">
			<div class="info-tile tile-indigo">
				<div class="tile-icon"><i class="ti ti-menu-alt"></i></div>
				<div class="tile-heading"><span>Polls</span></div>
				<div class="tile-body"><span><asp:Label ID="lbltotalpoll" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-danger"></span></div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="info-tile tile-green">
				<div class="tile-icon"><i class="ti ti-video-camera"></i></div>
				<div class="tile-heading"><span>Help</span></div>
				<div class="tile-body"><span><asp:Label ID="lbltotalhelp" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"></span></div>
			</div>
		</div>
     <div class="col-md-3">
			<div class="info-tile tile-green">
				<div class="tile-icon"><i class="ti ti-video-camera"></i></div>
				<div class="tile-heading"><span>Notices</span></div>
				<div class="tile-body"><span><asp:Label ID="lbltotalNotices" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"></span></div>
			</div>
		</div>
     </div>




	<div class="row">
   
		    
        	<div class="col-md-3">
			    <div class="info-tile tile-teal">
				    <div class="tile-icon"><i class="ti ti-user"></i></div>
				    <div class="tile-heading"><span>Total Admins</span></div>
				    <div class="tile-body"><span><asp:Label ID="lbltotaladmin" runat="server" Text="0"></asp:Label></span></div>
				    <div class="tile-footer"></div>
			    </div>
		    </div>
        <div class="col-md-3">
			    <div class="info-tile  tile-brown">
				    <div class="tile-icon"><i class="ti ti-user"></i></div>
				    <div class="tile-heading"><span>Total Employees</span></div>
				    <div class="tile-body"><span>  <asp:Label ID="lblTopEmployees" runat="server" Text="0"></asp:Label></span></div>
				    <div class="tile-footer"></div>
			    </div>
		</div> 
        <div class="col-md-3">
			    <div class="info-tile tile-success">   	
				    <div class="tile-icon"><i class="ti ti-home"></i></div>
				    <div class="tile-heading"><span>Total Properties</span></div>
				    <div class="tile-body"><span>
                    <asp:Label ID="lblTopProperties" runat="server" Text="0"></asp:Label></span></div>
				    <div class="tile-footer"></div>
			    </div>
		    </div> 
         <div class="col-md-3">
        	    <div class="info-tile  tile-brown">
				    <div class="tile-icon"><i class="ti ti-user"></i></div>
				    <div class="tile-heading"><span>Total Vendor</span></div>
				    <div class="tile-body"><span>  <asp:Label ID="lbltotalvendor" runat="server" Text="0"></asp:Label></span></div>
				    <div class="tile-footer"><span class="text-success"><a href="../Vendors/ViewVendor.aspx">Read more..</a></span></div>
			    </div>
             </div>
       <div class="col-md-3">
			<div class="info-tile tile-indigo">
				<div class="tile-icon"><i class="ti ti-menu-alt"></i></div>
				<div class="tile-heading"><span>Total Society</span></div>
				<div class="tile-body"><span><asp:Label ID="lbltotalsociety" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"><a href="../View/Viewsociety.aspx">Read more..</a></span></div>
			</div>
		</div>
			                     
		<%--                            </div>  
        <div class="col-md-3">
			<div class="info-tile tile-primary">
				<div class="tile-icon"><i class="ti ti-file"></i></div>
				<div class="tile-heading"><span>Total Documents Uploaded</span></div>
				<div class="tile-body"><span><asp:Label ID="lbldocument" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"><a href="DocumentReport.aspx">Read more..</a></span></div>
			</div>
		</div>
         --%>
        	
        
       
		<%--<div class="col-md-3">
			<div class="info-tile tile-indigo">
				<div class="tile-icon"><i class="ti ti-menu-alt"></i></div>
				<div class="tile-heading"><span>Tasks</span></div>
				<div class="tile-body"><span>17</span></div>
				<div class="tile-footer"><span class="text-danger">-26.4% <i class="ti ti-arrow-down"></i></span></div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="info-tile tile-green">
				<div class="tile-icon"><i class="ti ti-video-camera"></i></div>
				<div class="tile-heading"><span>Videos</span></div>
				<div class="tile-body"><span>31</span></div>
				<div class="tile-footer"><span class="text-success">+6.4% <i class="ti ti-arrow-up"></i></span></div>
			</div>
		</div>--%>
	</div>
       <%-- <div class="row">
            <div class="col-md-3">
			<div class="info-tile tile-danger">
				<div class="tile-icon"><i class="ti ti-check-box"></i></div>
				<div class="tile-heading"><span>Total Invoices</span></div>
				<div class="tile-body"><span><asp:Label ID="lbltotalinvoices" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"><a href="FlatwiseReport.aspx">Read more..</a></span></div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="info-tile tile-warning">
				<div class="tile-icon"><i class="ti ti-money"></i></div>
				<div class="tile-heading"><span>Total Paid Invoices</span></div>
				<div class="tile-body"><span><asp:Label ID="lblTopInvoicePaid" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-danger"><a href="InvoicePaid.aspx">Read more..</a></span></div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="info-tile tile-success">
				<div class="tile-icon"><i class="ti ti-thumb-down"></i></div>
				<div class="tile-heading"><span>Total Unpaid Invoices</span></div>
				<div class="tile-body"><span><asp:Label ID="lblunpaid" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"><a href="InvoiceUnpaid.aspx">Read more..</a></span></div>
			</div>
		</div>--%>
		<%--<div class="col-md-3">
			<div class="info-tile tile-teal">
				<div class="tile-icon"><i class="ti ti-user"></i></div>
				<div class="tile-heading"><span>Total Visitors</span></div>
				<div class="tile-body"><span><asp:Label ID="lblVisitor" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-danger"><a href="VisitorReport.aspx">Read more..</a></span></div>
			</div>
		</div>--%>
		
	</div>

	
	</div>
</asp:Content>

