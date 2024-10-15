<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="ViewEnquiry.aspx.cs" Inherits="SK_View_ViewEnquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="row">
        <div class="col-lg-12 ">
			<div class="panel panel-info"  data-widget='{"id" : "wiget1", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View Enquiry</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body no-padding  table-responsive">
                                                     
                                                 <asp:ListView ID="lstType"  runat="server" OnPagePropertiesChanging="OnPagePropertiesChanging"   >
                                                 
                                                       <EmptyDataTemplate>
                                                         <table id="Table1" runat="server"  style="width:90%" CssClass="table table-bordered table-hover">
                                                             <tr >
                                                               <td  >
                                                                 	<div class="alert alert-dismissable alert-info "  style="width:100%" >
						                                                <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Enquiry Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                </div>
                                                               </td>
                                                              </tr>
                                                         </table>
                                                     </EmptyDataTemplate>
                                                     
                                                     <ItemTemplate>
                                                         <tr style="">
                                                            
                                                               <td>  <asp:Label ID="lblSRNO" runat="server"  Text='<%#Container.DataItemIndex+1 %>'></asp:Label></td>
                                                         <td> <asp:Label Text='<%# Eval("createdDate") %>' runat="server" ID="Label4" /></td>
                                                       <td>  <asp:Label Text='<%# Eval("varName") %>' runat="server" ID="Type" /></td>
                                                        <td> <asp:Label Text='<%# Eval("varMobile") %>' runat="server" ID="Label3" /></td>
                                                             <td>    <asp:Label Text='<%# Eval("varEmail") %>' runat="server" ID="Description"  /></td>

                                                             <td>   <asp:Label Text='<%# Eval("varServiceName") %>' runat="server" ID="Label1" /></td>
                                                               <td>    <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Label2" CssClass="comment more" /></td>
                                            
                                                            <td>   <asp:Image ID="imgadhar" runat="server" CssClass="fancybox" Height="50px" Width="50px"   ImageUrl='<%# "~/Services/Enquirydoc/" + Eval("adhar") %>' /> </td> </td>
                                                        <td>   <asp:Image ID="imgpan" runat="server" CssClass="fancybox" Height="50px" Width="50px"   ImageUrl='<%# "~/Services/Enquirydoc/" + Eval("pan") %>' /> </td> </td>
                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                               <th id="Th9" runat="server"> Date</th>
                                                                             <th id="Th3" runat="server"> Name</th>
                                                                               <th id="Th1" runat="server"> Mobile</th>
                                                                              <th id="Th10" runat="server"> Email</th>
                                                                              <th id="Th11" runat="server"> Service</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                             
                                                                                <th id="Th7" runat="server">Adhar Card</th>
                                                                            
                                                                             <th id="Th5" runat="server">PAN Card</th>
                                                                             
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





