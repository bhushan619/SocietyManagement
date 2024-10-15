<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="DocumentReport.aspx.cs" Inherits="Society_Reports_DocumentReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
     <asp:HiddenField ID="SubTab" runat="server" />
                    <script type="text/javascript">
                       

                        $(function () {
                            var tabName = $("[id*=ContentPlaceHolder1_SubTab]").val() != "" ? $("[id*=ContentPlaceHolder1_SubTab]").val() : "Property";
                            $('#DocSubTag a[href="#' + tabName + '"]').tab('show');
                            $("#DocSubTag a").click(function () {
                                $("[id*=ContentPlaceHolder1_SubTab]").val($(this).attr("href").replace("#", ""));
                            });
                        });
</script>
 <div class="row">
            <div class="col-lg-12">  
                    <div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2><i class="ti  ti-home"></i>All  Documents Report Details </h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''>
				</div>	
			</div>
         <div class="panel-body" >
            
                                                 
                                                  <div class="row">   
<div class="col-lg-12"> 
                            <div id="DocSubTag" role="tabpanel">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
       <li class="active"><a aria-controls="Property" href="#Property" role="tab" data-toggle="tab">Property &nbsp;<i class="ti ti-dropbox-alt" style="color:#558b2f;"></i></a></li>
        <li><a href="#Employee" aria-controls="Employee" role="tab" data-toggle="tab">Employee &nbsp;<i class="fa fa-file-text"  style="color:#ba68c8;"></i></a></li>  
	</ul></div>   <br />
        <div class="tab-content">
                         <div class="tab-pane active"  role="tabpanel"  id="Property"> 
                              <div class="row"> 
                                <div class="col-lg-2 col-sm-3"></div>  
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
                                <asp:Button ID="btnSearch" runat="server" Text="Search"  OnClick="btnSearch_Click" CssClass="btn btn-primary"/>
                                 <a href="DocumentReport.aspx"  class="btn btn-danger">Reset</a>
                            </div>

                                </div>
                        
                          </div>
                                 <div class="row"> 
                     <div class="col-lg-12"> 
         
				<div id="accordionA" class="panel-body no-padding  table-responsive">  

			 <asp:ListView ID="lstDocument" runat="server"  OnPagePropertiesChanging="lstDocument_PagePropertiesChanging" OnItemCommand="lstDocument_ItemCommand"  >
                  <EmptyDataTemplate>
                                  <span>No data was returned.</span> 
                              </EmptyDataTemplate> 
                              <ItemTemplate>
                                  <div class="panel panel-default">
				                        <a data-toggle="collapse" data-parent="#accordionA" href='<%# "#"+ Eval("varPersonnelId") %>'><div class="panel-heading"><h2><asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" />&nbsp;&nbsp;(&nbsp;<asp:Label Text='<%# Eval("wing") %>' runat="server" ID="Label1" />&nbsp;)</h2></div></a>
                                                  <asp:Localize Text='<%# Eval("varPersonnelId") %>' runat="server" ID="lblPersonalId" Visible="false" />
				                            <div id='<%# Eval("varPersonnelId") %>' class="collapse">
					        <div class="panel-body">
                        	  <asp:SqlDataSource ID="sqlGallery" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                                  SelectCommand="SELECT        tbldocuments.intId, tbldocuments.varSocietyId, tbldocuments.varPersonnelId,tbldocuments.intRoleId, tbldocuments.varDescription, tbldocuments.varDocument,    tbldocuments.varCreatedDate, tbldocuments.varCreatedBy, tbldocuments.varStatus, tbldocuments.intIsActive, tblmasterdocumenttype.varDocumentName,   CONCAT(tblmastersocietywing.varWingName, '-', tblproperty.varPropertyCode, '-', tblproperty.varName) AS Name FROM            tbldocuments INNER JOIN  tblmasterdocumenttype ON tbldocuments.intDocumentType = tblmasterdocumenttype.intId INNER JOIN  tblproperty ON tbldocuments.varPersonnelId = tblproperty.varPropertyId INNER JOIN tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId where varPersonnelId=@proId" >   
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblPersonalId" Type="String" Name="proId" PropertyName="Text" />
                                </SelectParameters>
                        	  </asp:SqlDataSource>
		
						    <asp:ListView ID="LstGallary" runat="server" DataSourceID="sqlGallery"> 
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
                                                                <div  class="col-md-2 text-center">
									                    <asp:Image ID="imgSimilarPic" runat="server" CssClass="img-thumbnail img-responsive mb-xl fancybox"   Height="100px" Width="130px"   ImageUrl='<%# "~/Society/Media/Documents/" + Eval("varDocument") %>' />  <br />
                                                                    
                                                                    <asp:Localize ID="Localize1"  runat="server" Text=<%# Eval("varDocumentName") %>></asp:Localize>
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
					            </div>
				            </div>
			            </div>
                              </ItemTemplate>
                              <LayoutTemplate>
                                  <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                                  <div style="">
                                  </div>
                              </LayoutTemplate>                               
                          </asp:ListView>		 
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                            <asp:DataPager ID="DataPagerDocument" runat="server"  PagedControlID="lstDocument" PageSize="10">
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
            <div class="tab-pane"  role="tabpanel"  id="Employee">
                       <div class="row"> 
                                <div class="col-lg-2 col-sm-3"></div>  
                                         <div class="col-lg-5 col-sm-3">
                                           <div class="form-group">                                              
                                               <asp:TextBox ID="txtemplyeeName" placeholder="Enter  Name"   runat="server"  CssClass="form-control"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="txtemplyeeName_auto" runat="server" 
                                            MinimumPrefixLength="1" CompletionInterval="1" 
                                            EnableCaching="true"
                                               DelimiterCharacters=""
                                                Enabled="True" 
                                                ServiceMethod="GetCompletionListemployee" 
                                                CompletionSetCount="1" 
                                                TargetControlID="txtemplyeeName" UseContextKey="True">
                                           </cc1:AutoCompleteExtender>
                                             
                                             </div> 
                                         </div>
                                <div class="col-lg-3 col-sm-3">
                            <div class="form-group">
                                <asp:Button ID="btnemployee" runat="server" Text="Search"  OnClick="btnSearchemployee_Click" CssClass="btn  btn-primary"/>
                                 <a href="DocumentReport.aspx"  class="btn btn-danger">Reset</a>
                            </div>

                                </div>
                        
                          </div>
                 <div class="row"> 
                     <div class="col-lg-12"> 
            <div class="panel panel-info"> 
				<div class="panel-body no-padding  table-responsive"> 
                         
                                
                      <div class="table-responsive">
                                                 <asp:ListView ID="lstDocEmployee" runat="server" OnPagePropertiesChanging="lstDocEmployee_PagePropertiesChanging"  >
                                                  <EmptyDataTemplate>
                                  <span>No data was returned.</span> 
                              </EmptyDataTemplate> 
                              <ItemTemplate>
                                  <div class="panel panel-default">
				                        <a data-toggle="collapse" data-parent="#accordionA" href='<%# "#"+ Eval("varPersonnelId") %>'><div class="panel-heading"><h2><asp:Label Text='<%# Eval("varEmpName") %>' runat="server" ID="NameLabel" />&nbsp;&nbsp;</h2></div></a>
                                                  <asp:Localize Text='<%# Eval("varPersonnelId") %>' runat="server" ID="lblPersonalId" Visible="false" />
				                            <div id='<%# Eval("varPersonnelId") %>' class="collapse">
					        <div class="panel-body">
                        	  <asp:SqlDataSource ID="sqlGallery" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                                  SelectCommand="SELECT        tbldocuments.intId, tbldocuments.varSocietyId, tbldocuments.varPersonnelId, tbldocuments.intRoleId, tbldocuments.varDescription, tbldocuments.varDocument,         tbldocuments.varCreatedDate, tbldocuments.varCreatedBy, tbldocuments.varStatus, tbldocuments.intIsActive, tblmasterdocumenttype.varDocumentName,   tblsocietypersonnel.varEmpName FROM            tbldocuments INNER JOIN          tblmasterdocumenttype ON tbldocuments.intDocumentType = tblmasterdocumenttype.intId INNER JOIN    tblsocietypersonnel ON tbldocuments.varPersonnelId = tblsocietypersonnel.intEmpCode where varPersonnelId=@proId" >   
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblPersonalId" Type="String" Name="proId" PropertyName="Text" />
                                </SelectParameters>
                        	  </asp:SqlDataSource>
		
						    <asp:ListView ID="LstGallary" runat="server" DataSourceID="sqlGallery"> 
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
                                                                <div  class="col-md-2 text-center">
									                    <asp:Image ID="imgSimilarPic" runat="server" CssClass="img-thumbnail img-responsive mb-xl fancybox"   Height="100px" Width="130px"   ImageUrl='<%# "~/Society/Media/Documents/" + Eval("varDocument") %>' />  <br />
                                                                    
                                                                    <asp:Localize ID="Localize1"  runat="server" Text=<%# Eval("varDocumentName") %>></asp:Localize>
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
					            </div>
				            </div>
			            </div>
                              </ItemTemplate>
                              <LayoutTemplate>
                                  <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                                  <div style="">
                                  </div>
                              </LayoutTemplate>  
                                                     
                                                 </asp:ListView>
                          </div
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPagerDocEmp" runat="server"  PagedControlID="lstDocEmployee" PageSize="10">
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
                             </div>
            </div>
		</div> 
  </div>
 </div>  

 </div>
 </div>
</div>       


</asp:Content>




