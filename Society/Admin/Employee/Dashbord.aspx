<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/masterpage.master" AutoEventWireup="true" CodeFile="Dashbord.aspx.cs" Inherits="Society_Admin_Employee_Dashbord" %>

<%@ Register Src="~/Society/UserControl/GroupDiscussion.ascx" TagPrefix="uc1" TagName="GroupDiscussion" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   <div class="row">
		<div class="col-lg-12 ">
                    <div class="col-lg-9 ">
                        <div class="panel panel-info"  data-widget='{"id" : "wiget4", "draggable": "false"}'>
			                                              
						                                      <div class="panel-body">
							<div class="about-area">
						      	<h4><i class=" ti ti-tablet"></i>&nbsp; Basic Information
                                  	<asp:HyperLink ID="my" runat="server" NavigateUrl="~/Society/Common/MyProfile.aspx" style="float:right"><i class="fa fa-edit"></i></asp:HyperLink>
							</h4>	    <div class="table-responsive">
								      <table class="table">
								        <tbody>
								        
								       
								        <%--  <tr>
								            <th>Phone Number</th>
								            <td>
                                                <asp:Label ID="lblpphone" runat="server" Text=""></asp:Label></td>
								          </tr>--%>
								          <tr>
								            <th>Mobile Number</th>
								            <td>
                                                <asp:Label ID="lblpPrimaryMobile" runat="server" Text=""></asp:Label></td>
								          </tr>
                                                <tr>
								            <th>Other Mobile</th>
								            <td>
                                                <asp:Label ID="lblpOtherMobile" runat="server" Text=""></asp:Label></td>
								          </tr>
								           <tr>
								            <th>Primary Email-ID</th>
								            <td>
                                                <asp:Label ID="lblpPrimaryEmail" runat="server" Text=""></asp:Label></td>
								          </tr>
                                               <tr>
								            <th>Other Email-IDs</th>
								            <td>
                                                <asp:Label ID="lblpOtheremail" runat="server" Text=""></asp:Label></td>
								          </tr>
								          <tr>
								            <th>Social Link</th>
								            <td>
								            	<ul class="list-inline m-n">								            	
								            		<li><asp:HyperLink runat="server" ID="hptwitter" Target="_blank" ><i class="ti ti-twitter"></i></asp:HyperLink></li>
								            		<li><asp:HyperLink runat="server" ID="hpgoogle" Target="_blank"><i class="ti ti-google"></i></asp:HyperLink></li>
								            		
								            		<li><asp:HyperLink runat="server" ID="hpfb" Target="_blank"><i class="ti ti-facebook"></i></asp:HyperLink></li>
								            	</ul>
								            </td>
								          </tr>
								        </tbody>
								      </table>
								    </div>
							</div>
                              
							<div class="about-area">
						      	<h4><i class=" ti ti-user"></i>&nbsp; Personal Information</h4>
								    <div class="table-responsive">
								      <table class="table about-table">
								        <tbody>
								          <tr>
								            <th>Full Name</th>
								            <td> <asp:Label ID="lblpFullName" runat="server" Text=""></asp:Label></td>
								          </tr>
								          <tr>
								            <th>Username</th>
								            <td>
                                                <asp:Label ID="lblpUsername" runat="server" Text=""></asp:Label></td>
								          </tr>
								          
								          <tr>
								            <th>Gender</th>
								            <td>
                                                <asp:Label ID="lblpGender" runat="server" Text=""></asp:Label></td>
								          </tr>
								         
								          <tr>
								            <th>Address</th>
								            <td>
                                                <asp:Label ID="lblpAddress" runat="server" Text="Label"></asp:Label></td>
								          </tr>
								         
								        </tbody>
								      </table>
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
						                                      <div class="panel-body scroll-pane" style="height:210px;">	
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
                                   <tr><td>Event Type</td><td>  <asp:Label Text='<%# Eval("varEventTypeName") %>' runat="server" ID="varEventTypeNameLabel" /></td></tr>
                                   <tr><td>Subject</td><td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="varSubjectLabel" /></td></tr>
                                   <tr><td>Description</td><td> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Label2" /></td></tr>
                                   <tr><td>Start Date</td><td>  <asp:Label Text='<%# Eval("varStartDate") %>' runat="server" ID="varStartDateLabel" /></td></tr>
                                          
                               </table></div>
                                                                            
                                                                        </AlternatingItemTemplate>
                                                                         
                                                                        <ItemTemplate>
                                                                           <div class="info-tile info-tile-alt tile-success">
                                                                                 <table class="table tile-heading">
                                   <tr><td> Organiser :</td><td> <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /> </td></tr>
                                   <tr><td>Event Type</td><td>  <asp:Label Text='<%# Eval("varEventTypeName") %>' runat="server" ID="varEventTypeNameLabel" /></td></tr>
                                   <tr><td>Subject</td><td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="varSubjectLabel" /></td></tr>
                                   <tr><td>Description</td><td> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Label2" /></td></tr>
                                   <tr><td>Start Date</td><td>  <asp:Label Text='<%# Eval("varStartDate") %>' runat="server" ID="varStartDateLabel" /></td></tr>
                                            
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
               <asp:HyperLink ID="HyperLink2"  NavigateUrl="~/Society/View/ViewEventEnnouncement.aspx" runat="server" CssClass="btn btn-primary-alt btn-sm btn-block ">See all </asp:HyperLink>
                           
                                                           </div>
                                </div>
                            <div class="col-md-6"> 
                                <div class="panel panel-info"  data-widget='{"id" : "wiget8", "draggable": "false"}'>
			<div class="panel-heading">
				<h2><i class="ti  ti-comments-smiley"></i>Poll </h2>
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
    	                                               <%--<div class="panel panel-info"  data-widget='{"id" : "wiget3", "draggable": "false"}'>
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
                                                                    
                                                                                <td> <asp:Label Text='<%# Eval("Pname") %>' runat="server" ID="Label2" /></td>
                                                                               <td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="Type" /></td>
                                                                             <td>    <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                                                  <td>   <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="varStartDate"  CssClass='<%# Eval("varStatus").ToString() == "Approved" ? "label label-success" :Eval("varStatus").ToString()=="Rejected"? "label label-danger":"label label-warning" %>' /></td>
                                                                                     </tr>
                                                                     </ItemTemplate>
                                                                     <LayoutTemplate>
                                                       
                                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                                         <tr id="Tr1" runat="server" class="danger">                                                                            
                                                                                         
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
                                                                  </div> <asp:HyperLink ID="HyperLink3"  NavigateUrl="~/Society/Admin/Property/Approvals.aspx" runat="server" CssClass="btn btn-primary-alt btn-sm btn-block ">See all </asp:HyperLink>
               
					                                    </div>--%>
                                                      </div>
                        </div>
                         <div class="row">
                             <uc1:GroupDiscussion runat="server" ID="GroupDiscussion" />
                             </div>
                    </div>
                      <div class="col-lg-3"> 
                           
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
						                    <div class="panel-body profile-photos">	
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
                                                            <div id="Div1" runat="server" style=""> 
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
				<h2><i class="ti ti-pin-alt"></i>NoticeBoard </h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''>
				</div>	
			</div>
						                    <div class="panel-body scroll-pane" style="height:200px;">	
                                                <div class="row scroll-content marquee">					
                                                    <asp:ListView ID="lstNoticeboard" runat="server" DataSourceID="SqlNoticeboard">
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
                                                                <asp:Label Text='<%# Eval("Property") %>' CssClass="label label-success" runat="server" ID="Label3" /><br />
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
                              
                                                    <asp:SqlDataSource ID="SqlNoticeboard" runat="server" 
                                                      
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  >       
                             
                            </asp:SqlDataSource> 
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
						                                                  <div class="panel-body scroll-pane" style="height:200px;">	
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
                                                                              </div> <asp:HyperLink ID="HyperLink4"  NavigateUrl="~/Society/View/ViewClassified.aspx" runat="server"  CssClass="btn btn-primary-alt btn-sm btn-block ">See all </asp:HyperLink>
                        
					                                                </div>
                                                    </div>

                      
                    </div>
           
		</div>
</div>
      
</asp:Content>






