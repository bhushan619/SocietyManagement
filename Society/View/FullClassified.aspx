<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="FullClassified.aspx.cs" Inherits="Society_View_FullClassified" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div class="row">
    <div class="col-md-12"  >
			<div class="panel panel-info"  data-widget='{"id" : "wiget2", "draggable": "false"}'>
			<div class="panel-heading">
				<h2>View Full Classified Details</h2>
				<div class="panel-ctrls button-icon" 
					data-actions-container="" 
					data-action-collapse='{"target": ".panel-body"}'
					data-action-colorpicker=''
					data-action-refresh-demo='{"type": "circular"}'
					>
				</div>				
			</div>
				<div class="panel-body   table-responsive">
                                                     
                    <asp:ListView ID="lstreply" runat="server" DataKeyNames="intId" >
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
                            <span class="table-responsive">   
                                <div class="col-lg-12">
                                    <div class="col-md-6">
                                        <asp:Image ID="imgSimilarPic" runat="server" CssClass="fancybox" Height="300px" Width="300px"   ImageUrl='<%# "~/Society/Media/Classified/" + Eval("varClassifiedImage	") %>' />
                                    </div>
                                    <div class="col-md-6">
                                        <table class="table">
                                   <tr>
                                       <td><strong>Advertiser</strong></td><td> <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /> </td>
                                   </tr> 
                                   <tr><td><strong>Heading</strong></td><td> <asp:Label Text='<%# Eval("varSubject") %>' runat="server" ID="varSubjectLabel" /></td></tr>
                                           <tr><td><strong>Mobile No.</strong></td><td> <asp:Label Text='<%# Eval("varMobile") %>' runat="server" ID="varMobileLabel" /></td></tr>
                                    <tr><td><strong>Description</strong></td><td> <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="Label1" /></td></tr>
                                     
                                             </table>
                                   
                               </table>
                                    </div>
                                </div>
                                   
                            </span>

                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                            <div style="">
                            </div>

                        </LayoutTemplate>
                         
                    </asp:ListView>
                  <asp:HyperLink ID="goBack" runat="server" NavigateUrl="~/Society/View/ViewClassified.aspx" CssClass="btn btn-primary  pull-right">BACK</asp:HyperLink>
                </div>
                
                </div>
            </div>
           </div>
</asp:Content>

