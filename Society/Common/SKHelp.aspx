<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="SKHelp.aspx.cs" Inherits="Society_Common_SKHelp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
		<div class="col-md-6 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2> Ask Help</h2>
				</div>
				<div class="panel-body">
					<div  class="form-horizontal">                     
                          <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Subject</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" onkeyup="checkText(this);" required="required"></asp:TextBox>
									</div></div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Description</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"  required="required" TextMode="MultiLine"></asp:TextBox>
									</div>
									
								</div>
                         <div class="form-group">
									<label for="focusedinput" class="col-sm-3   control-label">Contact Name</label>
									<div class="col-sm-8">
										<asp:TextBox ID="txtname" onkeyup="checkText(this);" runat="server" CssClass="form-control"  required="required"></asp:TextBox>
									</div>
								</div>	
                                          <div class="form-group">
											            <label for="form-name" class="col-sm-3 control-label">Mobile</label>
											            <div class="col-sm-8 ">
											              <asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" required="required" MaxLength="12" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" ></asp:TextBox>
											            </div>
										            </div>
                                                   <div class="form-group">
									                            <label for="focusedinput" class="col-sm-3   control-label"> Email-Id</label>
									                            <div class="col-sm-8 ">
										                                   <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" required="required"  pattern="[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|in|co.in)" ></asp:TextBox>
									                            </div>									
								                           </div>
                                                    
                          
                        <div class="form-group">
									<div class="col-sm-3  "></div>
									<div class="col-sm-8">
									
                       <asp:Button ID="btnSubmit" runat="server" CssClass="mb-xs mt-xs mr-xs btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"  />
                          <a  class="mb-xs mt-xs mr-xs btn btn-primary" href="SKHelp.aspx" >Reset</a>
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
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2> Get Help</h2>
				</div>
				<div class="panel-body">
                     <div class="col-md-8 ">
                   <i class="fa fa-home"></i>&nbsp;  Flat No. 1, Akshay Chambers, 
                         <br />Samarth Colony, Near Prabhat Chowk, <br /> Jalgaon Maharashtra (India).
                          <br />  <br />Call Us Now<br /> 
                           <i class="fa fa-phone"></i> +91 257-606-6999
                           <br />
                         <i class="fa fa-mobile"></i>&nbsp; +91 9561421489
                           <br />
                         <i class="fa fa-mobile"></i>&nbsp; +91 9620961818
                          <br />  <br />   Working Hour<br /> 
                         <i class="fa fa-clock-o"></i> Mon To Sat : 10pm - 5pm
                         
                         <br />
                         </div>
                     <div class="col-md-4 ">

                      
                         </div>
                    </div>
                </div>
            </div>
 
	</div>

</asp:Content>
 
        

