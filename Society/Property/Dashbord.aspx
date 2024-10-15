<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Property.master" AutoEventWireup="true" CodeFile="Dashbord.aspx.cs" Inherits="Society_Property_Dashbord" %>
<%@ Register Src="~/Society/UserControl/GroupDiscussion.ascx" TagPrefix="uc1" TagName="GroupDiscussion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row">
		<div class="col-lg-12 ">
                    <div class="col-lg-9 "> 
                        <div class="row"> 
                                      <div class="col-md-12"> 
                                         <div class="panel panel-info"  data-widget='{"id" : "wiget1", "draggable": "false"}'>
			                                                <div class="panel-heading">
				                                                <h2><i class="fa fa-home"></i>Property Information </h2>
				                                                <div class="panel-ctrls button-icon" 
					                                                data-actions-container="" 
					                                                data-action-collapse='{"target": ".panel-body"}'
					                                                data-action-colorpicker=''>
				                                                </div>	
			                                                </div>
						                                      <div class="panel-body" >	
                                                                  <div class="row">
                         <div class="col-md-6">  
                             <div class="form-group "> 
                                  <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                                </div>                 
                        </div>
                    
                </div>
                                                                <div class="row">
                                                          
                                                              <div class="col-lg-4">
					                      <div  class="form-horizontal">
                                            <div runat="server" id="myproerty">
                                                                       <div class="form-group text-center">
						      	                                                    <h4>Flat Information</h4>
                                   
                                                                                </div>
                                                                    <div class="form-group">
									                                            <label for="focusedinput" class="col-sm-4   control-label">Wing</label>
									                                            <div class="col-sm-8">
										                                            <asp:DropDownList ID="ddlWing"  runat="server" CssClass="form-control"  required="required">
                                                                           <asp:ListItem>:: Select  Wing ::</asp:ListItem>                                                      
                                                                       </asp:DropDownList>
									                                            </div>									
								                                            </div>   
                         
                                                                     <div class="form-group">
                             
									                                            <label for="focusedinput" class="col-sm-4   control-label">Premises</label>
                                                
									                                            <div class="col-sm-8">
										                                               <asp:DropDownList ID="ddlPremises" AutoPostBack="true"  runat="server" CssClass="form-control"  required="required" OnSelectedIndexChanged="ddlPremises_SelectedIndexChanged">
                                                                           <asp:ListItem>:: Select Premises ::</asp:ListItem>                                                      
                                                                       </asp:DropDownList>	</div>
									
								                                            </div>
                         
                                                                     <div class="form-group">
									                                            <label for="focusedinput" class="col-sm-4   control-label">Premises Type</label>
                                       
									                                            <div class="col-sm-8">
										                                                    <asp:DropDownList ID="ddlPremisesType" AutoPostBack="true"  runat="server" CssClass="form-control"  required="required">
                                                                           <asp:ListItem>:: Select Premises Type ::</asp:ListItem>                                                      
                                                                       </asp:DropDownList></div>
									
								                                            </div>
                         
                                                                     <div class="form-group">
									                                            <label for="focusedinput" class="col-sm-4   control-label">Property/Flat Number</label>
									                                            <div class="col-sm-8">
										                                                   <asp:TextBox ID="txtflatno" runat="server" CssClass="form-control" required="required"></asp:TextBox>
									                                            </div>									
								                                            </div>
                                                   <div class="form-group">
									    <label for="focusedinput" class="col-sm-4   control-label">Extension Number</label>
									    <div class="col-sm-8">
										           <asp:TextBox ID="txtPropertyExtensionNumber" required="required" runat="server" CssClass="form-control"></asp:TextBox>
									    </div>									
								    </div>
                                                 </div>
                                           </div>
                             </div>
                                <div class="col-lg-8">
					                <div  class="form-horizontal">
                                           <div class="form-group text-center">
						      	                <h4>Owner Information</h4>
                                            </div>
                                             <div class="form-group">
									                <label for="focusedinput" class="col-sm-4   control-label">Owner Name</label>
									                <div class="col-sm-8">
										                       <asp:TextBox ID="txtowner" runat="server" CssClass="form-control" required="required"></asp:TextBox>
									                </div>									
								                </div>
                                        
                                              <div class="form-group">
									                <label for="focusedinput" class="col-sm-4   control-label"> Phone Number</label>
									                <div class="col-sm-8">
										                       <asp:TextBox ID="txtphone" runat="server" CssClass="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12"></asp:TextBox>
									                </div>									
								                </div>
                                             <div class="form-group">
									                <label for="focusedinput" class="col-sm-4   control-label">Primary Mobile Number</label>
									                <div class="col-sm-8">
										                       <asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12" required="required"></asp:TextBox>
									                </div>									
								                </div>                        
                                            <div class="form-group">
									                    <label for="focusedinput" class="col-sm-4   control-label"> Other Mobile Numbers</label>
									                    <div class="col-sm-8">
										                           <asp:TextBox ID="txtAltMobileNos" runat="server" CssClass="form-control"   placeholder="Alternate Mobile Numbers Seprated By ';'"  ></asp:TextBox>
									                    </div>									
								                    </div>
                                            <div class="form-group">
									                    <label for="focusedinput" class="col-sm-4   control-label">Primary Email-Id</label>
									                    <div class="col-sm-8">
										                           <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)"   required="required"></asp:TextBox>
									                    </div>									
								                    </div>  
                                            <div class="form-group">
									                    <label for="focusedinput" class="col-sm-4   control-label">Other Email-Ids</label>
									                    <div class="col-sm-8">
										                           <asp:TextBox ID="txtAltEmailIds" runat="server" CssClass="form-control"   ></asp:TextBox>
                                                                                                     <small>(Ex.mail@example.com;myname@mydomain.com)</small>
									                    </div>									
								                    </div>                        	
							
                                             <div class="form-group">
									                <div class="col-sm-4  "></div>
									                <div class="col-sm-8">
							                 <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update"   OnClick="btnUpdate_Click"/>
                     		                <%--   <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />--%>
                                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="Dashbord.aspx" >Reset</a>
									                </div>
								                </div>                         
                                        </div>  
                                   </div>
                                                                      </div>
                                                                  </div>
                                             </div>
                                    </div>
                                </div>
                <div class="row"> 
                                      <div class="col-md-12"> 
                                         <div class="panel panel-info"  data-widget='{"id" : "wiget2", "draggable": "false"}'>
			                                                <div class="panel-heading">
				                                                <h2><i class="fa fa-file-text"></i>Latest Invoices </h2>
				                                                <div class="panel-ctrls button-icon" 
					                                                data-actions-container="" 
					                                                data-action-collapse='{"target": ".panel-body"}'
					                                                data-action-colorpicker=''>
				                                                </div>	
			                                                </div>
						                                      <div class="panel-body scroll-pane" style="height:250px;">	
                                                                <div class="row scroll-content">
                                                         <div class="table-responsive">
                                                             <asp:ListView ID="lstInvoices" runat="server" DataSourceID="SqlDataSourceInvoice" OnItemCommand="lstInvoices_ItemCommand">
         
         
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
                 <td class="text-center"> 
                     <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId") %>' CommandName="view" ToolTip="View Full Invoice"  runat="server"  CssClass=" fa fa-eye" style="color:#558b2f"/></td>
                <td class="text-center"> 
                     <asp:LinkButton  ID="LinkButton1" CommandArgument='<%# Eval("InvoiceNo") +":"+ Eval("varPersonnelId") %>' CommandName="pay" ToolTip="Pay Bill Now"  runat="server" Enabled='<%# Eval("[Payment Status]").ToString() == "Paid" ? false : true %>' CssClass=" fa fa-credit-card" style="color:#ff6a00"/></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
             
                        <table runat="server" id="itemPlaceholderContainer" class="table table-bordered table-hover" border="0">
                            <tr id="Tr1" runat="server" style="">
                                 <th id="Th1" runat="server">Sr. No.</th>
                                <th id="Th2" runat="server">Name</th>
                                <th id="Th3" runat="server">InvoiceNo</th>
                                <th id="Th4" runat="server">Date</th>
                                <th id="Th5" runat="server">Amount</th>
                                <th id="Th6" runat="server">Outstanding</th>
                                <th id="Th7" runat="server">Status</th>
                                 <th id="Th8" colspan="2" class="text-center" runat="server">#</th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </table> 
        </LayoutTemplate>
         
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceInvoice" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' ProviderName='<%$ ConnectionStrings:ConnectionString.ProviderName %>' >
      
    </asp:SqlDataSource>
                                                                      </div>
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
                                                                              <div class="info-tile info-tile-alt tile-blue">
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
                                                                           <div class="info-tile info-tile-alt tile-primary">
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
                              <uc1:GroupDiscussion runat="server" ID="GroupDiscussion" pagesize="5" />
                               </div>     
                        </div>
                    </div>
                    <div class="col-lg-3"> 
                        <div class="row">
    	                    <div class="panel "  data-widget='{"id" : "wiget3", "draggable": "false"}'>
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
                                                     
                                                                             <asp:ListView ID="lstTypeClassified" runat="server"  >
                                                 
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
                                   <tr><td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="NameLabel" Font-Bold="true" Font-Size="Medium" ForeColor="Teal" /> </td></tr>
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
    	                <div class="panel panel-info"  data-widget='{"id" : "wiget5", "draggable": "false"}'>
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
                        </div>
                                 
                        
                    </div>
		</div>
</div>
      
</asp:Content>


