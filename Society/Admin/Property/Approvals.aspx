<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/masterpage.master" AutoEventWireup="true" CodeFile="Approvals.aspx.cs" Inherits="Society_Admin_Property_Approvals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
 <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <asp:HiddenField ID="TabName" runat="server" />
     <asp:HiddenField ID="SubTab" runat="server" />
                    <script type="text/javascript">
                        $(function () {
                            var tabName = $("[id*=ContentPlaceHolder1_TabName]").val() != "" ? $("[id*=ContentPlaceHolder1_TabName]").val() : "Flat";
                            $('#Tabs a[href="#' + tabName + '"]').tab('show');
                            $("#Tabs a").click(function () {
                                $("[id*=ContentPlaceHolder1_TabName]").val($(this).attr("href").replace("#", ""));
                            });
                        });

                        $(function () {
                            var tabName = $("[id*=ContentPlaceHolder1_SubTab]").val() != "" ? $("[id*=ContentPlaceHolder1_SubTab]").val() : "Property";
                            $('#DocSubTag a[href="#' + tabName + '"]').tab('show');
                            $("#DocSubTag a").click(function () {
                                $("[id*=ContentPlaceHolder1_SubTab]").val($(this).attr("href").replace("#", ""));
                            });
                        });
</script>

     
<div class="panel-body">
             <div class="row">
                         <div class="col-md-6">  
                             <div class="form-group "> 
                                  <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                                </div>                 
                        </div>
                    
                </div>
   <div class="row">
		<div class="col-md-12 ">
        <div id="Tabs" role="tabpanel">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
       <li class="active"><a aria-controls="Flat" href="#Flat" role="tab" data-toggle="tab">Requests &nbsp;<i class="ti ti-dropbox-alt" style="color:#558b2f;"></i></a></li>
        <li><a href="#Owner" aria-controls="Owner" role="tab" data-toggle="tab">Notice Boards &nbsp;<i class="fa fa-file-text"  style="color:#ba68c8;"></i></a></li>  
	
        <li><a href="#Family" aria-controls="Family" role="tab" data-toggle="tab">Documents &nbsp; <i class="fa fa-file"  style="color:#ff8f00;"></i></a></li>  
	    </ul>
    <!-- Tab panes -->
    
    </div>
        <br />
        <div class="tab-content">
				<div class="tab-pane active"  role="tabpanel"  id="Flat">  
                    
			<div class="tab-pane active"  role="tabpanel"  id="UnApprovedReq"> 
                     <div class="col-lg-12"> 
            <div class="panel panel-info"> 
				<div class="panel-body no-padding  table-responsive"> 
                      <div class="table-responsive">
                                                 <asp:ListView ID="lstRequests" runat="server" OnPagePropertiesChanging="OnPagePropertiesChanging" OnItemCommand="lstRequests_ItemCommand" >
                                                 
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
                                                                 <asp:LinkButton Text='<%# Eval("Property") %>' runat="server" ID="Label3" CommandArgument='<%# Eval("intId")+"-"+Eval("varPersonneId")+"-"+Eval("intPersonelRole") %>' CommandName="viewprofile" /></td> 
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="Type" /></td>
                                                             <td>         <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                                 <td> <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="varStartDate" CssClass='<%# Eval("varStatus").ToString() == "Approved" ? "label label-success" :Eval("varStatus").ToString()=="Rejected"? "label label-danger":"label label-warning" %>' /></td>
                                                                 <td class="text-center"> <asp:LinkButton  ID="LinkButton2" CommandArgument='<%# Eval("intId")+"-"+Eval("varPersonneId")+"-"+Eval("intPersonelRole") %>' CommandName="UnApprove"  runat="server"  CssClass=" fa fa-exclamation-circle" style="color:#ff8f00"/>   
                                                             <td class="text-center"> <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId")+"-"+Eval("varPersonneId")+"-"+Eval("intPersonelRole") %>' CommandName="Approve"  runat="server"  CssClass=" fa fa-check" style="color:#558b2f"/></td>
                                                              <td class="text-center">  <asp:LinkButton  ID="LinkButton1" CommandArgument='<%# Eval("intId")+"-"+Eval("varPersonneId")+"-"+Eval("intPersonelRole") %>' CommandName="Reject"  runat="server"  CssClass=" fa fa-times" style="color:#ff0000"/>   
                                                           </td>
                                                             </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                                <th id="Th10" runat="server">Name</th>
                                                                             <th id="Th3" runat="server">Subject</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                                <th id="Th6" runat="server">Status</th> 
                                                                        
                                                                              <th colspan="3" id="Th1" runat="server" >Operation</th>
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
                          </div>
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstRequests" PageSize="10">
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
             <div class="tab-pane"  role="tabpanel"  id="Owner"> 
                     
			<div class="tab-pane active"  role="tabpanel"  id="UnApprovedNot"> 
                     <div class="col-lg-12"> 
            <div class="panel panel-info"> 
				<div class="panel-body no-padding  table-responsive"> 
                      <div class="table-responsive">
                                                 <asp:ListView ID="lstNoticeBoardUnapproved"  runat="server" OnPagePropertiesChanging="lstNoticeBoardUnapproved_PagePropertiesChanging" OnItemCommand="lstNoticeBoardUnapproved_ItemCommand" >
                                                 
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
                                                                 <asp:LinkButton Text='<%# Eval("Name") %>' runat="server" ID="Label3" CommandArgument='<%# Eval("intId") +"-"+   Eval("varPersonalId")+"-"+   Eval("intRole")%>' CommandName="viewprofile" /></td> 
                                                            <td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="Type" /></td>
                                                             <td>  <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                                  <td> <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="varStartDate" CssClass='<%# Eval("varStatus").ToString() == "Approved" ? "label label-success" :Eval("varStatus").ToString()=="Rejected"? "label label-danger":"label label-warning" %>' /></td>
                                                              
                                                           
                                                             <td class="text-center">  <asp:LinkButton  ID="lnklixtunapprv" CommandArgument='<%# Eval("intId") +"-"+   Eval("varPersonalId")+"-"+   Eval("intRole")%>' CommandName="UnApprove"  runat="server"  CssClass=" fa fa-exclamation-circle" style="color:#ff8f00" ToolTip="Pending"/>  </td>
                                                          <td class="text-center"> <asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") +"-"+   Eval("varPersonalId")+"-"+   Eval("intRole") %>' CommandName="Approve"  runat="server"  CssClass=" fa fa-check" style="color:#558b2f" ToolTip="Approve"/></td>
                                                           <td class="text-center">  <asp:LinkButton  ID="llnklistreje" CommandArgument='<%# Eval("intId") +"-"+   Eval("varPersonalId")+"-"+   Eval("intRole") %>' CommandName="Reject"  runat="server"  CssClass=" fa fa-times" style="color:#ff0000" ToolTip="Reject"/>   
                                                           </td>
                                                             </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                               <th id="Th10" runat="server">Name</th>
                                                                             <th id="Th3" runat="server">Subject</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                                <th id="Th6" runat="server">Status</th> 
                                                                           
                                                                              <th colspan="3" id="Th1" runat="server" >Operation</th>
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
                          </div>
  </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPagerNoticeBoardUnapproved" runat="server"  PagedControlID="lstNoticeBoardUnapproved" PageSize="10">
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
  	
<div class="tab-pane"  role="tabpanel"  id="Family">
                        <div class="tab-pane active"  role="tabpanel"  id="Div1"> 
                     <div class="col-lg-12"> 
                            <div id="DocSubTag" role="tabpanel">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
       <li class="active"><a aria-controls="Property" href="#Property" role="tab" data-toggle="tab">Property &nbsp;<i class="ti ti-dropbox-alt" style="color:#558b2f;"></i></a></li>
        <li><a href="#Employee" aria-controls="Employee" role="tab" data-toggle="tab">Employee &nbsp;<i class="fa fa-file-text"  style="color:#ba68c8;"></i></a></li>  
	</ul></div>   <br />
        <div class="tab-content">
                         <div class="tab-pane active"  role="tabpanel"  id="Property"> 
                     <div class="col-lg-12"> 
            <div class="panel panel-info"> 
				<div class="panel-body no-padding  table-responsive"> 
                      <div class="table-responsive">
                                                 <asp:ListView ID="lstDocument" runat="server" OnPagePropertiesChanging="lstDocument_PagePropertiesChanging" OnItemCommand="lstDocument_ItemCommand" >
                                                 
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
                                                             <td> <asp:LinkButton Text='<%# Eval("Name") %>' runat="server" ID="Label3"  CommandArgument='<%# Eval("intId")  +"-"+   Eval("varPersonnelId")+"-"+   Eval("intRoleId")%>' CommandName="viewprofile" /></td>
                                                              <td> <asp:Label Text='<%# Eval("varDocumentName") %>' runat="server" ID="Type" /></td>
                                                             <td>  <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                               <td>   <asp:Image ID="imgSimilarPic" runat="server" CssClass="fancybox" Height="50px" Width="50px"   ImageUrl='<%# "~/Society/Media/Documents/" + Eval("varDocument") %>' /> </td> 
                                                                  <td> <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="varStartDate" CssClass='<%# Eval("varStatus").ToString() == "Approved" ? "label label-success" :Eval("varStatus").ToString()=="Rejected"? "label label-danger":"label label-warning" %>' /></td>
                                                              
                                                             <td class="text-center">  <asp:LinkButton  ID="lnklistunapprvdoc" CommandArgument='<%# Eval("intId")  +"-"+   Eval("varPersonnelId")+"-"+   Eval("intRoleId")%>' CommandName="UnApprove"  runat="server"  CssClass=" fa fa-exclamation-circle" style="color:#ff8f00" ToolTip="Pending"/>  </td>
                                                          <td class="text-center"> <asp:LinkButton  ID="lnkListEditdoc" CommandArgument='<%# Eval("intId")  +"-"+   Eval("varPersonnelId")+"-"+   Eval("intRoleId")%>' CommandName="Approve"  runat="server"  CssClass=" fa fa-check" style="color:#558b2f" ToolTip="Approve"/></td>
                                                           <td class="text-center">  <asp:LinkButton  ID="llnklistrejedoc" CommandArgument='<%# Eval("intId")  +"-"+   Eval("varPersonnelId")+"-"+   Eval("intRoleId")%>' CommandName="Reject"  runat="server"  CssClass=" fa fa-times" style="color:#ff0000" ToolTip="Reject"/>   
                                                           </td>
                                                             </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                               <th id="Th8" runat="server">Uploader (Wing-Code-Name)</th>
                                                                             <th id="Th3" runat="server">Document</th>
                                                                             <th id="Th7" runat="server">Description</th>
                                                                             <th id="Th5" runat="server">Image</th>
                                                                                <th id="Th6" runat="server">Status</th> 
                                                                           
                                                                              <th colspan="3" id="Th1" runat="server" >Operation</th>
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
                          </div>
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
                       
                     <div class="col-lg-12"> 
            <div class="panel panel-info"> 
				<div class="panel-body no-padding  table-responsive"> 
                      <div class="table-responsive">
                                                 <asp:ListView ID="lstDocEmployee" runat="server" OnPagePropertiesChanging="lstDocEmployee_PagePropertiesChanging" OnItemCommand="lstDocEmployee_ItemCommand" >
                                                 
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
                                                             <td> <asp:Label Text='<%# Eval("varEmpName") %>' runat="server" ID="Label2" /></td>
                                                              <td> <asp:Label Text='<%# Eval("varDocumentName") %>' runat="server" ID="Type" /></td>
                                                             <td>  <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>
                                                               <td>   <asp:Image ID="imgSimilarPic" runat="server" CssClass="fancybox" Height="50px" Width="50px"   ImageUrl='<%# "~/Society/Media/Documents/" + Eval("varDocument") %>' /> </td> 
                                                                  <td> <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="varStartDate" CssClass='<%# Eval("varStatus").ToString() == "Approved" ? "label label-success" :Eval("varStatus").ToString()=="Rejected"? "label label-danger":"label label-warning" %>' /></td>
                                                              
                                                             <td class="text-center">  <asp:LinkButton  ID="lnklistunapprvdoc" CommandArgument='<%# Eval("intId") +"-"+   Eval("varPersonnelId")+"-"+   Eval("intRoleId")%>' CommandName="UnApprove"  runat="server"  CssClass=" fa fa-exclamation-circle" style="color:#ff8f00" ToolTip="Pending"/>  </td>
                                                          <td class="text-center"> <asp:LinkButton  ID="lnkListEditdoc" CommandArgument='<%# Eval("intId") +"-"+   Eval("varPersonnelId")+"-"+   Eval("intRoleId")%>' CommandName="Approve"  runat="server"  CssClass=" fa fa-check" style="color:#558b2f" ToolTip="Approve"/></td>
                                                           <td class="text-center">  <asp:LinkButton  ID="llnklistrejedoc" CommandArgument='<%# Eval("intId")+"-"+   Eval("varPersonnelId")+"-"+   Eval("intRoleId") %>' CommandName="Reject"  runat="server"  CssClass=" fa fa-times" style="color:#ff0000" ToolTip="Reject"/>   
                                                           </td>
                                                             </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                               <th id="Th9" runat="server">Uploader</th>
                                                                             <th id="Th3" runat="server">Document</th>
                                                                             <th id="Th7" runat="server">Description</th>
                                                                             <th id="Th5" runat="server">Image</th>
                                                                                <th id="Th6" runat="server">Status</th> 
                                                                           
                                                                              <th colspan="3" id="Th1" runat="server" >Operation</th>
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
                          </div>
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
