<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="AddFeature.aspx.cs" Inherits="Society_Admin_MasterData_AddFeature" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2> Feature Information</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
                      
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Parent Feature Name </label>
									<div class="col-sm-8">
									   <asp:DropDownList ID="ddlparentFeatureName" runat="server" AppendDataBoundItems="true" CssClass="form-control">
                                             <asp:ListItem Value="">:: Select Parent Menu ::</asp:ListItem>
                                         </asp:DropDownList>
									</div>
									
								</div>
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Is SubMenu</label>
									<div class="col-sm-8">
										  <asp:DropDownList ID="ddlisSubMenu" runat="server"  CssClass="form-control"  required="required">
                                                <asp:ListItem Value="">:: Select SubMenu ::</asp:ListItem>
                                                  <asp:ListItem  Value="1">Yes</asp:ListItem>
                                                <asp:ListItem Value="0">No</asp:ListItem>
                                            </asp:DropDownList>
									</div>
									
								</div>      
                        	<div class="form-group">
                                	<label for="inputPassword" class="col-sm-3   control-label">Features Name</label>
									<div class="col-sm-8">
									   <asp:TextBox ID="txtFeaturesName" runat="server" onkeyup="checkText(this);" required="required"   CssClass="form-control"></asp:TextBox> 
									</div>
                                </div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Page Path</label>
									<div class="col-sm-8">
										 <asp:TextBox ID="txtPageName" runat="server" required="required"  CssClass="form-control"></asp:TextBox>
									</div>
								</div>
                        	
                
							<div class="form-group">
                                		<div class="col-sm-3  "></div>	
									<div class="col-sm-8">
									<label class="checkbox-inline">	  <asp:CheckBox ID="chkIsActive" runat="server"  /> Is Active 	 </label>
									</div>
                                </div>
                        <div class="form-group">
									<div class="col-sm-3  "></div>
									<div class="col-sm-8">
									  <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" Visible="false"  OnClick="btnUpdate_Click"/>
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddFeature.aspx" >Reset</a>
									</div>
								</div>
                          <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
					
					</div>
					
				</div>
				
			</div>
		</div>
        <div class="col-md-6 ">
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
                                                     
                                          <%--       <asp:GridView ID="grdFeatures" runat="server" AllowPaging="true" PageSize="5"  CssClass="table table-bordered table-hover" OnPageIndexChanging="grdFeatures_PageIndexChanging">
                                                      <HeaderStyle CssClass="info" />
                                                      <PagerStyle HorizontalAlign = "left" CssClass = "pager" />
                                                 </asp:GridView>--%>                                              
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
                                                                  <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("FeatureId") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                              
                                                       
                                                               <td><asp:Label Text='<%# Eval("varFeatureName") %>' runat="server" ID="FeatureName" /></td>                                                           
                                                                  <td><asp:Label Text='<%# Eval("PageName") %>' runat="server" ID="PageName" /></td>
                                                              <td><asp:Label Text='<%# Eval("IsActive") %>' runat="server" ID="IsActive" /></td>
                                                               
                                                          
                                                            
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            <th id="Th1" runat="server" >Operation</th>
                                                                           
                                                                            
                                                                             <th id="Th4" runat="server">Feature Name</th> 
                                                                              <th id="Th3" runat="server">Page Path</th>
                                                                                    <th id="Th6" runat="server">IsActive</th>
                                                                              
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstType" PageSize="100">
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
    	<div class="row">
	      <div class="col-xs-12">
	        <div class="panel panel-primary" data-widget='{"draggable": "false"}'>
	            <div class="panel-heading">
	                <h2>Icons</h2>
	            	<div class="panel-ctrls" data-actions-container="" data-action-collapse='{"target": ".panel-body"}'>
	            	</div>
	            </div>
	            <div class="panel-body">
    <section class="icon-section">
					 
						<div class="row">
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-control-stop"></span><span class="icon-name"> ti-control-stop</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-control-shuffle"></span><span class="icon-name"> ti-control-shuffle</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-control-play"></span><span class="icon-name"> ti-control-play</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-control-pause"></span><span class="icon-name"> ti-control-pause</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-control-forward"></span><span class="icon-name"> ti-control-forward</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-control-backward"></span><span class="icon-name"> ti-control-backward</span>
							</div>	
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-volume"></span><span class="icon-name"> ti-volume</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-control-skip-forward"></span><span class="icon-name"> ti-control-skip-forward</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-control-skip-backward"></span><span class="icon-name"> ti-control-skip-backward</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-control-record"></span><span class="icon-name"> ti-control-record</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-control-eject"></span><span class="icon-name"> ti-control-eject</span>
							</div>
						</div> 
				 
						<div class="row">

							<div class="col-md-3 col-sm-4">
								<span class="ti ti-paragraph"></span><span class="icon-name"> ti-paragraph</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-uppercase"></span><span class="icon-name"> ti-uppercase</span>
							</div>

							<div class="col-md-3 col-sm-4">
								<span class="ti ti-underline"></span><span class="icon-name"> ti-underline</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-text"></span><span class="icon-name"> ti-text</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-Italic"></span><span class="icon-name"> ti-Italic</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-smallcap"></span><span class="icon-name"> ti-smallcap</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-list"></span><span class="icon-name"> ti-list</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-list-ol"></span><span class="icon-name"> ti-list-ol</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-align-right"></span><span class="icon-name"> ti-align-right</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-align-left"></span><span class="icon-name"> ti-align-left</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-align-justify"></span><span class="icon-name"> ti-align-justify</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-align-center"></span><span class="icon-name"> ti-align-center</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-quote-right"></span><span class="icon-name"> ti-quote-right</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-quote-left"></span><span class="icon-name"> ti-quote-left</span>
							</div>
						</div>
					   
						<div class="row">
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-width-full"></span><span class="icon-name"> ti-layout-width-full</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-width-default"></span><span class="icon-name"> ti-layout-width-default</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-width-default-alt"></span><span class="icon-name"> ti-layout-width-default-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-tab"></span><span class="icon-name"> ti-layout-tab</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-tab-window"></span><span class="icon-name"> ti-layout-tab-window</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-tab-v"></span><span class="icon-name"> ti-layout-tab-v</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-tab-min"></span><span class="icon-name"> ti-layout-tab-min</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-slider"></span><span class="icon-name"> ti-layout-slider</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-slider-alt"></span><span class="icon-name"> ti-layout-slider-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-sidebar-right"></span><span class="icon-name"> ti-layout-sidebar-right</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-sidebar-none"></span><span class="icon-name"> ti-layout-sidebar-none</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-sidebar-left"></span><span class="icon-name"> ti-layout-sidebar-left</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-placeholder"></span><span class="icon-name"> ti-layout-placeholder</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-menu"></span><span class="icon-name"> ti-layout-menu</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-menu-v"></span><span class="icon-name"> ti-layout-menu-v</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-menu-separated"></span><span class="icon-name"> ti-layout-menu-separated</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-menu-full"></span><span class="icon-name"> ti-layout-menu-full</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-media-right"></span><span class="icon-name"> ti-layout-media-right</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-media-right-alt"></span><span class="icon-name"> ti-layout-media-right-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-media-overlay"></span><span class="icon-name"> ti-layout-media-overlay</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-media-overlay-alt"></span><span class="icon-name"> ti-layout-media-overlay-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-media-overlay-alt-2"></span><span class="icon-name"> ti-layout-media-overlay-alt-2</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-media-left"></span><span class="icon-name"> ti-layout-media-left</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-media-left-alt"></span><span class="icon-name"> ti-layout-media-left-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-media-center"></span><span class="icon-name"> ti-layout-media-center</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-media-center-alt"></span><span class="icon-name"> ti-layout-media-center-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-list-thumb"></span><span class="icon-name"> ti-layout-list-thumb</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-list-thumb-alt"></span><span class="icon-name"> ti-layout-list-thumb-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-list-post"></span><span class="icon-name"> ti-layout-list-post</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-list-large-image"></span><span class="icon-name"> ti-layout-list-large-image</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-line-solid"></span><span class="icon-name"> ti-layout-line-solid</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-grid4"></span><span class="icon-name"> ti-layout-grid4</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-grid3"></span><span class="icon-name"> ti-layout-grid3</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-grid2"></span><span class="icon-name"> ti-layout-grid2</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-grid2-thumb"></span><span class="icon-name"> ti-layout-grid2-thumb</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-cta-right"></span><span class="icon-name"> ti-layout-cta-right</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-cta-left"></span><span class="icon-name"> ti-layout-cta-left</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-cta-center"></span><span class="icon-name"> ti-layout-cta-center</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-cta-btn-right"></span><span class="icon-name"> ti-layout-cta-btn-right</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-cta-btn-left"></span><span class="icon-name"> ti-layout-cta-btn-left</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-column4"></span><span class="icon-name"> ti-layout-column4</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-column3"></span><span class="icon-name"> ti-layout-column3</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-column2"></span><span class="icon-name"> ti-layout-column2</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-accordion-separated"></span><span class="icon-name"> ti-layout-accordion-separated</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-accordion-merged"></span><span class="icon-name"> ti-layout-accordion-merged</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-accordion-list"></span><span class="icon-name"> ti-layout-accordion-list</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-widgetized"></span><span class="icon-name"> ti-widgetized</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-widget"></span><span class="icon-name"> ti-widget</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-widget-alt"></span><span class="icon-name"> ti-widget-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-view-list"></span><span class="icon-name"> ti-view-list</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-view-list-alt"></span><span class="icon-name"> ti-view-list-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-view-grid"></span><span class="icon-name"> ti-view-grid</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-upload"></span><span class="icon-name"> ti-upload</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-download"></span><span class="icon-name"> ti-download</span>
							</div>	
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-loop"></span><span class="icon-name"> ti-loop</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-sidebar-2"></span><span class="icon-name"> ti-layout-sidebar-2</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-grid4-alt"></span><span class="icon-name"> ti-layout-grid4-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-grid3-alt"></span><span class="icon-name"> ti-layout-grid3-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-grid2-alt"></span><span class="icon-name"> ti-layout-grid2-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-column4-alt"></span><span class="icon-name"> ti-layout-column4-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-column3-alt"></span><span class="icon-name"> ti-layout-column3-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-layout-column2-alt"></span><span class="icon-name"> ti-layout-column2-alt</span>
							</div>
						</div> 

						<div class="row">
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-flickr"></span><span class="icon-name"> ti-flickr</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-flickr-alt"></span><span class="icon-name"> ti-flickr-alt</span>
							</div>			
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-instagram"></span><span class="icon-name"> ti-instagram</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-google"></span><span class="icon-name"> ti-google</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-github"></span><span class="icon-name"> ti-github</span>
							</div>

							<div class="col-md-3 col-sm-4">
								<span class="ti ti-facebook"></span><span class="icon-name"> ti-facebook</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-dropbox"></span><span class="icon-name"> ti-dropbox</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-dropbox-alt"></span><span class="icon-name"> ti-dropbox-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-dribbble"></span><span class="icon-name"> ti-dribbble</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-apple"></span><span class="icon-name"> ti-apple</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-android"></span><span class="icon-name"> ti-android</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-yahoo"></span><span class="icon-name"> ti-yahoo</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-trello"></span><span class="icon-name"> ti-trello</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-stack-overflow"></span><span class="icon-name"> ti-stack-overflow</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-soundcloud"></span><span class="icon-name"> ti-soundcloud</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-sharethis"></span><span class="icon-name"> ti-sharethis</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-sharethis-alt"></span><span class="icon-name"> ti-sharethis-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-reddit"></span><span class="icon-name"> ti-reddit</span>
							</div>

							<div class="col-md-3 col-sm-4">
								<span class="ti ti-microsoft"></span><span class="icon-name"> ti-microsoft</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-microsoft-alt"></span><span class="icon-name"> ti-microsoft-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-linux"></span><span class="icon-name"> ti-linux</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-jsfiddle"></span><span class="icon-name"> ti-jsfiddle</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-joomla"></span><span class="icon-name"> ti-joomla</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-html5"></span><span class="icon-name"> ti-html5</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-css3"></span><span class="icon-name"> ti-css3</span>
							</div>	
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-drupal"></span><span class="icon-name"> ti-drupal</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-wordpress"></span><span class="icon-name"> ti-wordpress</span>
							</div>		
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-tumblr"></span><span class="icon-name"> ti-tumblr</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-tumblr-alt"></span><span class="icon-name"> ti-tumblr-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-skype"></span><span class="icon-name"> ti-skype</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-youtube"></span><span class="icon-name"> ti-youtube</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-vimeo"></span><span class="icon-name"> ti-vimeo</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-vimeo-alt"></span><span class="icon-name"> ti-vimeo-alt</span>
							</div>			
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-twitter"></span><span class="icon-name"> ti-twitter</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-twitter-alt"></span><span class="icon-name"> ti-twitter-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-linkedin"></span><span class="icon-name"> ti-linkedin</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-pinterest"></span><span class="icon-name"> ti-pinterest</span>
							</div>

							<div class="col-md-3 col-sm-4">
								<span class="ti ti-pinterest-alt"></span><span class="icon-name"> ti-pinterest-alt</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-themify-logo"></span><span class="icon-name"> ti-themify-logo</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-themify-favicon"></span><span class="icon-name"> ti-themify-favicon</span>
							</div>
							<div class="col-md-3 col-sm-4">
								<span class="ti ti-themify-favicon-alt"></span><span class="icon-name"> ti-themify-favicon-alt</span>
							</div>
						</div>
					 </section>
                    </div>
                </div>
              </div>
            </div>
    
</asp:Content>

