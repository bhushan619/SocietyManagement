<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="AssignParking.aspx.cs" Inherits="Society_Admin_Property_AssignParking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="row">
      <div class="col-md-12 ">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Assign Parking Information</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
                      <div runat="server" id="myproerty">
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Wing</label>
									<div class="col-sm-8">
										<asp:DropDownList ID="ddlWing"  runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlWing_SelectedIndexChanged"  required="required">
                               <asp:ListItem>:: Select  Wing ::</asp:ListItem>                                                      
                           </asp:DropDownList>
									</div>									
								</div>   
                           
                         <div class="form-group">
                             
									<label for="focusedinput" class="col-sm-4   control-label">Property Code</label>
                                                
									<div class="col-sm-8">
										   <asp:DropDownList ID="ddlPropertyCode"  AppendDataBoundItems="true" runat="server" CssClass="form-control"  required="required">
                               <asp:ListItem>:: Select Property ::</asp:ListItem>                                                      
                           </asp:DropDownList>	</div>
									
								</div>  
                          <div class="form-group">
                             
									<label for="focusedinput" class="col-sm-4   control-label">Parking Level</label>
                                                
									<div class="col-sm-8">
										   <asp:DropDownList ID="ddlParkingLevel" AutoPostBack="true" OnSelectedIndexChanged="ddlParkingLevel_SelectedIndexChanged" runat="server" CssClass="form-control"  required="required">
                               <asp:ListItem>:: Select Parking Level ::</asp:ListItem>                                                      
                           </asp:DropDownList>	</div>
									
								</div>

                          	<div class="form-group">
									<label for="inputPassword" class="col-sm-4   control-label">Parking Slots</label>
									<div class="col-sm-8"> 
										<select id="ddlParkingSlots" placeholder= ":: Select Parking Slots ::"  multiple="true" style="width:100% !important"   runat="server"   >
                                         </select> 
									</div>
								</div>
                        	 
                        	<div class="form-group">
                                		<div class="col-sm-4  "></div>	
									<div class="col-sm-8">
									<label class="checkbox-inline">	  <asp:CheckBox ID="chkIsActive" runat="server"  /> Is Active 	 </label>
									</div>
                                </div>
							
                        <div class="form-group">
									<div class="col-sm-4  "></div>
									<div class="col-sm-8">
									   
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AssignParking.aspx" >Reset</a>
									</div>
								</div>
                         
                          <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
					
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
                                                    <div class="table-responsive">   
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
                                                               <td>  <asp:Label ID="lblSRNO" runat="server"  Text='<%#Container.DataItemIndex+1 %>'></asp:Label></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("Owner") %>' runat="server" ID="varMobile" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("Slot") %>' runat="server" ID="Id" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("VehName") %>' runat="server" ID="Type" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("VehNum") %>' runat="server" ID="Description" /></td>
                                                              
                                                                    <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("SlotId") %>' CommandName="Deletes"  runat="server"  CssClass=" fa fa-times"/></td>
                                                            
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            <th id="th5" runat="server">SrNo </th>
                                                                             <th id="Th2" runat="server">Owner</th>
                                                                             <th id="Th3" runat="server">Slot</th>
                                                                             <th id="Th4" runat="server">Veh. Name</th>
                                                                              <th id="Th6" runat="server">Veh. Num</th> 
                                                                              <th id="Th1" runat="server" >Operation</th>
                                                                       
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>
                                                     
                                                 </asp:ListView>
                                                        </div>
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
      </div>
</asp:Content>
 

