<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="VisitorReport.aspx.cs" Inherits="Society_Reports_VisitorReport" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"><script type="text/javascript">
                        $(function () {
                            var tabName = $("[id*=ContentPlaceHolder1_TabName]").val() != "" ? $("[id*=ContentPlaceHolder1_TabName]").val() : "Flat";
                            $('#InOutManager a[href="#' + tabName + '"]').tab('show');
                            $("#InOutManager a").click(function () {
                                $("[id*=ContentPlaceHolder1_TabName]").val($(this).attr("href").replace("#", ""));
                            });
                        });

                       
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row">
    <div class="col-md-12">
    <asp:HiddenField ID="TabName" runat="server" />
     
                    
    <section class="content">
        <div id="InOutManager" role="tabpanel">
         <ul class="nav nav-tabs" role="tablist">
       <li class="active"><a aria-controls="Visitors" href="#Visitors" role="tab" data-toggle="tab">Visitors &nbsp;<i class="ti ti-dropbox-alt" style="color:#558b2f;"></i></a></li>
        <li><a href="#Property" aria-controls="Property" role="tab" data-toggle="tab">Property &nbsp;<i class="fa fa-home"  style="color:#ba68c8;"></i></a></li>  
             <li><a href="#Employee" aria-controls="Employee" role="tab" data-toggle="tab">Employee &nbsp;<i class="fa fa-user"  style="color:#0026ff;"></i></a></li>  
	</ul></div>   <br />
        <div class="tab-content">
            <div class="tab-pane active"  role="tabpanel"  id="Visitors">
            
           <div class="row">
            <div class="col-lg-12">  
                    <div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2><i class="ti  ti-comments-smiley"></i>Visitors List </h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''>
				</div>	
			</div>
						                    <div class="panel-body" >
                        <div class="row">   
                          
                               
                                         <div class="col-lg-3 col-sm-3">
                           <div class="form-group">
                              
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                               <asp:TextBox ID="txtStartDate" placeholder="From Date" runat="server" required CssClass="form-control"></asp:TextBox>
                                   
                             </div>   </div>
                                 <div class="col-lg-3 col-sm-3">
                               <div class="form-group">
                              
                            <asp:TextBox ID="txtEndDate" placeholder="To Date"  runat="server" required CssClass="form-control"></asp:TextBox>
                                
                            </div>   </div>
                                <div class="col-lg-3 col-sm-3">
                                   
                            <div class="form-group">
                                <asp:Button ID="btnview" runat="server" Text="Search"  OnClick="btnview_Click" CssClass="btn btn-primary"/>
                               
                            </div></div>
                        
                          </div>
                          <div class="row">                            	
                   <div class=" table-responsive" >
                       <asp:ListView ID="lstVisitors" runat="server" DataKeyNames="intId" >
                         
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
                                       <asp:Label Text='<%# Container.DataItemIndex+1 %>' runat="server" ID="intIdLabel" /></td>
                                   <td>
                                       <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                                   <td>
                                       <asp:Label Text='<%# Eval("ContactNumber") %>' runat="server" ID="ContactNumberLabel" /></td>
                                   <td>
                                       <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel" /></td>
                                   <td>
                                       <asp:Label Text='<%# Eval("VehicleNo") %>' runat="server" ID="VehicleNoLabel" /></td>
                                      <td>
                                       <asp:Label Text='<%# Eval("InTime") %>' runat="server" ID="InTimeLabel" /></td>
                                   <td>
                                       <asp:Label Text='<%# Eval("OutTime") %>' runat="server" ID="OutTimeLabel" /></td>
                                   <td>
                                       <asp:Label Text='<%# Eval("PurposeOFVisit") %>' runat="server" ID="PurposeOFVisitLabel" /></td>
                                   <%--   <td> <asp:LinkButton  ID="LinkButton1" CommandArgument='<%# Eval("intId") %>' CommandName="inout"  runat="server" Enabled='<%# Eval("OutTime").ToString().Contains("00:00:00") ? true : false   %>'  CssClass='<%# Eval("OutTime").ToString().Contains("00:00:00") ? "fa fa-sign-out text-success" : "fa fa-exclamation-circle text-danger"%>'  /></td>--%>
         
                                        </tr>
                           </ItemTemplate>
                           <LayoutTemplate> 
                                           <table runat="server" id="itemPlaceholderContainer" class="table table-bordered table-hover" style="" border="0">

                                               <tr runat="server" style=""> 
                                                    <th id="Th4" runat="server">Sr. No.</th>
                                                   <th runat="server">Name</th>
                                                   <th runat="server">Contact Number</th>
                                                   <th runat="server">Email</th>
                                                   <th runat="server">Vehicle No</th> 
                                                   <th runat="server">In Time</th>
                                                   <th runat="server">Out Time</th>
                                                   <th runat="server">Purpose</th> 
                                                      
                                               </tr>
                                               <tr runat="server" id="itemPlaceholder"></tr>
                                           </table> 
                           </LayoutTemplate>
                            
                       </asp:ListView>
                
                       <asp:SqlDataSource ID="SqlDataSourceOut" runat="server"
                           ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                           ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
                           >

                         
                      </asp:SqlDataSource>
                  </div>
                              </div>
                 </div>
                        </div>
                </div> 
            </div>  
            </div>  
              <div class="tab-pane "  role="tabpanel"  id="Property"> 
                     <div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2><i class="ti  ti-comments-smiley"></i>Property/Flat Owners IN/OUT</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''>
				</div>	
			</div>
						                    <div class="panel-body" >	
  <asp:ListView ID="lstProperty" runat="server" DataSourceID="SqlDataSource1" >

       
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
                  <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
              <td>
                  <asp:Label Text='<%# Eval("Mobile") %>' runat="server" ID="MobileLabel" /></td>
              <td>
                  <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel" /></td>
              <td>
                  <asp:Label Text='<%# Eval("Phone") %>' runat="server" ID="PhoneLabel" /></td>
<td>
             <asp:Label Text='<%# Convert.ToBoolean(Eval("varStatus")) == true ? "IN": "OUT" %>' CssClass='<%# Convert.ToBoolean(Eval("varStatus")) ? "label label-success" : "label label-danger" %>' runat="server" ID="varStatusCheckBox" Enabled="false" /></td>
                     <td class="text-center"> 
                    <%--  <asp:LinkButton  ID="LinkButton1" CommandArgument='<%# Eval("varStatus") + ":" +  Eval("varPersonnelId")%>' CommandName="inout"  runat="server"   CssClass='<%# Convert.ToBoolean(Eval("varStatus")) ? "fa fa-sign-out" : "fa fa-sign-in" %>' style="color:#ff6a00"/></td>--%>
              
          </tr>
      </ItemTemplate>
      <LayoutTemplate>

              <table runat="server" id="itemPlaceholderContainer" class="table table-bordered" border="0">
                          <tr runat="server" style="">
                              <th runat="server">Name</th>
                               <th runat="server">Mobile</th>
                              <th runat="server">Email</th>
                              <th runat="server">Phone</th>
                              <th runat="server">Status</th>
                           
                          </tr>
                          <tr runat="server" id="itemPlaceholder"></tr>
                      </table> 

      </LayoutTemplate>

      
  </asp:ListView>

                                                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>'
                                                    >
                                                    
                                                </asp:SqlDataSource>
                                                </div>
                         </div>
                             </div>
              <div class="tab-pane "  role="tabpanel"  id="Employee"> 
                     <div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2><i class="ti  ti-comments-smiley"></i>Employee IN/OUT </h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''>
				</div>	
			</div>
						                    <div class="panel-body" >	
                         <asp:ListView ID="lstEmployee" runat="server" DataSourceID="SqlDataSourceemp" >

                              
                              
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
                                         <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>

                                     <td>
                                         <asp:Label Text='<%# Eval("Mobile") %>' runat="server" ID="MobileLabel" /></td>
                                     <td>
                                         <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel" /></td>
                                     <td> <asp:Label Text='<%# Convert.ToBoolean(Eval("varStatus")) == true ? "IN": "OUT" %>' CssClass='<%# Convert.ToBoolean(Eval("varStatus")) ? "label label-success" : "label label-danger" %>' runat="server" ID="varStatusCheckBox" Enabled="false" /></td>
                     <td class="text-center"> 
                      <%--<asp:LinkButton  ID="LinkButton1" CommandArgument='<%# Eval("varStatus") + ":" +  Eval("varPersonnelId")%>' CommandName="inout"  runat="server"   CssClass='<%# Convert.ToBoolean(Eval("varStatus")) ? "fa fa-sign-out" : "fa fa-sign-in" %>' style="color:#ff6a00"/></td>--%>
                                 </tr>
                             </ItemTemplate>
                             <LayoutTemplate>

                                
                                             <table runat="server" id="itemPlaceholderContainer" class="table table-bordered" style="" border="0">
                                                 <tr runat="server" style="">
                                                   
                                                     <th runat="server">Name</th>
                                                     <th runat="server">Mobile</th>
                                                     <th runat="server">Email</th>
                                                      <th runat="server">Status</th>
                                                      
                                                 </tr>
                                                 <tr runat="server" id="itemPlaceholder"></tr>
                                             </table>
                                         </td>

                                     </tr>
                                     <tr runat="server">
                                         <td runat="server" style=""></td>
                                     </tr>
                                 </table>


                             </LayoutTemplate>

                              
                         </asp:ListView>

                                                <asp:SqlDataSource runat="server" ID="SqlDataSourceemp" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>'>
                                                  
                                                   
                                                </asp:SqlDataSource>
</div>
                         </div>
                             </div>
            </div> 
         
        </section> 
        </div>
    </div>
</asp:Content>

