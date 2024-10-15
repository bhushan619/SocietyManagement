<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="ViewClassified.aspx.cs" Inherits="SK_View_ViewClassified" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <div class="row">
        <div class="col-lg-12 ">
			<div class="panel panel-info"  data-widget='{"id" : "wiget1", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View Classified</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body no-padding  table-responsive">
                                                     
                                                 <asp:ListView ID="lstType"  runat="server" OnPagePropertiesChanging="OnPagePropertiesChanging"  OnItemCommand="lstType_ItemCommand" >
                                                 
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
                                                         <tr style="">
                                                            
                                                               <td>  <asp:Label ID="lblSRNO" runat="server"  Text='<%#Container.DataItemIndex+1 %>'></asp:Label></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="Type" /></td>
                                                                 <td>
                                                                 <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="Label3" /></td>
                                                             <td>         <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Description" CssClass="comment more" /></td>

                                                             <td>         <asp:Label Text='<%# Eval("varCreatedDate") %>' runat="server" ID="Label1" /></td>
                                            
                                                          
                                                        <td>   <asp:Image ID="imgSimilarPicClassified" runat="server" CssClass="fancybox" Height="50px" Width="50px"   ImageUrl='<%# "~/Society/Media/Classified/" + Eval("varClassifiedImage") %>' /> </td> </td>
                                               <td> <asp:Label Text='<%# Eval("status") %>' runat="server" ID="varStartDate" CssClass='<%# Eval("status").ToString() == "Approve" ? "label label-success" :Eval("status").ToString()=="Reject"? "label label-danger":"label label-warning" %>' /></td>
                                                              
                                                               <td class="text-center">  <asp:LinkButton  ID="lnklistnew" CommandArgument='<%# Eval("intId")%>' CommandName="Approve"  runat="server"   CssClass=" fa fa-check" style="color:#558b2f" ToolTip="Approve"/>  </td>
                                                   <td class="text-center">  <asp:LinkButton  ID="lnkreject" CommandArgument='<%# Eval("intId")%>' CommandName="Reject"  runat="server"  CssClass=" fa fa-times" style="color:#ff0000"  ToolTip="Reject"/>  </td>
                                                      <td  class="text-center"><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Views"  runat="server"  ToolTip="View Full Details" CssClass=" fa fa-2x fa-eye"/></td>
                                                            
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server"> Name</th>
                                                                               <th id="Th1" runat="server"> Title</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                             
                                                                                <th id="Th7" runat="server">Date</th>
                                                                            
                                                                             <th id="Th5" runat="server">Image</th>
                                                                               <th id="Th6" runat="server">Status</th>
                                                                                  <th id="Th8" runat="server" colspan="3">Operation</th>
                                                                       
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
</asp:Content>





