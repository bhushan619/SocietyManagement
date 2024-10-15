<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GroupDiscussion.ascx.cs" Inherits="Society_UserControl_GroupDiscussion" %>
  <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                <asp:Panel ID="Panel1" runat="server">
             
                    
                          
		<div class="panel panel-success" >
			<div class="panel-heading">
				<h2>Group Discussion</h2>
			 
			</div>
			<div class="panel-body scroll-pane has-scrollbar" style="height: 360px;">
				<div class="scroll-content" tabindex="0" style="right: -17px;">
					
                        <asp:Button ID="LoadMore" runat="server" Width="100%" onclick="LoadMore_Click" 
        Text="Load More..."  CssClass="btn btn-primary" /> 
<ul class="mini-timeline">
    <br />
          <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
        ClientIDMode="Static">
        <ProgressTemplate>
            <b>Loading previous discussions....</b>
        </ProgressTemplate>
    </asp:UpdateProgress>
                        <asp:ListView ID="lstGd" runat="server">
                             
                             
                            <EmptyDataTemplate>
                                <span>No data was returned.</span>
                            </EmptyDataTemplate>
                             
                            <ItemTemplate>
                               
                                    <li class="mini-timeline-indigo">
							<div class="timeline-icon"><asp:Image CssClass="img-circle fancybox"   Height="37" Width="37" ImageUrl=<%# "~/Society/Media/ProfilePhoto/"+ Eval("Name").ToString().Split(':')[1] %> runat="server" ID="varImageLabel" /></div>
							<div class="timeline-body">
								<div class="timeline-content">
									<a  class="name block"><asp:Label Text=<%# Eval("Name").ToString().Split(':')[0] %> runat="server" ID="varNameLabel" /></a> <asp:Label Text='<%# Eval("varMessage") %>' runat="server" ID="varMessageLabel" /> 
								</div>
							</div>
							<span class="timeline-time"><asp:Label Text='<%# Eval("varDateTime") %>' runat="server" ID="varDateTimeLabel" /></span>
						</li>
                                     
                            </ItemTemplate>
                            <LayoutTemplate>
                               <span runat="server" id="itemPlaceholder" /> 
                              
                            </LayoutTemplate>
                             
                        </asp:ListView>  

					</ul>
                   
                  
				</div>
		 	 
		</div>
            <div class="panel-footer">
                  <div class="form-inline">  
                            <div class="form-group col-md-9 col-md-offset-1">
                            <asp:TextBox ID="txtGdEnter" runat="server" CssClass="form-control" Width="100%" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-2">
                                <asp:LinkButton ID="btnGD" OnClick="btnGD_Click" CssClass="btn btn-lg btn-primary" runat="server" Text="Send" />
                            </div>
                        </div>
            </div>
	</div>
                       
                      
                </asp:Panel>
                    </ContentTemplate>
                    </asp:UpdatePanel>