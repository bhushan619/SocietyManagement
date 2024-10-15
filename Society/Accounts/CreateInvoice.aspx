<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="CreateInvoice.aspx.cs" Inherits="Society_Accounts_CreateInvoice" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="row">
		<div class="col-md-4 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Create Invoice For Property Owners</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal"> 
                        <div class="form-group">
								<label for="focusedinput" class="control-label">Date</label>
							 <asp:TextBox ID="txtDOB" required class="form-control" placeholder="Date" runat="server"></asp:TextBox>                       
							</div>      
                        
                        <div class="form-group">
								<label for="focusedinput" class="control-label">Particulars</label>
							 <asp:TextBox ID="txtParticulars" required TextMode="MultiLine" onkeyup="checkTextNum(this)" class="form-control" placeholder="Particulars" runat="server"></asp:TextBox>                       
							</div>
                        <div class="form-group">
								<label for="focusedinput" class="control-label">Amount</label>
							 <asp:TextBox ID="txtAmount" required  onkeyup="checkDec(this);"   class="form-control" placeholder="Amount" runat="server"></asp:TextBox>                       
							</div>
                    
                        <div class="form-group">
                            <asp:Button ID="btnAddToInvoice" OnClick="btnAddToInvoice_Click" runat="server" Text="Add to Invoice" CssClass="btn btn-primary" />
                            <a href="CreateInvoice.aspx" class="btn btn-danger">Reset</a>
                        </div>
                 
                          <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
					
					</div>
					
				</div>
				
			</div>
		</div>
        <div class="col-md-8 ">
			<div class="panel panel-info" >
			  <div class="panel-body no-padding  table-responsive">
                
                            <div class="container-fluid">
                                
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-transparent">
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
                            <%--<small style="display: block;">#10007819</small>--%>
                        </h1>
                         <h3 class="text-muted">Date : <asp:Localize ID="lblDate" runat="server" Text="Select Date"></asp:Localize></h3>
                            
                    </div>
                </div>
                <hr> 
                <div class="row mb-xl">
                    <div class="col-md-12">
                        <div class="panel">
                            <div class="panel-body no-padding">
                                <div class="table-responsive">

                                    <asp:ListView ID="lstInvoiceDetails" runat="server" OnItemCommand="lstInvoiceDetails_ItemCommand" >  
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
                                                 <td  class="text-center">
                                                    <asp:LinkButton ID="Button2" runat="server" Text="" CommandName="remove" 
   CommandArgument='<%# Container.DataItemIndex+ ":"+Eval("Amount") %>' CssClass="btn btn-xs btn-danger fa fa-times" />
                                                    
                                                </td>
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
                                                            <th class="text-center" runat="server"><i class="fafa-2x">#</i></th>
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
                            <asp:LinkButton CssClass="btn btn-primary" runat="server" ID="btnNext" OnClick="btnNext_Click">Next</asp:LinkButton>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

                            </div> <!-- .container-fluid -->
                        </div> <!-- #page-content -->
                    </div> 
            </div>
	</div> 
     </div>
</asp:Content>
 
