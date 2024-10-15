<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="ViewEventEnnouncement.aspx.cs" Inherits="Society_View_ViewEventEnnouncement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="row">
        <div class="col-lg-12 ">
			<div class="panel panel-info"  data-widget='{"id" : "wiget1", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View Event & Ennouncement</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body no-padding  table-responsive">
                                                     
                                                 <asp:ListView ID="lstType" runat="server" OnItemCommand="lstType_ItemCommand" OnPagePropertiesChanging="OnPagePropertiesChanging"  >
                                                 
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
                                                              <td>
                                                                 <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="Label1" /></td>
                                                           
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="Type" /></td>
                                                             <td>         <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                                  <td>         <asp:Label Text='<%# Eval("varStartDate") %>' runat="server" ID="varStartDate" /></td>
                                                          
                                                              <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Views"  runat="server"  ToolTip="View Full Details" CssClass=" fa fa-2x fa-eye"/></td>
                                                            
                                                                                 
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                               <th id="Th1" runat="server">Name</th>
                                                                             <th id="Th3" runat="server">Title</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                                 <th id="Th6" runat="server">Date</th>
                                                                             <th id="Th5" runat="server">View</th>
                                                                       
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
           <%--<div class="col-md-5" id="replydiv" runat="server" visible="false">
			<div class="panel panel-info"  data-widget='{"id" : "wiget2", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View Full Details</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body   table-responsive">
                                                     
                    <asp:ListView ID="lstreply" runat="server" DataKeyNames="intId" >
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
                            <span class="table-responsive">     
                               <table class="table">
                                   <tr>
                                       <td> Organiser :</td><td> <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /> </td>
                                   </tr>
                                   <tr><td>Event </td><td>  <asp:Label Text='<%# Eval("varEventTypeName") %>' runat="server" ID="varEventTypeNameLabel" /></td></tr>
                                   <tr><td>Subject</td><td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="varSubjectLabel" /></td></tr>
                                   <tr><td>Description</td><td> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Label2" /></td></tr>
                                   <tr><td>Start Date</td><td>  <asp:Label Text='<%# Eval("varStartDate") %>' runat="server" ID="varStartDateLabel" /></td></tr>
                                   <tr><td>Start Time</td><td> <asp:Label Text='<%# Eval("varStartTime") %>' runat="server" ID="varStartTimeLabel" /></td></tr>
                                   <tr><td>End Date</td><td>   <asp:Label Text='<%# Eval("varEndDate") %>' runat="server" ID="varEndDateLabel" /></td></tr>
                                   <tr><td>End Time</td><td> <asp:Label Text='<%# Eval("varEndTime") %>' runat="server" ID="varEndTimeLabel" /></td></tr>
                                   <tr><td> Country</td><td> <asp:Label Text='<%# Eval("CountryName") %>' runat="server" ID="CountryNameLabel" /></td></tr>
                                      <tr><td>State</td><td> <asp:Label Text='<%# Eval("StateName") %>' runat="server" ID="StateNameLabel" /></td></tr>
                                     <tr><td>City</td><td> <asp:Label Text='<%# Eval("CityName") %>' runat="server" ID="CityNameLabel" /></td></tr>
                                     <tr><td>Pincode</td><td>  <asp:Label Text='<%# Eval("varPin") %>' runat="server" ID="varPinLabel" /></td></tr>
                                   <tr><td>Location</td><td> <asp:Label Text='<%# Eval("varLocation") %>' runat="server" ID="varLocationLabel" /></td></tr>
                                   <tr><td>Event Capacity</td><td><asp:Label Text='<%# Eval("varEventCapacity") %>' runat="server" ID="varEventCapacityLabel" /></td></tr>
                                   <tr><td>Contact Person</td><td> <asp:Label Text='<%# Eval("varContactName") %>' runat="server" ID="varContactNameLabel" /></td></tr>
                                   <tr><td>Mobile No.</td><td> <asp:Label Text='<%# Eval("varMobile") %>' runat="server" ID="varMobileLabel" /></td></tr>
                                   <tr><td>Email-ID</td><td>  <asp:Label Text='<%# Eval("varEmail") %>' runat="server" ID="varEmailLabel" /></td></tr>
                                   <tr><td>Image</td><td> <asp:Image ID="imgSimilarPic" runat="server" CssClass="fancybox" Height="50px" Width="50px"   ImageUrl='<%# "~/Society/Media/Event/" + Eval("varEventImage") %>' /></td></tr>
                                   <tr><td></td><td></td></tr>
                               </table>
                            
                              
                            </span>

                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                            <div style="">
                            </div>

                        </LayoutTemplate>
                         
                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' SelectCommand="SELECT tbleventannouncement.intId, tbleventannouncement.varSocietyId, tbleventannouncement.varPersonalId, tbleventannouncement.intRole,  tbleventannouncement.intEventType, tbleventannouncement.varSubject, tbleventannouncement.varDescription,DATE_FORMAT(tbleventannouncement.varStartDate,'%d-%m-%Y') as varStartDate,  DATE_FORMAT(tbleventannouncement.varEndDate,'%d-%m-%Y') as varEndDate , tbleventannouncement.varStartTime, tbleventannouncement.varEndTime, tbleventannouncement.varLocation,  tbleventannouncement.varEventCapacity, tbleventannouncement.varPin, tbleventannouncement.varContactName, tbleventannouncement.varMobile,  tbleventannouncement.varEmail, tbleventannouncement.varEventImage, tbleventannouncement.varCreatedDate, tbleventannouncement.varCreatedBy,  tbleventannouncement.intIsActive, countrymaster.CountryName, statemaster.StateName, citymaster.CityName, tblmastereventtype.varEventTypeName, CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name FROM tbleventannouncement INNER JOIN countrymaster ON tbleventannouncement.intCountry = countrymaster.CountryId INNER JOIN statemaster ON tbleventannouncement.intState = statemaster.StateId INNER JOIN citymaster ON tbleventannouncement.intCity = citymaster.CityId INNER JOIN tblproperty ON tbleventannouncement.varPersonalId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId  INNER JOIN tblmastereventtype ON tbleventannouncement.intEventType = tblmastereventtype.intId WHERE tbleventannouncement.intIsActive =1 and tbleventannouncement.varSocietyId='SKS1915361'  order by tbleventannouncement.intId desc"></asp:SqlDataSource>
                </div>
                
                </div>
            </div>--%>
    </div>
</asp:Content>


