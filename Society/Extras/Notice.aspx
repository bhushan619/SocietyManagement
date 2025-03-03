﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="Notice.aspx.cs" Inherits="Society_Extras_Notice" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        
<link type="text/css" href="../../Designs/plugins/form-daterangepicker/daterangepicker-bs3.css" rel="stylesheet">    <!-- DateRangePicker -->
<link type="text/css" href="../../Designs/plugins/iCheck/skins/minimal/blue.css" rel="stylesheet">                   <!-- Custom Checkboxes / iCheck -->
<link type="text/css" href="../../Designs/plugins/clockface/css/clockface.css" rel="stylesheet">  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
		<div class="col-md-4 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>  Notice Information</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
                      
                         <%--  <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Notice Type</label>
									<div class="col-sm-8">
										  <asp:DropDownList ID="ddlNoticeType" runat="server" CssClass="form-control" required="required">
                                                  <asp:ListItem>:: Select Notice Type ::</asp:ListItem>                                                   
                                                </asp:DropDownList></div>									
								</div>--%>
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Value Date</label>
									<div class="col-sm-8">
											<div class="input-group">
														<span class="input-group-addon">
															<i class="fa fa-calendar"></i>
														</span>
                                                        <asp:TextBox ID="txtDOB" runat="server"  CssClass="form-control"></asp:TextBox>	
                                             </div>
									</div>									
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Title</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtTitle" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control"  required="required"></asp:TextBox>
									</div>
									
								</div>
                     
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Description</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtDescription" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
									</div>
								</div>
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Assign To</label>
									<div class="col-sm-8">
									 <asp:DropDownList ID="ddlAssignTo" runat="server" CssClass="form-control" required="required" OnSelectedIndexChanged="ddlAssignTo_SelectedIndexChanged" AutoPostBack="true">
                                                  <asp:ListItem Value="">:: Assign To ::</asp:ListItem>  
                                                <asp:ListItem Value="1">Employee</asp:ListItem>    
                                                <asp:ListItem Value="2">Property</asp:ListItem>                                                     
                                                </asp:DropDownList>
									</div>									
								</div>
                         <div class="form-group" runat="server" id="wing" visible="false">
									<label for="focusedinput" class="col-sm-3   control-label">Wing</label>
									<div class="col-sm-8">
										<asp:DropDownList ID="ddlWing"  runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlWing_SelectedIndexChanged"  required="required">
                               <asp:ListItem>:: Select  Wing ::</asp:ListItem>                                                      
                           </asp:DropDownList>
									</div>									
								</div>   
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Report To</label>
									<div class="col-sm-8">
									<select id="ddlReportto" disabled="disabled" placeholder= ":: Report To ::"  multiple="true" style="width:100% !important"   runat="server"   >
                                       
                                         </select> 
									</div>									
								</div>
                                <div class="form-group">
									<div class="col-sm-3  "></div>
									<div class="col-sm-8">
									    <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" Visible="false"  OnClick="btnUpdate_Click"/>
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="Notice.aspx" >Reset</a>
									</div>
								</div>

                     
                          <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
					
					</div>
					
				</div>
				
			</div>
		</div>
        <div class="col-md-8 ">
			<div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body no-padding  table-responsive">
                                                     
                                                 <asp:ListView ID="lstType" runat="server" OnPagePropertiesChanging="OnPagePropertiesChanging" OnItemCommand="lstType_ItemCommand" >
                                                 
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
                                                         <tr style="">
                                                            
                                                              <td>  <asp:Label ID="lblSRNO" runat="server"  Text='<%#Container.DataItemIndex+1 %>'></asp:Label></td>
                                                             <td> <asp:Label Text='<%# Eval("varNoticeTitle") %>' runat="server" ID="Type" /></td>
                                                             <td> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                            
                                                              <td> <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="IsActive" /></td>
                                                                    
                                                           <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                               <td><asp:LinkButton  ID="lnkdelet" CommandArgument='<%# Eval("intId") %>' CommandName="Delets"  runat="server"  CssClass=" fa fa-times"/></td>
                                                            
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Notice Title</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                            
                                                                                 <th id="Th6" runat="server">Name</th>
                                                                              <th id="Th1" runat="server"  colspan="2">Operation</th>
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstType" PageSize="10">
                                                          <Fields  >
                                                           <asp:NextPreviousPagerField ButtonType="Link" ButtonCssClass="btn btn-primary btn-xs" ShowFirstPageButton="True" ShowPreviousPageButton="False"   FirstPageText="< First "      ShowNextPageButton="false" />
                                                              <asp:NumericPagerField ButtonType="Link"  />
                                                             <asp:NextPreviousPagerField ButtonType="Link" ButtonCssClass="btn btn-primary btn-xs" ShowNextPageButton="False" ShowLastPageButton="True" ShowPreviousPageButton = "false"  LastPageText=" Last >"/>
                                                      </Fields>
                                                          </asp:DataPager>
                                                     </div>
                 </div>
                </div>
            </div>
	</div>
      <!-- Load page level scripts-->
    
<script type="text/javascript" src="../../Designs/plugins/form-daterangepicker/moment.min.js"></script>              			<!-- Moment.js for Date Range Picker -->

<script type="text/javascript" src="../../Designs/plugins/form-colorpicker/js/bootstrap-colorpicker.min.js"></script> 			<!-- Color Picker -->

<script type="text/javascript" src="../../Designs/plugins/form-daterangepicker/daterangepicker.js"></script>     				<!-- Date Range Picker -->
<script type="text/javascript" src="../../Designs/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>      			<!-- Datepicker -->
<script type="text/javascript" src="../../Designs/plugins/bootstrap-timepicker/bootstrap-timepicker.js"></script>      			<!-- Timepicker -->
<script type="text/javascript" src="../../Designs/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script> <!-- DateTime Picker -->

<script type="text/javascript" src="../../Designs/plugins/clockface/js/clockface.js"></script>     								<!-- Clockface -->


<script type="text/javascript" src="../../Designs/demo/demo-pickers.js"></script>

    <!-- End loading page level scripts-->
</asp:Content>

