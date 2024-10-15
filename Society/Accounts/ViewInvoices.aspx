<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="ViewInvoices.aspx.cs" Inherits="Society_Accounts_ViewInvoices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Designs/js/jspdf.debug.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
   <script>
       $(document).ready(function () {
           $('#download').click(function () {
               var pdf = new jsPDF('p', 'pt', 'letter')
               , source = $('#PrintDiv')[0]
               , specialElementHandlers = {
                   '#bypassme': function (element, renderer) {
                       return true
                   }
               }

               margins = {
                   top: 60,
                   bottom: 60,
                   left: 40,
                   width: 522
               };
               // all coords and widths are in jsPDF instance's declared units
               // 'inches' in this case
               pdf.fromHTML(
                   source // HTML string or DOM elem ref.
                   , margins.left // x coord
                   , margins.top // y coord
                   , {
                       'width': margins.width // max width of content on PDF
                       , 'elementHandlers': specialElementHandlers
                   },
                   function (dispose) {
                       // dispose: object with X, Y of the last line add to the PDF
                       //          this allow the insertion of new lines after html
                       pdf.save('Downloaded.pdf');
                   },
                   margins
                 )
           });

       });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
      
<div class="row" id="PrintDiv">
    <div class="col-md-12">
        <div class="panel panel-info">
            <div class="panel-body">
                <div class="clearfix">
                    <div class="pull-left">
                        <img src="../../Designs/img/logo-big.png" class="mt-md mb-md">
                        <address class="mt-md mb-md">
                            <strong><asp:Localize ID="lblSocietyName" runat="server"></asp:Localize></strong><br>
                            <asp:Localize ID="lblSocietyAddress" runat="server"></asp:Localize><br />
                             <asp:Localize ID="lblSocietyState" runat="server"></asp:Localize>, 
                             <asp:Localize ID="lblSocietyCity" runat="server"></asp:Localize>, 
                             <asp:Localize ID="lblSocietyPIN" runat="server"></asp:Localize>
                        </address>
                    </div>
                    <div class="pull-right">
                        <h1 class="text-primary text-right" style="font-weight: normal;">
                            INVOICE
                            <small style="display: block;">#<asp:Localize ID="lblInvoiceNo" runat="server"></asp:Localize></small>
                        </h1> 
                    </div>
                </div>
                <hr>
                <div class="row mb-xl">
                    <!-- <div class="col-md-12">
                        <h1 class="text-primary text-center" style="font-weight: normal;">INVOICE</h1>
                    </div> -->
                    <div class="col-md-12">
                        <div class="pull-left">
                            <h3 class="text-muted">To</h3>
                            <address>
                                 <asp:Localize ID="lblPropertyOwner" runat="server"></asp:Localize>,<br />
                                 <asp:Localize ID="lblPropertyAddress" runat="server"></asp:Localize>,<br />
                               <strong><asp:Localize ID="lblPropertySociety" runat="server"></asp:Localize></strong>
                            </address>
                        </div>
                        <div class="pull-right">
                            <h3 class="text-muted">Info</h3>
                            <ul class="text-left list-unstyled">
                                <li><strong>Date:</strong>  <asp:Localize ID="lblDate" runat="server" Text="Select Date"></asp:Localize></h3></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row mb-xl">
                    <div class="col-md-12">
                        <div class="panel">
                            <div class="panel-body no-padding">
                                <div class="table-responsive">
                                     <asp:ListView ID="lstInvoiceDetails" runat="server" >  
                                        <EmptyDataTemplate>
                                            <table runat="server" style="">
                                                <tr>
                                                    <td><div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found.. Please enter details!!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                </div></td>
                                                </tr>
                                            </table>
                                        </EmptyDataTemplate>
                                         
                                        <ItemTemplate>
                                             <tbody>
                                            <tr style="">
                                               
                                                  <td>
                                                    <asp:Label Text='<%#Container.DataItemIndex+1 %>' runat="server" ID="Label1" /></td>
                                                  
                                                  <td  class="text-left">
                                                    <asp:Label  Text='<%# Eval("Particulars") %>' runat="server" ID="varParticularsLabel" /></td>
                                                 <td  class="text-right">
                                                    <asp:Label   Text='<%# Eval("Amount") %>' runat="server" ID="varAmountLabel" /></td>
                                               
                                            </tr>
                                                 </tbody>
                                        </ItemTemplate>
                                        <LayoutTemplate> 
                                                        <table runat="server"  class="table table-hover table-bordered m-n" id="itemPlaceholderContainer" style="" border="0">
                                                            <tr runat="server" style="">
                                                            
                                                            <th runat="server">Sr. No.</th>
                                                                <th  class="text-left" runat="server">Particulars</th> 
                                                                <th class="text-right" runat="server">Amount</th> 
                                                                   </tr>
                                                            <tr runat="server" id="itemPlaceholder"></tr>
                                                        </table> 
                                        </LayoutTemplate> 
                                    </asp:ListView>
                                </div>
                            </div>
                        </div>
                    </div>

                     <div class="col-md-12">
                        <div class="row" style="border-top-left-radius: 0px; border-top-right-radius: 0px; border-bottom-right-radius: 0px; border-bottom-left-radius: 0px;">
                            <div class="col-md-3 col-md-offset-9">
                                <p class="text-right"><strong>SUB TOTAL: <asp:Localize ID="lblSubBill" runat="server" Text="0"></asp:Localize></strong></p>
                                <hr>
                                <h3 class="text-right text-danger" style="font-weight: bold;">RS. <asp:Localize ID="lblFinalBill" runat="server" Text="0"></asp:Localize></h3>
                            </div>
                        </div>
                    </div>
                </div>
                    
                <div class="row">
                    <div class="col-md-12">
                        <div class="pull-right">
                            <a  id="download"  class="btn btn-success"><i class="ti ti-download"></i></a>
                              <a href="javascript:window.print()" class="btn btn-inverse"><i class="ti ti-printer"></i></a>
                            <a href="Invoices.aspx" class="btn btn-primary"><i class="ti ti-back-left"></i></a>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

                            </div>  
                        
</asp:Content>

