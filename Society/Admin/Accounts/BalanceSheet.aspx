<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="BalanceSheet.aspx.cs" Inherits="Society_Admin_Accounts_BalanceSheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
                         <div class="col-md-12">
                               
                                <div class="col-md-5">
                <div class="form-group">
                  
                    <div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                    <asp:TextBox ID="txtStartDate" placeholder="From Date" runat="server" required CssClass="form-control"></asp:TextBox>
                                  
                        
                    </div><!-- /.input group -->
                  </div> 
                                </div>
                                <div class="col-md-5">
               <div class="form-group">
                  
                    <div class="input-group">
                  <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                    
                 
                          <asp:TextBox ID="txtEndDate" placeholder="To Date"  runat="server" required CssClass="form-control"></asp:TextBox>
                                
                    </div><!-- /.input group -->
                  </div> 
                                </div>

                               <div class="col-md-2"> 
                                      
                                         
                                          <asp:Button CssClass="btn btn-info" id="btnsearch" Text="Search" runat="server"  OnClick="btnsearch_Click"></asp:Button>
                                         
                                           
                  </div>
                                   
                         </div>
                    </div>

     <div class="row"> 
            
			<div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>Balance Sheet</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body no-padding  table-responsive">
                                                    
                    <div id="dvContents" >
                               <div class="row text-center" id="divmyheader" runat="server" visible="false">
                                    
                                <h4>  Balance Sheet </h4> </div> 
                                      <div class="col-xs-6  table-responsive" > 
                                    <asp:GridView ID="gdvAccount" ShowFooter="True"    CssClass="table table-bordered"   runat="server" AutoGenerateColumns="False"  OnRowDataBound="gdvAccount_RowDataBound" >
                                         <Columns> 
                                  <asp:BoundField DataField="Account Name" HeaderText="Details - Credit"   FooterText="Total Credit :" FooterStyle-CssClass="text-bold"  ControlStyle-Font-Bold="false"/>              
                                  <asp:BoundField DataField="Amount" HeaderText="Amount" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right text-bold" />                                              
            
        </Columns>   <EmptyDataTemplate>

         <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                             <tr >
                                                               <td  >
                                                                 	<div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                </div>
                                                               </td>
                                                              </tr>
                                                         </table>

        </EmptyDataTemplate> <PagerSettings Mode="Numeric" />
                                    </asp:GridView>
                                 </div> 
                         <div class="col-xs-6 table-responsive" >
                                   
                                    <asp:GridView ID="grdAccountNave" ShowFooter="True"    CssClass="table table-bordered"   runat="server" AutoGenerateColumns="False"  OnRowDataBound="grdAccountNave_RowDataBound" >
                                         <Columns> 
                                  <asp:BoundField DataField="Account Name" HeaderText="Details - Debit"   FooterText="Total Debit :" FooterStyle-CssClass="text-bold"  ControlStyle-Font-Bold="false"/>              
                                  <asp:BoundField DataField="Amount" HeaderText="Amount" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right text-bold"  />  
                                           
        </Columns>   <EmptyDataTemplate>

         <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                             <tr >
                                                               <td  >
                                                                 	<div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                </div>
                                                               </td>
                                                              </tr>
                                                         </table>

        </EmptyDataTemplate> <PagerSettings Mode="Numeric" />
                                    </asp:GridView>
                                 </div>
                                  
                         </div>
                                                   </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                      
                                                     </div>
                 </div>
                </div>
            </div>
               
</asp:Content>

