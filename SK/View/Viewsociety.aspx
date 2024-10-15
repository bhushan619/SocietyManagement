<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="Viewsociety.aspx.cs" Inherits="SK_View_Viewsociety" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="row">
		
        <div class="col-md-12 ">
			<div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View Societies</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body  table-responsive">
                      <div class="row">
                                                <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>      
                                              <asp:ListView ID="lstSocietyList" runat="server" OnItemCommand="lstSocietyList_ItemCommand" OnPagePropertiesChanging="OnPagePropertiesChanging" >
                                                 
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
                                                             <td> <asp:Label Text='<%# Eval("varName") %>' runat="server" ID="varName" /></td>
                                                             <td>  <asp:Label Text='<%# Eval("varSAddress") %>' runat="server" ID="varSAddress" /></td>

                                                             <td>  <asp:Label Text='<%# Eval("varSEmail") %>' runat="server" ID="varSEmail" /></td>
                                                              <td>  <asp:Label Text='<%# Eval("varContactPerson") %>' runat="server" ID="varContactPerson" /></td>
                                                                <td>  <asp:Label Text='<%# Eval("varContactMobile") %>' runat="server" ID="varContactMobile" /></td>
                                                                <td> <asp:Label Text='<%# Eval("varIsActive").ToString() == "1" ? "ACTIVE" :Eval("varIsActive").ToString()=="0"? "INACTIVE":"label label-warning" %>' runat="server" ID="varStartDate" CssClass='<%# Eval("varIsActive").ToString() == "1" ? "label label-success" :Eval("varIsActive").ToString()=="0"? "label label-danger":"label label-warning" %>'  /></td>
                                  
                                                                <td  class="text-center"><asp:LinkButton  ID="lnkapprove" CommandArgument='<%# Eval("intId") +":"+Eval("intSocietyCode") %>' CommandName="Approve"  runat="server"  ToolTip="Approve" CssClass=" fa  fa-check"  style="color:#558b2f"/></td>
                                                                <td  class="text-center"><asp:LinkButton  ID="lnkreject" CommandArgument='<%# Eval("intId") +":"+Eval("intSocietyCode") %>' CommandName="Reject"  runat="server"  ToolTip="Reject" CssClass=" fa  fa-times " style="color:#ff0000" /></td>
                                                               <td  class="text-center"><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") +":"+Eval("intSocietyCode") %>' CommandName="Views"  runat="server"  ToolTip="View Full Details" CssClass=" fa  fa-eye"/></td>
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            <%-- <th id="Th1" runat="server" colspan="2">Operation</th>--%>
                                                                         <th id="Th1" runat="server">Id</th>
                                                                             <th id="Th5" runat="server">Society Name</th>
                                                                             <th id="Th2" runat="server">Address</th>
                                                                             <th id="Th3" runat="server">Email</th>
                                                                             <th id="Th4" runat="server">Contact  Person</th>
                                                                                <th id="Th6" runat="server">Mobile</th>
                                                                               <th id="Th8" runat="server">Status</th>
                                                                             <th id="Th7" runat="server" colspan="3">Operation</th>
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>                                                     
                                                 </asp:ListView>
  
                                         <div class="panel-footer">
                                             <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPager1" runat="server"  PagedControlID="lstSocietyList" PageSize="10">
                                                          <Fields  >
                                                           <asp:NextPreviousPagerField ButtonType="Link" ButtonCssClass="btn btn-primary btn-xs" ShowFirstPageButton="True" ShowPreviousPageButton="False"   FirstPageText="< First "      ShowNextPageButton="false" />
                                                              <asp:NumericPagerField ButtonType="Link"  />
                                                             <asp:NextPreviousPagerField ButtonType="Link" ButtonCssClass="btn btn-primary btn-xs" ShowNextPageButton="False" ShowLastPageButton="True" ShowPreviousPageButton = "false"  LastPageText=" Last >"/>
                                                      </Fields>
                                                          </asp:DataPager>
                                                     </div>
                                        </div>

				</div></div>
                </div>
            </div>
	</div>

</asp:Content>







