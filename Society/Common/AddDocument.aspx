<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="AddDocument.aspx.cs" Inherits="Society_Common_AddDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>Document Information</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">
                      
                        <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Document Type</label>
									<div class="col-sm-8">
										 <asp:DropDownList ID="ddlDocumentType" runat="server" CssClass="form-control" required="required">
                                                    <asp:ListItem Value="">:: Select Document Type ::</asp:ListItem>                                                     
                                             </asp:DropDownList>
									</div>
									
								</div>

                        	<div class="form-group">
									<label for="inputPassword" class="col-sm-3   control-label">Description</label>
									<div class="col-sm-8">
										  <asp:TextBox ID="txtDescription" runat="server" onkeyup="checkTextNum(this);" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
									</div>
								</div>
                        	
                      
                          <div class="form-group">
									<label  for="inputPassword1" class=" col-sm-3 control-label">Document File</label>
									<div class="col-sm-5">
										      <input id="fupProPic" type="file" name="file" class="fileinput-new"  onchange="previewFile()"  runat="server" accept='image/*' />
                                         <br />
                                         <asp:Button ID="btnUpdate" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Update" Visible="false"  OnClick="btnUpdate_Click"/>
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="AddDocument.aspx" >Reset</a>
                                             </div> 	<div class="col-sm-4">
                                         <asp:Image ID="ImgProfile" CssClass="fileupload-preview thumbnail" style="width: 120px; height: 120px;float:none"  runat="server" ImageUrl="~/Society/Media/Documents/NoProfile.png" />
                                       </div>
								
								</div>
                         
                          <script type="text/javascript">
                              function previewFile() {

                                  var preview = document.querySelector('#<%=ImgProfile.ClientID %>');
                                            var file = document.querySelector('#<%=fupProPic.ClientID %>').files[0];
                                            var reader = new FileReader();

                                            reader.onloadend = function () {
                                                preview.src = reader.result;
                                            }

                                            if (file) {
                                                reader.readAsDataURL(file);
                                            } else {
                                                preview.src = "";
                                            }
                                        }
                              </script>
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
                                              
                                                             <td> <asp:Label Text='<%# Eval("Document") %>' runat="server" ID="varAccountHolderName" /></td>
                                                              <td>   <asp:Label Text='<%# Eval("varDescription") %>' runat="server" ID="varAccountNo" /></td> 
                                                            
                                                          <td>   <asp:Image ID="imgSimilarPic" runat="server" CssClass="fancybox" Height="50px" Width="50px"   ImageUrl='<%# "~/Society/Media/Documents/" + Eval("varDocument") %>' /> </td> 
                                                              <td> <asp:Label Text='<%# Eval("varStatus") %>' runat="server" ID="IsActive"  CssClass='<%# Eval("varStatus").ToString() == "Approved" ? "label label-success" :Eval("varStatus").ToString()=="Rejected"? "label label-danger":"label label-warning" %>' /></td>
                                                           <td><asp:LinkButton  ID="lnkListEdit" CommandArgument='<%# Eval("intId") %>' CommandName="Edits"  runat="server"  CssClass=" fa fa-edit"/></td>
                                                             <td><asp:LinkButton  ID="lnkListDelete" CommandArgument='<%# Eval("intId") %>' CommandName="Delets"  runat="server"  CssClass=" fa fa-times" ToolTip="Delete"/></td>
                                                             
                                                              </tr>
                                                     </ItemTemplate>
                                                     <LayoutTemplate>
                                                       
                                                                     <table runat="server" id="itemPlaceholderContainer" cellpadding="1" class="table table-bordered table-hover" >
                                                                         <tr id="Tr1" runat="server" class="info">
                                                                            
                                                                            <th id="Th2" runat="server">SrNo</th>
                                                                             <th id="Th3" runat="server">Document Name</th>
                                                                                 <th id="Th6" runat="server">Description</th>
                                                                           
                                                                                  <th id="Th7" runat="server">Image </th>                                                                                    
                                                                             <th id="Th5" runat="server">Status</th>
                                                                              <th id="Th1" runat="server"  colspan="2">Operation</th>                                                                       
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
 
        


