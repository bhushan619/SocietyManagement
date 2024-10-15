<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="AddSociety.aspx.cs" Inherits="SK_Society_AddSociety" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  
 <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2> Society Information</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal"> 
                        <div class="form-group"> 
									<label for="focusedinput" class="col-sm-3   control-label">Registration Number</label>
									<div class="col-sm-8">
										 <asp:TextBox ID="txtsRegistrationNo" onkeyup="checkTextNum(this);"  runat="server" CssClass="form-control"></asp:TextBox>
									</div>
									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Society Name  </label>
									<div class="col-sm-8">
										 <asp:TextBox ID="txtSocietyName" onkeyup="checkTextNum(this);" runat="server" CssClass="form-control" required="required"></asp:TextBox>
									</div>
									
								</div>
                        
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Phone Number</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtsphone" runat="server" CssClass="form-control"  onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12"></asp:TextBox>
									</div>
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Mobile Number</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtsmobile" runat="server" CssClass="form-control" required="required" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12"></asp:TextBox>
									</div>
								</div>
                       
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Country</label>
									<div class="col-sm-8">
										   <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>:: Select Country ::</asp:ListItem>                                                   
                                                </asp:DropDownList>
									</div>
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">state</label>
									<div class="col-sm-8">
										   <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>:: Select State ::</asp:ListItem>                                                   
                                                </asp:DropDownList>
									</div>
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">City</label>
									<div class="col-sm-8">
										 <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-control">
                                                    <asp:ListItem>:: Select City ::</asp:ListItem>                                                   
                                                </asp:DropDownList>
									</div>
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Address</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtSAddress" required="required" onkeyup="checkTextNum(this);" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
									</div>
								</div>
                         	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Email Id</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtsemail" runat="server" CssClass="form-control"   required="required" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
									</div>
								</div>
                         	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Password</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtspassword"  TextMode="Password" runat="server" CssClass="form-control"   required="required"></asp:TextBox>
									</div>
								</div>
                        <div class="about-area">
						      	<h4>Society Contact Person Information</h4>
                            </div>
                 	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Name</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtcpname" runat="server" onkeyup="checkText(this);" CssClass="form-control" required="required"></asp:TextBox>
									</div>
								</div>
                        <div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Phone Number</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtcpphone" runat="server" CssClass="form-control"  onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12"></asp:TextBox>
									</div>
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label"> Mobile  Number</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtcpmobile" runat="server" CssClass="form-control " required="required" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12"></asp:TextBox>
									</div>
								</div>
                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Email Id</label>
									<div class="col-sm-8">
										   <asp:TextBox ID="txtcpemail" runat="server" CssClass="form-control" required="required" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
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
									  <%--<asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" Visible="false"  OnClick="btnUpdate_Click"/>--%>
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddSociety.aspx" >Reset</a>
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
                                                     
                                              <asp:ListView ID="lstSocietyList" runat="server" OnPagePropertiesChanging="OnPagePropertiesChanging" >
                                                 
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
                                                           <%-- <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intServicetypeCode") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                               <td><asp:LinkButton  ID="lnkListDelet" CommandArgument='<%# Eval("intServicetypeCode") %>' CommandName="Delets"  runat="server"  CssClass=" fa fa-trash-o"/></td>
                                                           --%>
                                                              <td>  <asp:Label Text='<%# Eval("intId") %>' runat="server" ID="Id" /></td>
                                                             <td> <asp:Label Text='<%# Eval("varName") %>' runat="server" ID="varName" /></td>
                                                             <td>  <asp:Label Text='<%# Eval("varSAddress") %>' runat="server" ID="varSAddress" /></td>
                                                             <td>  <asp:Label Text='<%# Eval("varSEmail") %>' runat="server" ID="varSEmail" /></td>
                                                              <td>  <asp:Label Text='<%# Eval("varContactPerson") %>' runat="server" ID="varContactPerson" /></td>
                                                                <td>  <asp:Label Text='<%# Eval("varContactMobile") %>' runat="server" ID="varContactMobile" /></td>
                                                             
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
                                                                         </tr>
                                                                         <tr runat="server" id="itemPlaceholder"></tr>
                                                                     </table>
                                                     </LayoutTemplate>                                                     
                                                 </asp:ListView>
  </div>
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
                </div>
            </div>
	</div>

</asp:Content>






