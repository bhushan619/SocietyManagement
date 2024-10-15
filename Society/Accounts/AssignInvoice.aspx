<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="AssignInvoice.aspx.cs" Inherits="Society_Accounts_AssignInvoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="col-md-4 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Assign Invoice to Property Owners</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">  
				 
					     <div class="form-group">
									<label for="focusedinput"  control-label">Wing</label>
								 
										<asp:DropDownList ID="ddlWing"  runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlWing_SelectedIndexChanged"  required="required">
                               <asp:ListItem>:: Select  Wing ::</asp:ListItem>                                                      
                           </asp:DropDownList>
								 					
							 </div>
        <div class="form-group">
									<label for="focusedinput"    control-label">All Or Multiple</label>
								 
										<asp:DropDownList Enabled="false" ID="ddlAllOrMultiple"  runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlAllOrMultiple_SelectedIndexChanged"  required="required">
                               <asp:ListItem>:: Select All or Multiple ::</asp:ListItem>           
                                            <asp:ListItem>All</asp:ListItem>                                           
                                            <asp:ListItem>Multiple</asp:ListItem>
                           </asp:DropDownList>
									 							
								</div>   
                           <div class="form-group">
								<label for="focusedinput" class="control-label">Property</label>
								<select id="ddlProperty" disabled="disabled" placeholder= ":: Select Property ::"  multiple="true" style="width:100% !important"   runat="server"   >
                                         </select> 
							</div>
				</div>
                        
                    </div>
                </div>
        </div>
    
      <div class="col-md-8 ">
			<div class="panel panel-info" >
			  <div class="panel-body no-padding  table-responsive"> 
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
                            <a href="CreateInvoice.aspx" class="btn btn-warning">Back</a>
                            <asp:LinkButton CssClass="btn btn-primary" runat="server" ID="btnCreate" OnClick="btnCreate_Click">Create</asp:LinkButton>
                           
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
</asp:Content>

