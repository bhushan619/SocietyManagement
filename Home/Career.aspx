<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/outside.master" AutoEventWireup="true" CodeFile="Career.aspx.cs" Inherits="Home_Career" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><!-- banner start -->
		  <div class="container">
        <div class="row ">  
            <h2>Current Vacancies </h2>
               <hr />
        <div class="col-sm-6">
          <div class="about-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
        <strong> Post: Business Development Executive</strong><br />
No of Vacancies: 6 <br />
Work Location:  Pune & Jalgaon<br />
Experience Required: Minimum of 6 months in IT Sales & Service<br />
Job Id: ASPL16/06/BDE01 <br />

<strong> Qualification Required: </strong>  MBA is sales & Marketing with 60% average (final semester appeared candidates must have all 5 semester cleared with average of 60%)<br />

<strong> Skills Required: </strong><br />

1. Must know English, Hindi & Marathi languages fluently <br />
2. Must be self driven, passionate about work and target oriented. <br />
3. Must be ready to travel & should have own vehicle <br />
4. Should be able to learn & gather the knowledge about how Business Analysts work, how to generate leads, how to convince clients. 
              <br />
5. Should be time bound & ready to learn new things by accepting market challenges <br />
6. Must have learning & implementing attitude. <br />
<strong> Salary: </strong> : Best as per industrial standards + incentives & TADA<br />

 
                 <br />       
   </div>
        </div>
           <div class="col-sm-6">
                  <div id="form"  >
                        <center><h3 >Application Form </h3></center> 
                    <div class="row  wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
                        <div class="col-sm-6">
                          
                            <div class="form-group">
                                <asp:TextBox ID="txtname" runat="server" CssClass="form-control" required="required"  onkeyup="checkText(this);"  placeholder="Name" ></asp:TextBox>
                              
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" required="required"  placeholder="Email Address" pattern="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)"></asp:TextBox>
                              
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                         <asp:TextBox ID="txtsub" runat="server" required="required" CssClass="form-control"  onkeyup="checkTextNum(this);" placeholder="Apply For The Post"></asp:TextBox>
                     
                    </div>
                    <div class="form-group">
                         <asp:TextBox ID="txtmsg" runat="server"  CssClass="form-control"   onkeyup="checkTextNum(this);" TextMode="MultiLine" Height="100" placeholder="Few Words About You..." required="required"></asp:TextBox>
                       
                    </div>
                         <div class="form-group">
                             <asp:FileUpload ID="UploadedFile"  runat="server" placeholder="Attach Resume"  />
                         
                    </div>
                    <div class="form-group"> <asp:Button ID="btnsubmit" CssClass="subs1" runat="server" Text="Submit" OnClick="btnsubmit_Click" />
                       
                    </div>
               
           </div>
         <!-- <div class="col-sm-6 ">
                 <div class="about-info wow fadeInLeft" data-wow-duration="1000ms" data-wow-delay="300ms">
                 
                     </div>
        </div> -->
      </div>
      </div>
              <hr />
         <div class="row ">  
             <div class="col-sm-6 ">
          <div class="about-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
       <strong>Post: IoS Developer</strong> <br />  
No of vacancies: 2  <br />  
Work location: Jalgaon  <br />  
Job Id: ASPL16/06/SE03 <br />  
  <strong>Responsibilities</strong> <br />  
•	Design and build advanced applications for the iOS platform <br />  
•	Collaborate with cross-functional teams to define, design, and ship new features. <br />  
•	Unit-test code for robustness, including edge cases, usability, and general reliability. <br />  
•	Work on bug fixing and improving application performance. <br />  
•	Continuously discover, evaluate, and implement new technologies to maximize development efficiency. <br />  
  <strong>Requirements</strong> <br />  
•	BS/MS degree in Computer Science, Engineering or a related subject <br />  
•	Proven working experience in software development <br />  
•	Working experience in iOS development <br />  
•	Have published one or more iOS apps in the app store <br />  
•	A deep familiarity with Objective-C and Cocoa Touch <br />  
•	Experience working with iOS frameworks such as Core Data, Core Animation, Core Graphics and Core Text <br />  
•	Experience with third-party libraries and APIs <br />  
•	Working knowledge of the general mobile landscape, architectures, trends, and emerging technologies <br />  
•	Solid understanding of the full mobile development life cycle <br />  
  <strong> Salary: </strong> : Best as per industrial standards  <br /> 

  <br />       
   </div>
             </div>
                <div class="col-sm-6 ">
                      <div class="about-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
    <br />
<strong>Post: Social media marketing & SEO </strong><br />
No of vacancies: 2<br />
Work location: Jalgaon<br />
Experience Required: Minimum of 6 months in SEO & SME <br />
 Job Id: ASPL16/06/BDE02 <br />
  <strong> Qualification Required: </strong> <br />
 1. MBA is sales & marketing with 60% average <br />
2. Any diploma of certification program in SME & SEO will be given preference<br /> 
  <strong> Skills Required: </strong><br />
1. Must be good in written English skills and communication<br />
 2. Must have good knowledge on designing and following branding pattern <br />
3. Should be having good learning attitude and good grasping power <br />
4. Should be able to understand new market requirement and marketing strategy on SME & SEO <br />
5. Should have petitions and target oriented approach <br />
6. Must be able to learn new things, self driven, self motivated and supportive in nature to work in team <br />
7. Must be able to work under stress. <br />
  <strong> Salary: </strong> : Best as per industrial standards <br />
   </div>
             </div>
             </div>
                   <hr />
                <div class="row ">  
                <div class="col-sm-6 ">
                      <div class="about-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
    <strong> Post: HR & Finance Executive </strong> <br /> 
No of Vacancies: 2  <br /> 
Work Location: Jalgaon  <br /> 
Job Id: ASPL16/06/ADM01 <br /> 
  <strong> Qualification Required: </strong>   <br /> 
MBA in Hr & Finance with 60% average  <br /> 
  <strong> Skills Required: </strong> <br /> 
1. Should be good in communication <br /> 
 2. Should be a good team player  <br /> 
3. Should have basic knowledge about Human Resource Management & policies <br /> 
 4. Should be strict in nature about the rules and regulations <br /> 
   <strong> Salary: </strong> : Best as per industrial standards. <br /> 
             <br />             
                          
   </div>
             </div>

           
             <div class="col-sm-6 ">
          <div class="about-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
    <strong>  Post: .Net Developer</strong>   <br />  
No of vacancies: 6  <br />  
 Work location: Jalgaon   <br />  
Job Id: ASPL16/06/SE01   <br />  
  <strong> Qualification Required: </strong>  UG: Computers, Computers, B.Sc - Any Specialization, Computers, BCA - Computers PG: Any Computer Postgraduate   <br />  
  <strong> Skills Required: </strong>
ASP.Net, VB.NET, SQL/MySql Server, .Net Web Application Development, Web Technologies, Software Development  <br />  
  <strong> Salary: </strong> : Best as per industrial standards.   <br />  
   <br />           

  <br />       
   </div>
             </div>
                    </div>
                   <hr />
          <div class="row ">  

                <div class="col-sm-6 ">
                      <div class="about-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
    <strong>   Post: Customer Support Executive </strong><br />
No of vacancies: 6 <br />
Work location: Jalgaon <br />
Job Id: ASPL16/06/BDE03<br />
  <strong> Qualification Required: </strong>  MBA is sales & Marketing with 60% average <br />
  <strong> Skills Required: </strong><br />
1. Must know English, Hindi & Marathi languages <br />
2. Should be good in communication & should have good petitions.<br />
 3. Should be able to convince over the phone call and make daily calls to generate leads.<br />
                           4. Should know basic of computer like excel, power point and have good typing speed <br />
5. Should have learning attitude and problem solving nature <br />
  <strong> Salary: </strong> : Best as per industrial standards <br />


  <br />       
  </div> 
                    </div>
           
                    <div class="col-sm-6 ">
                          <div class="about-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
  <strong>Post: Content Manager</strong> <br /> 
No of Vacancies: 2 <br /> 
Work location: Jalgaon <br /> 
Job ID: ASPL16/06/ADM02 <br /> 
  <strong> Qualification Required: </strong>  UG/PG with specialization in English <br /> 
  <strong> Skills Required: </strong> <br /> 
1.	Must be good at writing creative articles  <br /> 
2.	Must have good hold on English writing  <br /> 
3.	Must be ready to accept challenges & create content accordingly  <br /> 
4.	Must have sound knowledge about blogging, article writing <br /> 
5.	Must be able to coordinate with media & release media notes. <br /> 
  <strong> Salary: </strong> :Best as per industrial standards <br />
    </div>
                        
   </div>
          
             </div>
                   <hr />

    </div>
 

</asp:Content>

