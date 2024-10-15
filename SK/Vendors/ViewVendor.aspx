<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SKAdminMaster.master" AutoEventWireup="true" CodeFile="ViewVendor.aspx.cs" Inherits="SK_Vendors_ViewVendor" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-md-12 ">
			<div class="panel panel-info"  data-widget='{"id" : "wiget7", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View Vendors Information</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body   table-responsive"> 
                   <div class="row" id="divnamesearch" runat="server"> 
                                <div class="col-lg-3 col-sm-3"></div>  
                                         <div class="col-lg-5 col-sm-3">
                                           <div class="form-group">                                              
                                               <asp:TextBox ID="txtVendorName" placeholder="Enter Vendor Name"   runat="server"  CssClass="form-control"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="txtVendorName_AutoCompleteExtender" runat="server" 
                                            MinimumPrefixLength="1" CompletionInterval="1" 
                                            EnableCaching="true"
                                               DelimiterCharacters=""
                                                Enabled="True" 
                                                ServiceMethod="GetCompletionList" 
                                                CompletionSetCount="1" 
                                                TargetControlID="txtVendorName" UseContextKey="True">
                                           </cc1:AutoCompleteExtender>
                                               <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                             </div> 
                                         </div>
                                <div class="col-lg-3 col-sm-3">
                            <div class="form-group">
                                <asp:Button ID="btnNamesearch" runat="server" Text="Search"  OnClick="btnNamesearch_Click" CssClass="btn btn-primary"/>
                                 <a href="ViewVendor.aspx"  class="btn btn-danger">Reset</a>
                            </div>
                                </div>
                          </div>
                       <div class="row" id="divservicesearch" runat="server" visible="false"> 
                                <div class="col-lg-3 col-sm-3"></div>  
                                     <div class="col-lg-5 col-sm-3">
                                           <div class="form-group">                                              
                                               <asp:TextBox ID="txtservice" placeholder="Enter Service Name"   runat="server"  CssClass="form-control"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" 
                                            MinimumPrefixLength="1" CompletionInterval="1" 
                                            EnableCaching="true"
                                               DelimiterCharacters=""
                                                Enabled="True" 
                                                ServiceMethod="GetCompletionListService" 
                                                CompletionSetCount="1" 
                                                TargetControlID="txtservice" UseContextKey="True">
                                           </cc1:AutoCompleteExtender>
                                               
                                             </div> 
                                    </div>
                                <div class="col-lg-3 col-sm-3">
                                        <div class="form-group">
                                            <asp:Button ID="btnservice" runat="server" Text="Search"  OnClick="btnservice_Click" CssClass="btn btn-primary"/>
                                             <a href="ViewVendor.aspx"  class="btn btn-danger">Reset</a>
                                        </div>
                                </div>
                          </div>
                      <div class="row" id="divCity" runat="server" visible="false"> 
                                <div class="col-lg-3 col-sm-3"></div>  
                                     <div class="col-lg-5 col-sm-3">
                                           <div class="form-group">                                              
                                               <asp:TextBox ID="txtcity" placeholder="Enter city Name"   runat="server"  CssClass="form-control"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" 
                                            MinimumPrefixLength="1" CompletionInterval="1" 
                                            EnableCaching="true"
                                               DelimiterCharacters=""
                                                Enabled="True" 
                                                ServiceMethod="GetCompletionListCity" 
                                                CompletionSetCount="1" 
                                                TargetControlID="txtcity" UseContextKey="True">
                                           </cc1:AutoCompleteExtender>
                                               
                                             </div> 
                                    </div>
                                <div class="col-lg-3 col-sm-3">
                                        <div class="form-group">
                                            <asp:Button ID="btncity" runat="server" Text="Search"  OnClick="btncity_Click" CssClass="btn btn-primary"/>
                                             <a href="ViewVendor.aspx"  class="btn btn-danger">Reset</a>
                                        </div>
                                </div>
                          </div>
                        <div class="row" id="divRating" runat="server" visible="false"> 
                                <div class="col-lg-3 col-sm-3"></div>  
                                     <div class="col-lg-5 col-sm-3">
                                          <asp:DropDownList ID="ddlRating" runat="server" required="required" CssClass="form-control">
                                    <asp:ListItem Value="">:: Select Rating ::</asp:ListItem>
                                       <asp:ListItem Value="1"> Bad  </asp:ListItem>
                                       <asp:ListItem Value="2"> Fair </asp:ListItem>
                                       <asp:ListItem Value="3"> Good </asp:ListItem>
                                       <asp:ListItem Value="4"> Very good </asp:ListItem>
                                       <asp:ListItem Value="5"> Excellent </asp:ListItem>                            
                                    </asp:DropDownList>
                                         </div>
                              <div class="col-lg-3 col-sm-3">
                                        <div class="form-group">
                                            <asp:Button ID="btnRating" runat="server" Text="Search"  OnClick="btnRating_Click" CssClass="btn btn-primary"/>
                                             <a href="ViewVendor.aspx"  class="btn btn-danger">Reset</a>
                                        </div>
                                </div>
                            </div>
                    
                      <div class="row"> 
                                <div class="col-lg-3"></div>
                                <div class="col-lg-8 col-sm-6">
                                    <asp:RadioButton ID="rgbName"  OnCheckedChanged="rgbName_CheckedChanged" AutoPostBack="true" runat="server" Text="By Name" CssClass="radio-inline" GroupName="g"/>
                                       <asp:RadioButton ID="rgbservice" OnCheckedChanged="rgbName_CheckedChanged" AutoPostBack="true" runat="server" Text="By Service" CssClass="radio-inline" GroupName="g"/>
                                       <asp:RadioButton ID="rgblocation"  OnCheckedChanged="rgbName_CheckedChanged" runat="server" AutoPostBack="true" CssClass="radio-inline" Text="By City" GroupName="g"/> 
                                        <asp:RadioButton ID="rgball" OnCheckedChanged="rgbName_CheckedChanged" runat="server" AutoPostBack="true" CssClass="radio-inline" Text="All" GroupName="g"/>
                                     <asp:RadioButton ID="rgbrating" OnCheckedChanged="rgbName_CheckedChanged" runat="server" AutoPostBack="true" CssClass="radio-inline" Text="Rating" GroupName="g"/>
				                    </div>
                         </div>
                     <div class="row">
                    <asp:ListView ID="lstVendors" runat="server" OnItemCommand="lstVendors_ItemCommand" OnPagePropertiesChanging="OnPagePropertiesChanging" DataKeyNames="intId">

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
                                    <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("[Contact Person]") %>' runat="server" ID="Contact_PersonLabel" /></td>
                                          <td>
                                    <asp:Label Text='<%# Eval("[Service Name]") %>' runat="server" ID="Service_NameLabel" /></td>
                                 <td>
                                    <asp:Label Text='<%# Eval("[Ph no]") %>' runat="server" ID="Ph_noLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("Mobile") %>' runat="server" ID="MobileLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel" /></td>
                                <td>
                            <asp:Label Text='<%# Eval("StateName") %>' runat="server" ID="StateNameLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("CityName") %>' runat="server" ID="CityNameLabel" /></td>
                               <td> <asp:Label Text='<%# Eval("varIsActive").ToString() == "1" ? "ACTIVE" :Eval("varIsActive").ToString()=="0"? "INACTIVE":"label label-warning" %>' runat="server" ID="varStartDate" CssClass='<%# Eval("varIsActive").ToString() == "1" ? "label label-success" :Eval("varIsActive").ToString()=="0"? "label label-danger":"label label-warning" %>'  /></td>
                                                              
                                                               <td class="text-center">  <asp:LinkButton  ID="lnklistnew" CommandArgument='<%# Eval("intId")%>' CommandName="active"  runat="server"   CssClass=" fa fa-check" style="color:#558b2f" ToolTip="Active"/>  </td>
                                                   <td class="text-center">  <asp:LinkButton  ID="lnkreject" CommandArgument='<%# Eval("intId")%>' CommandName="inactive"  runat="server"  CssClass=" fa fa-times" style="color:#ff0000"  ToolTip="Inactive"/>  </td>
                                                      <td  class="text-center"><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Views"  runat="server"  ToolTip="View Full Details" CssClass=" fa fa-2x fa-eye"/></td>
                                                      
                                  </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                             
                                        <table runat="server" id="itemPlaceholderContainer" class="table table-bordered" style="" border="0">
                                            <tr runat="server" style="">
                                                <th runat="server">Name</th>
                                                <th runat="server">Contact Person</th> 
                                                <th runat="server">Service Name</th> 
                                                <th runat="server">Ph no</th>
                                                <th runat="server">Mobile</th>
                                                <th runat="server">Email</th>                                                  
                                                <th runat="server">StateName</th> 
                                                <th runat="server">CityName</th>
                                                 <th id="Th6" runat="server" >Isactive</th>
                             <th id="Th8" runat="server" colspan="3" >Operations</th>
                                            </tr>
                                            <tr runat="server" id="itemPlaceholder"></tr>
                                        </table>
                                     
                        </LayoutTemplate>

                         
                    </asp:ListView>
                     </div>

                </div>
                 <div class="panel-footer">
                     <div class="text-right">
                                                   
                     <asp:DataPager ID="DataPager1" runat="server" PagedControlID="lstVendors" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                            ShowNextPageButton="false" />
                        <asp:NumericPagerField ButtonType="Link" />
                        <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false" ShowPreviousPageButton = "false" />
                    </Fields>
                </asp:DataPager>
               </div>
                 </div>
                </div>
            </div>
 </div>
</asp:Content>

