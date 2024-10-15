<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="FlatwiseReport.aspx.cs" Inherits="Society_Reports_FlatwiseReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="row">
            <div class="col-lg-12">  
                    <div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2><i class="ti  ti-home"></i>Flatwise  Invoices Details </h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''>
				</div>	
			</div>
         <div class="panel-body" >
               <div id="divSearchbyDate" runat="server" >
             <div class="row"> 
                            <div class="col-lg-3 col-sm-3"></div>  
                                         <div class="col-lg-3 col-sm-3">
                           <div class="form-group">
                               <asp:TextBox ID="txtStartDate" placeholder="From Date" runat="server"  CssClass="form-control"></asp:TextBox>
                                   
                             </div>   </div>
                                 <div class="col-lg-3 col-sm-3">
                               <div class="form-group">
                              
                            <asp:TextBox ID="txtEndDate" placeholder="To Date"  runat="server"  CssClass="form-control"></asp:TextBox>
                                
                            </div>   </div>
                                <div class="col-lg-3 col-sm-3">
                                   
                            <div class="form-group">
                                <asp:Button ID="btnSearch" runat="server" Text="Search"  OnClick="btnSearch_Click" CssClass="btn btn-primary"/>
                                  <a href="FlatwiseReport.aspx"  class="btn btn-danger">Reset</a>
                            </div></div>
                        
                          </div>
                   </div>
                                                 
             <div id="divsearchbyname" runat="server" visible="false">
             <div class="row"> 
                                <div class="col-lg-3 col-sm-3"></div>  
                                         <div class="col-lg-5 col-sm-3">
                                           <div class="form-group">                                              
                                               <asp:TextBox ID="txtPropertyName" placeholder="Enter Owner Name"   runat="server"  CssClass="form-control"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="txtPropertyName_AutoCompleteExtender" runat="server" 
                                            MinimumPrefixLength="1" CompletionInterval="1" 
                                            EnableCaching="true"
                                               DelimiterCharacters=""
                                                Enabled="True" 
                                                ServiceMethod="GetCompletionList" 
                                                CompletionSetCount="1" 
                                                TargetControlID="txtPropertyName" UseContextKey="True">
                                           </cc1:AutoCompleteExtender>
                                               <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                             </div> 
                                         </div>
                                <div class="col-lg-3 col-sm-3">
                            <div class="form-group">
                                <asp:Button ID="Button1" runat="server" Text="Search"  OnClick="btnPropertySearch_Click" CssClass="btn btn-primary"/>
                                 <a href="FlatwiseReport.aspx"  class="btn btn-danger">Reset</a>
                            </div>

                                </div>
                        
                          </div>
                 </div>
             <div class="row"> 
                        <div class="col-lg-3"></div>
                        <div class="col-lg-8 col-sm-6">
                            <asp:RadioButton ID="rgbName" OnCheckedChanged="rgbName_CheckedChanged" AutoPostBack="true" runat="server" Text="By Name" CssClass="radio-inline" GroupName="g"/>
                   
                             <asp:RadioButton ID="rgbdate" OnCheckedChanged="rgbName_CheckedChanged" AutoPostBack="true" runat="server" Text="By Date" CssClass="radio-inline" GroupName="g"/>
                   <asp:RadioButton ID="rgbflat" Visible="false" OnCheckedChanged="rgbName_CheckedChanged" runat="server" AutoPostBack="true" CssClass="radio-inline" Text="By Flat" GroupName="g"/> 
                                                       
                                <asp:RadioButton ID="rgball" OnCheckedChanged="rgbName_CheckedChanged" runat="server" AutoPostBack="true" CssClass="radio-inline" Text="All" GroupName="g"/>
				</div>
                    </div>
   <div class="row">   
<div class="table-responsive">
<asp:ListView ID="lstInvoices" runat="server"  OnSorting="lstInvoices_Sorting"  OnItemCommand="lstInvoices_ItemCommand">
         
         
            <EmptyDataTemplate>
                <table id="Table2" runat="server" style="">
                    <tr>
                        <td><div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                    <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                    </div></td>
                    </tr>
                </table>
            </EmptyDataTemplate>
         
            <ItemTemplate>
                <tr style="">
                        <td>
                        <asp:Label Text='<%# Container.DataItemIndex+1 %>' runat="server" ID="Label1" /></td>
                  
                                        <td>    <asp:Label Text='<%# Eval("varWingName") %>' runat="server" ID="Label3" /></td>
                      <td>    <asp:Label Text='<%# Eval("Flat") %>' runat="server" ID="Label2" /></td>
                        <td>    <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("InvoiceNo") %>' runat="server" ID="InvoiceNoLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("Date") %>' runat="server" ID="DateLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("Amount") %>' runat="server" ID="AmountLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("[Payment Status]") %>' runat="server" CssClass='<%# Eval("[Payment Status]").ToString() == "Paid" ? "label label-success" : "label label-warning" %>'  ID="Payment_StatusLabel"/> </td>
                        <td class="text-center"> <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId") %>' CommandName="view" ToolTip="View Full Invoice"  runat="server"  CssClass=" fa fa-eye fa-2x" style="color:#558b2f"/></td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
             
                            <table runat="server" id="itemPlaceholderContainer" class="table table-bordered table-hover" border="0">
                                <tr id="Tr2" runat="server" style="">
                                        <th id="Th2" runat="server">Sr. No.</th>
                                      <th id="Th3" runat="server">Wing</th>
                                                                                                                                                
                                        <th id="Th1" runat="server">Flat No.&nbsp;<asp:ImageButton ID="imFlat" CommandArgument="Flat" CommandName="Sort" Text="Flat" ImageUrl="~/Designs/Outside/images/asc.png" runat="server" /></th>
                                    <th id="Th5" runat="server">Owner Name&nbsp;<asp:ImageButton ID="imOwner" CommandArgument="Name" CommandName="Sort" Text="Name" ImageUrl="~/Designs/Outside/images/asc.png" runat="server" /></th>
                                    <th id="Th7" runat="server">Invoice No</th>
                                    <th id="Th8" runat="server">Date</th>
                                    <th id="Th9" runat="server">Amount</th>
                                                                                                                                            
                                    <th id="Th11" runat="server">Status</th>
                                        <th id="Th12" class="text-center" runat="server">#</th>
                                </tr>
                                                                                                                                            
                                <tr runat="server" id="itemPlaceholder"></tr> 
                                                                                                                                              
                                                                                                                                     
                            </table> 
                                                                                                                         
            </LayoutTemplate>
         
        </asp:ListView>
</div>
                                                        
                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' >
                 
                </asp:SqlDataSource>
                                                      </div>
                     </div>   </div>
                </div>
</div>       


</asp:Content>


