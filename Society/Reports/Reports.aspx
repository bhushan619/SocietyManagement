<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Society_Reports_Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      
	<div class="container-fluid">
		<div class="row">
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
		</div>
		<div class="col-md-3">
			<div class="info-tile tile-teal">
				<div class="tile-icon"><i class="ti ti-user"></i></div>
				<div class="tile-heading"><span>Total Visitors</span></div>
				<div class="tile-body"><span><asp:Label ID="lblVisitor" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-danger"><a href="VisitorReport.aspx">Read more..</a></span></div>
			</div>
		</div>
		
	</div>

	<div class="row">
        
		<div class="col-md-3">
			<div class="info-tile tile-blue">
				<div class="tile-icon"><i class="ti ti-comments"></i></div>
				<div class="tile-heading"><span>Total Complaints</span></div>
				<div class="tile-body"><span><asp:Label ID="lblcomplaints" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"><a href="ComplaintReports.aspx">Read more..</a></span></div>
			</div>
		</div>
	
    		<div class="col-md-3">
			<div class="info-tile tile-purple">
				<div class="tile-icon"><i class="ti ti-comments-smiley"></i></div>
				<div class="tile-heading"><span>Total Requests</span></div>
				<div class="tile-body"><span><asp:Label ID="lblrequest" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"><a href="RequestReport.aspx">Read more..</a></span></div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="info-tile tile-primary">
				<div class="tile-icon"><i class="ti ti-file"></i></div>
				<div class="tile-heading"><span>Total Documents Uploaded</span></div>
				<div class="tile-body"><span><asp:Label ID="lbldocument" runat="server" Text="0"></asp:Label></span></div>
				<div class="tile-footer"><span class="text-success"><a href="DocumentReport.aspx">Read more..</a></span></div>
			</div>
		</div> <div class="col-md-3">
			<div class="info-tile tile-info">
				<div class="tile-icon"><i class="ti ti-user"></i></div>
				<div class="tile-heading"><span>Yearwise Payment Report</span></div>
				<div class="tile-body"><span>see</span></div>
				<div class="tile-footer"><span class="text-danger"><a href="Yearwisepayment.aspx">Read more..</a></span></div>
			</div>
		</div>
        	
		
	</div>

	<div class="row">
   
	<%--	<div class="col-md-3">
			<div class="info-tile tile-lime">
				<div class="tile-icon"><i class="ti ti-support"></i></div>
				<div class="tile-heading"><span>Accounting</span></div>
				<div class="tile-body"><span>$2.5k</span></div>
				<div class="tile-footer"><span class="text-success">+15.4% <i class="ti ti-arrow-up"></i></span></div>
			</div>
		</div><div class="col-md-3">
			<div class="info-tile tile-brown">
				<div class="tile-icon"><i class="ti ti-shopping-cart"></i></div>
				<div class="tile-heading"><span>Service Report</span></div>
				<div class="tile-body"><span>$30.2k</span></div>
				<div class="tile-footer"><span class="text-danger">-22.4% <i class="ti ti-arrow-down"></i></span></div>
			</div>
		</div>--%>
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
	</div>

</asp:Content>

