<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeFile="Dashbord.aspx.cs" Inherits="Society_Property_Dashbord" %>

<%@ Register Src="~/Society/UserControl/GroupDiscussion.ascx" TagPrefix="uc1" TagName="GroupDiscussion" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://www.google.com/jsapi" type="text/javascript"></script>
    <script type="text/javascript">
        // Global variable to hold data
        google.load('visualization', '1', { packages: ['corechart'] });
    </script>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'Default.aspx/GetChartData',
                data: '{}',
                success:
                    function (response) {
                        drawchart(response.d);
                    },

                error: function () {
                    alert("Error loading data! Please try again.");
                }
            });
        })
        function drawchart(dataValues) {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Column Name');
            data.addColumn('number', 'Column Value');
            for (var i = 0; i < dataValues.length; i++) {
                data.addRow([dataValues[i].Value, dataValues[i].Amount]);
            }

            new google.visualization.PieChart(document.getElementById('chartdiv')).
                draw(data, { title: "Invoices Paid Unpaid Ratio Pie Chart" });
        }
      
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   <div class="row" data-widget-group="group-demo"> 
		 
            <div class="row">
                         <div class="col-md-3">
			                            <div class="info-tile info-tile-alt tile-success">   	
				                            <div class="tile-icon"><i class="ti ti-home"></i></div>
				                            <div class="tile-heading"><span>Properties</span></div>
				                            <div class="tile-body"><span>
                                                <asp:Label ID="lblTopProperties" runat="server" Text="0"></asp:Label></span></div>
				                            <div class="tile-footer"></div>
			                            </div>
		                          </div>
                         <div class="col-md-3">
			                     	<div class="info-tile info-tile-alt tile-brown">
				                            <div class="tile-icon"><i class="ti ti-user"></i></div>
				                            <div class="tile-heading"><span>Employees</span></div>
				                            <div class="tile-body"><span>  <asp:Label ID="lblTopEmployees" runat="server" Text="0"></asp:Label></span></div>
				                            <div class="tile-footer"></div>
			                            </div>
		                            </div>  
                              <div class="col-md-3">
			                        	<div class="info-tile info-tile-alt tile-warning">
				                            <div class="tile-icon"><i class="ti ti-gift"></i></div>
				                            <div class="tile-heading"><span>Requests</span></div>
				                            <div class="tile-body"><span>  <asp:Label ID="lblTopRequests" runat="server" Text="0"></asp:Label></span></div>
				                            <div class="tile-footer"></div>
			                            </div>
		                            </div> 
                             <div class="col-md-3">
			                           <div class="info-tile info-tile-alt tile-info">
				                            <div class="tile-icon"><i class="ti ti-view-list-alt"></i></div>
				                            <div class="tile-heading"><span>Classifieds</span></div>
				                            <div class="tile-body"><span>  <asp:Label ID="lblTopClassifieds" runat="server" Text="0"></asp:Label></span></div>
				                            <div class="tile-footer"></div>
			                            </div>
		                            </div>
       </div>
            <div class="row">
                    <div class="col-lg-9 ">
                             
                             
                                 <div class="row">  
                                     <div class="col-md-6"> 
    	                                               <div class="panel panel-info"  data-widget='{"id" : "wiget9", "draggable": "false"}'>
			                                                <div class="panel-heading">
				                                                <h2><i class="fa fa-bar-chart-o"></i>Invoice Paid/Unpaid </h2>
				                                                <div class="panel-ctrls button-icon" 
					                                                data-actions-container="" 
					                                                data-action-collapse='{"target": ".panel-body"}'
					                                                data-action-colorpicker=''>
				                                                </div>	
			                                                </div>
						                                      <div class="panel-body scroll-pane" style="height:200px;">	
                                                                <div class="row scroll-content  table-responsive">
                         <div id="chartdiv"></div>
                                                                    </div>
                                                                  </div> 
                                                           </div>
                                </div>
                                                  <div class="col-md-6"> 
    	                                               <div class="panel panel-info"  data-widget='{"id" : "wiget2", "draggable": "false"}'>
			                                                <div class="panel-heading">
				                                                <h2><i class="fa fa-users"></i>Latest Member </h2>
				                                                <div class="panel-ctrls button-icon" 
					                                                data-actions-container="" 
					                                                data-action-collapse='{"target": ".panel-body"}'
					                                                data-action-colorpicker=''>
				                                                </div>	
			                                                </div>
						                                      <div class="panel-body scroll-pane" style="height:175px;">	
                                                                <div class="row scroll-content">	
                                                       <div class="table-responsive">
                                                                    <asp:ListView ID="lstPropertyMember" runat="server"  OnItemCommand="lstPropertyMember_ItemCommand" >
                                                 
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
                                                       	<div class="col-sm-3 text-center">
			                                                  		       <asp:Image ID="imgPropertyMemberPic" runat="server" CssClass="img-circle fancybox"  Style="border:solid 1px #808080"  Height="70px" Width="70px"   ImageUrl='<%# "~/Society/Media/ProfilePhoto/" + Eval("varImage") %>' /> 
			                                                         <br />    <br />
                                                        <strong>      <asp:LinkButton Text='<%# Eval("varName") %>'  CommandArgument='<%# Eval("varPropertyId") %>' CommandName="View"   runat="server" ID="Type"  /></strong> 
                                                                        <br />
                                                                        <asp:Label Text='<%# Eval("varCreatedDate") %>' runat="server" ID="IsActive" />
			                                                    
                                                                    
                                                               </div>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                            <div ID="itemPlaceholderContainer" runat="server" >
                                                                <span runat="server" id="itemPlaceholder" />
                                                            </div>
                                                     </LayoutTemplate>                                                     
                                                 </asp:ListView>
                                                           </div>
                                                               
                                                                          </div>

						                                       </div> 
                                                          <asp:HyperLink  NavigateUrl="~/Society/Admin/Property/ViewPropertyList.aspx" runat="server" CssClass="btn btn-primary-alt btn-sm btn-block ">See all </asp:HyperLink>
                                                    
                                                             </div>
					                                    </div>  
                                           
                                                     
                                   </div>
                           <div class="row"> 
                                      <div class="col-md-12"> 
                                         <div class="panel panel-info"  data-widget='{"id" : "wiget1", "draggable": "false"}'>
			                                                <div class="panel-heading">
				                                                <h2><i class="fa fa-file-text"></i>Latest Invoices </h2>
				                                                <div class="panel-ctrls button-icon" 
					                                                data-actions-container="" 
					                                                data-action-collapse='{"target": ".panel-body"}'
					                                                data-action-colorpicker=''>
				                                                </div>	
			                                                </div>
						                                      <div class="panel-body scroll-pane" style="height:260px;">	
                                                                <div class="row scroll-content ">
                                                                    <div class="table-responsive">
                                                            <asp:ListView ID="lstInvoices" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="lstInvoices_ItemCommand">
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
                                            <td>
                                                <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                                            <td>
                                                <asp:Label Text='<%# Eval("InvoiceNo") %>' runat="server" ID="InvoiceNoLabel" /></td>
                                            <td>
                                                <asp:Label Text='<%# Eval("Date") %>' runat="server" ID="DateLabel" /></td>
                                            <td>
                                                <asp:Label Text='<%# Eval("Amount") %>' runat="server" ID="AmountLabel" /></td>
                                            <td>
                                                <asp:Label Text='<%# Eval("Outstanding") %>' runat="server" ID="OutstandingLabel" /></td>
                                            <td>
                                                <asp:Label Text='<%# Eval("[Payment Status]") %>' runat="server" CssClass='<%# Eval("[Payment Status]").ToString() == "Paid" ? "label label-success" : "label label-warning" %>'  ID="Payment_StatusLabel"/> </td>
                                                <td class="text-center"> <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId") %>' CommandName="view" ToolTip="View Full Invoice"  runat="server"  CssClass=" fa fa-eye fa-2x" style="color:#558b2f"/></td>
                                        </tr>
                                    </ItemTemplate>
                                    <LayoutTemplate>
             
                                                    <table runat="server" id="itemPlaceholderContainer" class="table table-bordered table-hover" border="0">
                                                        <tr id="Tr2" runat="server" style="">
                                                                <th id="Th2" runat="server">Sr. No.</th>
                                                            <th id="Th5" runat="server">Name</th>
                                                            <th id="Th7" runat="server">InvoiceNo</th>
                                                            <th id="Th8" runat="server">Date</th>
                                                            <th id="Th9" runat="server">Amount</th>
                                                            <th id="Th10" runat="server">Outstanding</th>
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
                                                                  </div>
                                             </div>
                                    </div>
                                </div>   
                        <div class="row">
                            <div class="col-md-6"> 
    	                                               <div class="panel panel-info"  data-widget='{"id" : "wiget4", "draggable": "false"}'>
			                                                <div class="panel-heading">
				                                                <h2><i class="fa fa-users"></i>Events and Announcements </h2>
				                                                <div class="panel-ctrls button-icon" 
					                                                data-actions-container="" 
					                                                data-action-collapse='{"target": ".panel-body"}'
					                                                data-action-colorpicker=''>
				                                                </div>	
			                                                </div>
						                                      <div class="panel-body scroll-pane" style="height:300px;">	
                                                                <div class="row scroll-content">
                                                                        <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole,  tbleventannouncement.intEventType, tbleventannouncement.varSubject, tbleventannouncement.varDescription,DATE_FORMAT(tbleventannouncement.varStartDate,'%d-%m-%Y') as varStartDate,  DATE_FORMAT(tbleventannouncement.varEndDate,'%d-%m-%Y') as varEndDate , tbleventannouncement.varStartTime, tbleventannouncement.varEndTime, tbleventannouncement.varLocation,  tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, tbleventannouncement.varContactName, tbleventannouncement.varMobile,  tbleventannouncement.varEmail, tbleventannouncement.varEventImage, tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy,  tbleventannouncement.intIsActive, countrymaster.CountryName, statemaster.StateName, citymaster.CityName, tblmastereventtype.varEventTypeName, CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name FROM tbleventannouncement INNER JOIN countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN tblproperty ON tbleventannouncement.varPersonalId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId  INNER JOIN tblmastereventtype ON tbleventannouncement.intEventType = tblmastereventtype.intId WHERE tbleventannouncement.intIsActive =1 and tbleventannouncement.varSocietyId='SKS1915361'  order by tbleventannouncement.intId desc"></asp:SqlDataSource>
         
                                                                    <asp:ListView ID="lstType" runat="server"  DataKeyNames="intId">
                                                                          <EmptyDataTemplate>
                                                                            <div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                                        <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                                        </div>
                                                                        </EmptyDataTemplate>
                                                                        <AlternatingItemTemplate>
                                                                              <div class="info-tile info-tile-alt tile-teal">
                                                                                 <table class="table tile-heading"> 
                                   <tr>
                                       <td> Organiser :</td><td> <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /> </td>
                                   </tr>
                                  
                                   <tr><td>Subject</td><td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="varSubjectLabel" /></td></tr>
                                   <tr><td>Description</td><td> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Label2" /></td></tr>
                                   <tr><td>Start Date</td><td>  <asp:Label Text='<%# Eval("varStartDate") %>' runat="server" ID="varStartDateLabel" /></td></tr>
                                        <tr><td>Location</td><td>  <asp:Label Text='<%# Eval("varLocation") %>' runat="server" ID="Label4" /></td></tr>              
                               </table></div>
                                                                            
                                                                        </AlternatingItemTemplate>
                                                                         
                                                                        <ItemTemplate>
                                                                           <div class="info-tile info-tile-alt tile-success">
                                                                                 <table class="table tile-heading">
                                   <tr><td> Organiser :</td><td> <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /> </td></tr>
            
                                   <tr><td>Subject</td><td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="varSubjectLabel" /></td></tr>
                                   <tr><td>Description</td><td> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Label2" /></td></tr>
                                   <tr><td>Start Date</td><td>  <asp:Label Text='<%# Eval("varStartDate") %>' runat="server" ID="varStartDateLabel" /></td></tr>
                                                           <tr><td>Location</td><td>  <asp:Label Text='<%# Eval("varLocation") %>' runat="server" ID="varEventTypeNameLabel" /></td></tr>        
                               </table>
                                                                           </div>

                                                                        </ItemTemplate>
                                                                        <LayoutTemplate>
                                                                             <span runat="server" id="itemPlaceholder" /> 
                                                                          
                                                                        </LayoutTemplate> 
                                                                    </asp:ListView>	
                                                                    </div>
                                                                  </div>
                                                           <br />
               <asp:HyperLink ID="HyperLink1"  NavigateUrl="~/Society/View/ViewEventEnnouncement.aspx" runat="server" CssClass="btn btn-primary-alt btn-sm btn-block ">See all </asp:HyperLink>
                           
                                                           </div>
                                </div>
                            <div class="col-md-6"> 
    	                                               <div class="panel panel-info"  data-widget='{"id" : "wiget3", "draggable": "false"}'>
			                                                <div class="panel-heading">
				                                                <h2><i class="fa fa-cubes"></i>Requests </h2>
				                                                <div class="panel-ctrls button-icon" 
					                                                data-actions-container="" 
					                                                data-action-collapse='{"target": ".panel-body"}'
					                                                data-action-colorpicker=''>
				                                                </div>	
			                                                </div>
						                                      <div class="panel-body scroll-pane" style="height:320px;">	
                                                                <div class="row scroll-content">	
                                                      <div class="table-responsive">
                                                                   <asp:ListView ID="lstRequests" runat="server">
                                                 
                                                                       <EmptyDataTemplate>
                                                                         <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                                             <tr >
                                                                               <td  >
                                                                 	                <div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                                <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Request Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                                </div>
                                                                               </td>
                                                                              </tr>
                                                                         </table>
                                                                     </EmptyDataTemplate>
                                                     
                                                                     <ItemTemplate>
                                                                         <tr style="">
                                                                         <%--      <td>  <asp:Label ID="lblSRNO" runat="server"  Text='<%#Container.DataItemIndex+1 %>'></asp:Label></td>--%>
                                                                                <td> <asp:Label Text='<%# Eval("Pname") %>' runat="server" ID="Label2" /></td>
                                                                               <td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="Type" /></td>
                                                                             <td>    <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                                                  <td>   <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="varStartDate"  CssClass='<%# Eval("varStatus").ToString() == "Approved" ? "label label-success" :Eval("varStatus").ToString()=="Rejected"? "label label-danger":"label label-warning" %>' /></td>
                                                                                     </tr>
                                                                     </ItemTemplate>
                                                                     <LayoutTemplate>
                                                       
                                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                                         <tr id="Tr1" runat="server" class="danger">                                                                            
                                                                                           <%--  <th id="Th2" runat="server">SrNo</th>--%>
                                                                                             <th id="Th3" runat="server">From</th>
                                                                                               <th id="Th1" runat="server">Request</th>
                                                                                             <th id="Th4" runat="server">Details</th>
                                                                                                <th id="Th6" runat="server">Status</th>                                                                        
                                                                                         </tr>
                                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                                     </table>
                                                                     </LayoutTemplate>
                                                     
                                                                 </asp:ListView>
                                                    	                  </div>
                                                                    </div>
                                                                  </div> <asp:HyperLink ID="HyperLink2"  NavigateUrl="~/Society/Admin/Property/Approvals.aspx" runat="server" CssClass="btn btn-primary-alt btn-sm btn-block ">See all </asp:HyperLink>
               
					                                    </div>
                                                      </div>
                        </div>
                        <div class="row">
                               <div class="col-md-12 ">
                              <uc1:GroupDiscussion runat="server" ID="GroupDiscussion" pagesize="5" />
                                   </div>
                        </div>
                          </div>
                
                    <div class="col-lg-3"> 
                          <div class="row">                                                  
    	                                            <div class="panel panel-info"  data-widget='{"id" : "wiget10", "draggable": "false"}'>
			                                                            <div class="panel-heading">
				                                                            <h2><i class="ti  ti-pencil"></i>Complaints </h2>
				                                                            <div class="panel-ctrls button-icon" 
					                                                            data-actions-container="" 
					                                                            data-action-collapse='{"target": ".panel-body"}'
					                                                            data-action-colorpicker=''>
				                                                            </div>	
			                                                            </div>
						                                                  <div class="panel-body scroll-pane" style="height:200px;">	
                                                                                <div class="row scroll-content marquee">	
                                                     
                                                                             <asp:ListView ID="lstcomplaints" runat="server" OnItemCommand="lstcomplaints_ItemCommand" >
                                                 
                                                                                   <EmptyDataTemplate>
                                                                                     <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                                                         <tr >
                                                                                           <td  >
                                                                 	                            <div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                                            <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Complaints Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                                            </div>
                                                                                           </td>
                                                                                          </tr>
                                                                                     </table>
                                                                                 </EmptyDataTemplate>
                                                     
                                                                                 <ItemTemplate>
                                                                                     
                                                                                 <table class="table">
                                                                                     <tr><td> <asp:LinkButton Text='<%# Eval("varSubject") %>'  CommandArgument='<%# Eval("intId") %>' CommandName="View" runat="server" ID="NameLabel" Font-Bold="true" Font-Size="Medium" ForeColor="Teal" /> </td></tr>
                                                                                              <tr>  <td> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td></tr>
                                                                                               <tr><td> <asp:Label Text='<%# Eval("Name") %>' CssClass="label label-success" runat="server" ID="Label3" /><br /></td></tr>
                                                                                     </table>
                                                                                       <br /> 
                                                                                 </ItemTemplate>
                                                                                 <LayoutTemplate>
                                                        <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                                                                                               
                                                                                                   
                                                                                                 </table>
                                                                                 </LayoutTemplate>
                                                     
                                                                             </asp:ListView>
                                                    	                                 </div>
                                                                              </div> <asp:HyperLink  NavigateUrl="~/Society/View/ViewComplaints.aspx" runat="server"  CssClass="btn btn-primary-alt btn-sm btn-block ">See all </asp:HyperLink>
                        
					                                                </div>
                                                    </div> 
                        <div class="row">
    	                    <div class="panel panel-info"  data-widget='{"id" : "wiget5", "draggable": "false"}'>
						                    <div class="panel-heading">
							                    <h2><i class=" ti ti-gallery"></i>Image Gallary </h2>
                                                <div class="panel-ctrls button-icon" 
					                                data-actions-container="" 
					                                data-action-collapse='{"target": ".panel-body"}'
					                                data-action-colorpicker=''>
				                                </div>	
						                    </div>
           
						                    <div class="panel-body">	
                                                <div class="row ">					
                                                    <asp:ListView ID="LstGallary" runat="server" DataSourceID="sqlGallery"> 
                                                       <EmptyDataTemplate>
                                                                             <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                                                 <tr >
                                                                                   <td  >
                                                                 	                    <div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                                    <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Gallary Images Found...!!!&nbsp;
						                                              	                    
					                                                                    </div>
                                                                                   </td>
                                                                                  </tr>
                                                                             </table>
                                                                         </EmptyDataTemplate>
                                                        <ItemTemplate>
                                                            <div runat="server" style=""> 
                                                                <div  class="col-md-4 ">
									                    <asp:Image ID="imgSimilarPic" runat="server" CssClass="img-responsive fancybox"   Height="70px" Width="80px"   ImageUrl='<%# "~/Society/Media/Gallary/" + Eval("varGallaryImage") %>' />  <br />
								                    </div>
                                            
                                                            </div>


                                                        </ItemTemplate>
                                                        <LayoutTemplate>
                                      
                                                                <div runat="server" id="itemPlaceholderContainer">
                                                                    <div runat="server" id="itemPlaceholder"></div>
                                                                </div>
                                    
                                                            <div style="">
                                                            </div>
                                                        </LayoutTemplate>
                                     
                                                    </asp:ListView>
                            <asp:SqlDataSource ID="sqlGallery" runat="server"  
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  >       
 
                            </asp:SqlDataSource> 
							                    </div>
							
						                    </div>
					                    </div>
                        </div>

                        <div class="row"> 
    	                <div class="panel panel-info"  data-widget='{"id" : "wiget6", "draggable": "false"}'>
			<div class="panel-heading">
				<h2><i class="ti ti-pin-alt"></i>Notice Board </h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''>
				</div>	
			</div>
						                    <div class="panel-body scroll-pane" style="height:200px;">	
                                                <div class="row scroll-content marquee">					
                                                    <asp:ListView ID="lstNoticeboard" runat="server"  >
                                                        <EmptyDataTemplate>
                                                                             <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                                                 <tr >
                                                                                   <td  >
                                                                 	                    <div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                                    <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..!!&nbsp;
						                                              	                    
					                                                                    </div>
                                                                                   </td>
                                                                                  </tr>
                                                                             </table>
                                                                         </EmptyDataTemplate>
                                                        <ItemTemplate>
                                                            <span style="">
                                                                    
                                                             <asp:Label Text='<%# Eval("varSubject") %>' CssClass="text-success" runat="server" ID="varSubjectLabel" /><br />
                                          
                                                                <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="varDescriptionLabel" /><br />
                                                                <asp:Label Text='<%# Eval("Name") %>' CssClass="label label-success" runat="server" ID="Label3" /><br />
                                                             <%--    <asp:Label Text='<%# Eval("varCreatedDate") %>' runat="server" ID="Label2" /><br />--%><br />
                                                            </span>

                                                        </ItemTemplate>
                                                        <LayoutTemplate>

                                                            <div runat="server" id="itemPlaceholderContainer" style="">
                                                                <span runat="server" id="itemPlaceholder"  />
                                                            </div>

                                                            <div style="">
                                                            </div>
                                                        </LayoutTemplate>
                                   
                                                    </asp:ListView>
                              
                                                   
							                    </div>
							
						                    </div>
					                    </div>
                        </div>

                        <div class="row">                                                  
    	                                            <div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			                                                            <div class="panel-heading">
				                                                            <h2><i class="ti  ti-comments-smiley"></i>Classifieds </h2>
				                                                            <div class="panel-ctrls button-icon" 
					                                                            data-actions-container="" 
					                                                            data-action-collapse='{"target": ".panel-body"}'
					                                                            data-action-colorpicker=''>
				                                                            </div>	
			                                                            </div>
						                                                  <div class="panel-body scroll-pane" style="height:250px;">	
                                                                            <div class="row scroll-content marquee">	
                                                     
                                                                             <asp:ListView ID="lstTypeClassified" runat="server" OnItemCommand="lstTypeClassified_ItemCommand" >
                                                 
                                                                                   <EmptyDataTemplate>
                                                                                     <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                                                         <tr >
                                                                                           <td  >
                                                                 	                            <div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                                            <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Classified Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                                            </div>
                                                                                           </td>
                                                                                          </tr>
                                                                                     </table>
                                                                                 </EmptyDataTemplate>
                                                     
                                                                                 <ItemTemplate>
                                                                                     
                                                                                 <table class="table">
                                   <tr><td> <asp:LinkButton Text='<%# Eval("varSubject") %>'  CommandArgument='<%# Eval("intId") %>' CommandName="View" runat="server" ID="NameLabel" Font-Bold="true" Font-Size="Medium" ForeColor="Teal" /> </td></tr>
                                                                                              <tr>  <td> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td></tr>
                                                                                               
                                                                                     </table>
                                                                                       <br /> 
                                                                                 </ItemTemplate>
                                                                                 <LayoutTemplate>
                                                        <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                                                                                               
                                                                                                   
                                                                                                 </table>
                                                                                 </LayoutTemplate>
                                                     
                                                                             </asp:ListView>
                                                    	                                 </div>
                                                                              </div> <asp:HyperLink  NavigateUrl="~/Society/View/ViewClassified.aspx" runat="server"  CssClass="btn btn-primary-alt btn-sm btn-block ">See all </asp:HyperLink>
                        
					                                                </div>
                                                    </div>

                        <div class="row"> 
    	                <div class="panel panel-info"  data-widget='{"id" : "wiget8", "draggable": "false"}'>
			<div class="panel-heading">
				<h2><i class="ti   ti-check-box"></i>Poll </h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''>
				</div>	
			</div>
						                    <div class="panel-body scroll-pane" style="height:250px;">	
                                                <div class="row scroll-content">					
                                                    <asp:ListView ID="lstPoll" runat="server"  >
                                                        <EmptyDataTemplate>
                                                                <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                                    <tr >
                                                                    <td  >
                                                                 	    <div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                    <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No New Polls Found..!!!
						                                              	                    
					                                                    </div>
                                                                    </td>
                                                                    </tr>
                                                                </table>
                                                          </EmptyDataTemplate>
                                                        <ItemTemplate>
                                                            <span style="">
                                                             <asp:Label Text='<%# Eval("varQuestion") %>' CssClass="text-success" runat="server" ID="varSubjectLabel" /><br />
                                                             <asp:Label Text='<%# Eval("intId") %>' CssClass="text-success" runat="server" ID="idPoll"  Visible="false"/><br />
                                                              <asp:RadioButton Text='<%# Eval("varOption1") %>' runat="server" ID="op1"  GroupName="poll"/> <br />
                                                                  <asp:RadioButton Text='<%# Eval("varOption2") %>' runat="server" ID="op2"  GroupName="poll"/> <br />
                                                                  <asp:RadioButton Text='<%# Eval("varOption3") %>' runat="server" ID="op3"  GroupName="poll"/> <br />
                                                                  <asp:RadioButton Text='<%# Eval("varOption4") %>' runat="server" ID="op4"  GroupName="poll"/> <br />
                                                                 </span>
                                                            <asp:Button ID="btnPollAnswer" OnClick="btnPollAnswer_Click" CssClass="btn btn-primary" runat="server" Text="Submit Answer" />
                                                        </ItemTemplate>
                                                        <LayoutTemplate>

                                                            <div runat="server" id="itemPlaceholderContainer" style="">
                                                                <span runat="server" id="itemPlaceholder"  />
                                                            </div>

                                                            <div style="">
                                                            </div>
                                                        </LayoutTemplate>
                                   
                                                    </asp:ListView>
                                                    
                                                  
							                    </div>
							
						                    </div>
					                    </div>
                        </div>
                      
                        
                    </div>

              
		</div>
</div>
</asp:Content>




