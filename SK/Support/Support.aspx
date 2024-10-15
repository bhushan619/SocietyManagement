<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="Support.aspx.cs" Inherits="SK_Support_Support" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
		<div class="col-md-5 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2> Support Information</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal"> 
                     
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> Name  </label>
									<div class="col-sm-8">
										 <asp:TextBox ID="txtName" onkeyup="checkTextNum(this);" runat="server" CssClass="form-control" required="required"></asp:TextBox>
									</div>
									
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label"> Username   </label>
									<div class="col-sm-8">
										 <asp:TextBox ID="txtuser" onkeyup="checkTextNum(this);" runat="server" CssClass="form-control" required="required"></asp:TextBox>
									</div>
									
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Mobile No.</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtsmobile" runat="server" CssClass="form-control" required="required" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12"></asp:TextBox>
									</div>
								</div>
                        	
                         	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Email Id</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtsemail" runat="server" CssClass="form-control"   required="required" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
									</div>
								</div>
                         	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Subject</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtsubject"   runat="server" CssClass="form-control"   required="required"></asp:TextBox>
									</div>
								</div>
                     <div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Description</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtDescription" TextMode="MultiLine"  runat="server" CssClass="form-control"   required="required"></asp:TextBox>
									</div>
								</div>


                        		
                        <div class="form-group">
									<div class="col-sm-3  "></div>
									<div class="col-sm-8">
									
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="Support.aspx" >Reset</a>
									</div>
								</div>
                          <div class="form-group"> 
                      <div id="divMessage" runat="server"><asp:Label id="lblMessage" runat="server" /></div>
                    </div>
					
					</div>
					
				</div>
			
			</div>
		</div> 
        <div class="col-md-7 ">
			<div class="panel panel-info"  data-widget='{"id" : "wiget1", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View Support</h2>
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
						                                                <i class="ti ti-info-alt"></i>&nbsp; <strong>Oops !!!&nbsp;&nbsp;</strong> No Data Found..... !!!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                                              	
					                                                </div>
                                                               </td>
                                                              </tr>
                                                         </table>
                                                     </EmptyDataTemplate>
                                                     
                                                     <ItemTemplate>
                                                         <tr style="">
                                                            
                                                               <td>  <asp:Label ID="lblSRNO" runat="server"  Text='<%#Container.DataItemIndex+1 %>'></asp:Label></td>
                                                             <td> <asp:Label Text='<%# Eval("varDate") %>' runat="server" ID="Type" /></td>
                                                              <td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="Label2" /></td>
                                                              <td> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Label4" /></td>

                                                                 <td> <asp:Label Text='<%# Eval("varName") %>' runat="server" ID="Label3" /></td>
                                                             <td>   <asp:Label Text='<%# Eval("varMobile") %>' runat="server" ID="Description" CssClass="comment more" /></td>

                                                            
                                                          
                                                   
                                               <td> <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="varStartDate" CssClass='<%# Eval("varStatus").ToString() == "Resolved" ? "label label-success" :"label label-danger" %>' /></td>
                                                              
                                                           
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                               <th id="Th9" runat="server">Date</th>
                                                                                <th id="Th1" runat="server"> Title</th>
                                                                             <th id="Th4" runat="server">Description</th>
                                                                             <th id="Th3" runat="server"> Name</th>                                                                            
                                                                             
                                                                                <th id="Th7" runat="server">Mobile</th>
                                                                             
                                                                                
                                                                               <th id="Th6" runat="server">Status</th>
                                                                           
                                                                       
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