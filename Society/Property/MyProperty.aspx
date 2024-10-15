<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Property.master" AutoEventWireup="true" CodeFile="MyProperty.aspx.cs" Inherits="Society_Property_MyProperty" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
 
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <asp:HiddenField ID="TabName" runat="server" />
                    <script type="text/javascript">
                        $(function () {
                            var tabName = $("[id*=ContentPlaceHolder1_TabName]").val() != "" ? $("[id*=ContentPlaceHolder1_TabName]").val() : "Owner";
                            $('#Tabs a[href="#' + tabName + '"]').tab('show');
                            $("#Tabs a").click(function () {
                                $("[id*=ContentPlaceHolder1_TabName]").val($(this).attr("href").replace("#", ""));
                            });
                        });

                        $(document).ready(function () {

                            $('#ContentPlaceHolder1_txtFamilyAlternateMobile').keyup(function () {
                                var el = $(this),
                                    val = el.val();

                                el.val(val.replace(/[^\d\;]/gi, ""));
                            }).blur(function () {
                                $(this).keyup();
                            });
                        });
</script>

     <div class="panel panel-default"  >
           
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
    <%--    <li class="active"><a aria-controls="Flat" href="#Flat" role="tab" data-toggle="tab">Flat &nbsp;<i class="fa fa-home" style="color:#558b2f;"></i></a></li>--%>
        <li  class="active"><a href="#Owner" aria-controls="Owner" role="tab" data-toggle="tab">Owner &nbsp;<i class="fa fa-user"  style="color:#ba68c8;"></i></a></li>
           <li><a href="#Flat" aria-controls="Flat" role="tab" data-toggle="tab">Property&nbsp; <i class="fa fa-building-o"  style="color:#ff0000;"></i></a></li>    
		<li><a href="#Parking" aria-controls="Parking" role="tab" data-toggle="tab">Parking &nbsp;<i class="fa fa-car"  style="color:#0277bd;"></i></a></li>  
        <li><a href="#Family" aria-controls="Family" role="tab" data-toggle="tab">Family/People&nbsp; <i class="fa fa-users"  style="color:#ff8f00;"></i></a></li>  
	   </ul>
    <!-- Tab panes -->
    
    </div>
        <br />
        <div class="tab-content ">
				<%--<div class="tab-pane active"  role="tabpanel"  id="Flat"> 
                        	<div class="panel-body">
                                      
                              </div>
                    </div>--%>
             <div class="tab-pane active"  role="tabpanel"  id="Owner"> 
                         <div class="panel-body">
                             <div class="col-lg-6">
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
										                                                   <asp:TextBox ID="txtflatno" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control" required="required"></asp:TextBox>
									                                            </div>									
								                                            </div>
                                                   <div class="form-group">
									    <label for="focusedinput" class="col-sm-4   control-label">Extension Number</label>
									    <div class="col-sm-8">
										           <asp:TextBox ID="txtPropertyExtensionNumber" required="required" onkeyup="checkTextNum(this);" runat="server" CssClass="form-control"></asp:TextBox>
									    </div>									
								    </div>
                                                 </div>
                                           </div>
                             </div>
                                <div class="col-lg-6">
					                <div  class="form-horizontal">
                                           <div class="form-group text-center">
						      	                <h4>Owner Information</h4>
                                            </div>
                                             <div class="form-group">
									                <label for="focusedinput" class="col-sm-4   control-label">Owner Name</label>
									                <div class="col-sm-8">
										                       <asp:TextBox ID="txtowner" onkeyup="checkText(this);" runat="server" CssClass="form-control" required="required"></asp:TextBox>
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
										                           <asp:TextBox ID="txtAltMobileNos" runat="server" CssClass="form-control"   onkeyup="checkOtherMobWithSemicolon(this);"   placeholder="Alternate Mobile Numbers Seprated By ';'"  ></asp:TextBox>
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
										                           <asp:TextBox ID="txtAltEmailIds" runat="server" CssClass="form-control"    onblur="validateMultipleEmailsCommaSeparated(this,';');"></asp:TextBox>
                                                                                                     <small>(Ex.mail@example.com;myname@mydomain.com)</small>
									                    </div>									
								                    </div>                        	
							
                                             <div class="form-group">
									                <div class="col-sm-4  "></div>
									                <div class="col-sm-8">
							                 <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update"   OnClick="btnUpdate_Click"/>
                     		                <%--   <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />--%>
                                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="MyProperty.aspx" >Reset</a>
									                </div>
								                </div>                         
                                        </div>  
                                   </div>
                             
					</div>
				</div>
  	<div class="tab-pane"  role="tabpanel"  id="Parking">
             <div class="panel-body">
                    <div  class="form-horizontal"> 
                             <div class="col-lg-6">
                              
                                     <div class="form-group text-center">
						      	        <h4>Vehical Information</h4>
                                   
                                    </div>
                                  <div class="form-group">
									    <label for="focusedinput" class="col-sm-4   control-label">Parking Slot</label>
									    <div class="col-sm-8">
										           <asp:TextBox ID="txtVehicalParkingNumber" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
									    </div>									
								    </div> <div class="form-group">
									    <label for="focusedinput" class="col-sm-4   control-label">Vehical Type</label>
									    <div class="col-sm-8">
										           <asp:TextBox ID="txtVehicalType" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control"></asp:TextBox>
									    </div>									
								    </div>
                                  <div class="form-group">
									    <label for="focusedinput" class="col-sm-4   control-label">Vehical Name</label>
									    <div class="col-sm-8">
										           <asp:TextBox ID="txtVehicalNAme" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control"></asp:TextBox>
									    </div>									
								    </div>
                                 
                                 
                                  <div class="form-group">
									    <label for="focusedinput" class="col-sm-4   control-label">Vehical Number</label>
									    <div class="col-sm-8">
										           <asp:TextBox ID="txtVehicalNumber" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control"></asp:TextBox>
									    </div>									
								    </div>
                                  <div class="form-group">
									    <label for="focusedinput" class="col-sm-4   control-label">Vehical Colour</label>
									    <div class="col-sm-8">
										           <asp:TextBox ID="txtVehicalColour" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control"></asp:TextBox>
									    </div>									
								    </div>
                                  	<div id="Div1" class="form-group"  runat="server" visible="false">
                                		<div class="col-sm-4  "></div>	
									<div class="col-sm-8">
									<label class="checkbox-inline">	  <asp:CheckBox ID="chkVehicalActive" runat="server"  /> Is Active 	 </label>
									</div>
                                </div>
                                     <div class="form-group">
									<div class="col-sm-4  "></div>
									<div class="col-sm-8">
								 <asp:Button ID="btnUpdateVehical"  runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update"   OnClick="btnUpdateVehical_Click"/>
                     
                        <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="MyProperty.aspx" >Reset</a>
									</div>
								</div>
                     </div>
                        <div class="col-md-6 ">
			<div class="panel panel-info" >
			<div class="panel-heading">
				<h2>View</h2>
					
			</div>
				<div class="panel-body no-padding  table-responsive">
                                                     
                                                 <asp:ListView ID="lstVehicalType" runat="server" OnPagePropertiesChanging="lstVehicalType_PagePropertiesChanging" OnItemCommand="lstVehicalType_ItemCommand" >
                                                 
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
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("Owner") %>' runat="server" ID="varMobile" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("Slot") %>' runat="server" ID="Id" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("VehName") %>' runat="server" ID="Type" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("VehNum") %>' runat="server" ID="Description" /></td>
                                                              
                                                                    <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                            
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
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
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                                                     <asp:DataPager ID="DataPagerVehical" runat="server"  PagedControlID="lstVehicalType" PageSize="10">
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
<div class="tab-pane"  role="tabpanel"  id="Family">
                                          
                                              <div class="panel-body">
                                                      <div class="col-lg-6">
					<div  class="form-horizontal"> 
                    <div class="form-group text-center">
						      	<h4>Family / Peoples Information</h4>
                            </div>
                             <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Name</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtFamilyName" runat="server" CssClass="form-control"  onkeyup="checkText(this);"></asp:TextBox>
									</div>									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">     Gender</label>
                                                      
									<div class="col-sm-8">
										 <asp:RadioButton ID="rgbMale" runat="server" Text="Male" CssClass="radio-inline" GroupName="g"/> &nbsp;&nbsp;
                                             <asp:RadioButton ID="rgbFemale" runat="server" CssClass="radio-inline" GroupName="g" Text="Female"/>
                                                
									</div>
									
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Occupation</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtOccupation" runat="server" CssClass="form-control"  onkeyup="checkText(this);"></asp:TextBox>
									</div>									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Age</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtfamilyage" runat="server" CssClass="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')"></asp:TextBox>
									</div>									
								</div>
                             <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Alternate Address</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtAlternateAddress" runat="server" CssClass="form-control"  onkeyup="checkTextNum(this);"></asp:TextBox>
									</div>									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Mobile Number</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtFamilyMobile" runat="server" CssClass="form-control" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" MaxLength="12"></asp:TextBox>
									</div>									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> Other Mobile Numbers</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtFamilyAlternateMobile" runat="server" onkeyup="checkOtherMobWithSemicolon(this);" CssClass="form-control"    ></asp:TextBox>
                                         <small>(Ex. 999999999;88888888;77777777)</small>
									</div>									
								</div>
               <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Email-Id</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtFamilyEmail" runat="server" CssClass="form-control" pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
									</div>									
								</div>   
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Other Email-Ids</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtFamilyAlternateEmail" runat="server" CssClass="form-control"   onblur="validateMultipleEmailsCommaSeparated(this,';');"  ></asp:TextBox>
                                         <small>(Ex.mail@example.com;myname@mydomain.com)</small>
									</div>									
								</div>
                        	<div class="form-group"  runat="server" visible="false">
                                		<div class="col-sm-4  "></div>	
									<div class="col-sm-8">
									<label class="checkbox-inline">	  <asp:CheckBox ID="chkIsActive" runat="server"  /> Is Active 	 </label>
									</div>
                                </div>
							
                        <div class="form-group">
									<div class="col-sm-4  "></div>
									<div class="col-sm-8">
								 <asp:Button ID="btnUpdateFamily" Visible="false" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update"   OnClick="btnUpdateFamily_Click"/>
                     	 <asp:Button ID="btnSubmitFamily" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmitFamily_Click"  />
                        <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="MyProperty.aspx" >Reset</a>
									</div>
								</div>
                         
                        
				
                        </div>
                                                          </div> 
                                                <div class="col-md-6 ">
			<div class="panel panel-info" >
			<div class="panel-heading">
				<h2>View</h2>
						
			</div>
				<div class="panel-body no-padding  table-responsive">
                                                     
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
                                                                 <asp:Label Text='<%# Eval("varName") %>' runat="server" ID="Type" /></td>
                                                             <td>
                                                                 <asp:Label Text='<%# Eval("varGender") %>' runat="server" ID="Description" /></td>
                                                               <td>
                                                                 <asp:Label Text='<%# Eval("varAge") %>' runat="server" ID="varMobile" /></td>
                                                       <%--       <td> <asp:Label Text='<%# Eval("intIsActive") %>' runat="server" ID="IsActive" /></td>--%>
                                                           <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit" ToolTip="Edit"/></td>
                                                                 <td><asp:LinkButton  ID="lnkFamilyDelete" CommandArgument='<%# Eval("intId") %>' CommandName="Delets"  runat="server"  CssClass=" fa fa-times" ToolTip="Delete"/></td>
                                                            
                                                             
                                                             
                                                         </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                             <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Name</th>
                                                                             <th id="Th4" runat="server">Gender</th>
                                                                              <th id="Th6" runat="server">Age</th>
                                                                           <%--  <th id="Th5" runat="server">IsActive</th>--%>
                                                                              <th id="Th1" runat="server" colspan="2" >Operation</th>
                                                                       
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
                                                        
</div>
            <div class="tab-pane"  role="tabpanel"  id="Flat">
                                          
                                              <div class="panel-body">
                                                      <div class="col-lg-6">
					<div  class="form-horizontal"> 
                    <div class="form-group text-center">
						      	<h4>Property Information</h4>
                            </div>
                           <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Date Of Purchase</label>                                             
									<div class="col-sm-8">
                                                        <asp:TextBox ID="txtDOB"  data-plugin-datepicker="data-plugin-datepicker" runat="server"  CssClass="form-control"></asp:TextBox>	
										 </div>
								</div>
                             <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Flat Area</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtFlatArea" runat="server" CssClass="form-control"></asp:TextBox>
									</div>									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label"> IsRenovated</label>
                                                      
									<div class="col-sm-8">
									       <asp:TextBox ID="txtfrenovated" runat="server" CssClass="form-control"  onkeyup="checkTextNum(this);" TextMode="MultiLine"></asp:TextBox>   
									</div>
									
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Costing</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtfcost" runat="server" CssClass="form-control" onkeyup="checkDec(this);"></asp:TextBox>
									</div>									
								</div>
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-4   control-label">Currency</label>
									<div class="col-sm-8">
										       <asp:TextBox ID="txtfcurrency" runat="server" CssClass="form-control"   onkeyup="checkTextNum(this);"></asp:TextBox>
									</div>									
								</div>
                    
							
                        <div class="form-group">
									<div class="col-sm-4  "></div>
									<div class="col-sm-8">
								
                     	 <asp:Button ID="btnsubmitFlat" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnsubmitFlat_Click"  />
                        <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="MyProperty.aspx" >Reset</a>
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

