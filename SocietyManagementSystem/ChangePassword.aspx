<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="SocietyManagementSystem.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
       .row h1,h4 {
               margin: .67em 39px;
        }
.form-group {
      margin: 0rem;
    padding: 10px;
    background-color: #f9f9f9;
    border-radius: 12px;
    width:60%;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Edit Profile title */
.form-group > div:first-child {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0px;
}

/* Form container styling */
.form-container {
    display: flex;
    flex-direction: column;
    gap: 0px;
}

/* Input label styling */
.form-container label {
    font-weight: bold;
    color: #444;
}

/* Input box styling */
.form-container asp\:TextBox {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    box-sizing: border-box;
}

/* Button styling */
.form-container .btn-primary {
    padding: 10px 20px;
    font-size: 16px;
    color: white;
    background-color: #007bff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.form-container .btn-primary:hover {
    background-color: #0056b3;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <section class="content">
    <div class="row">
   <h1>Profile</h1>

    <h4>Change Password</h4>
     
       
           <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
         <br />
        <div class="form-group">
               <h6>Change Password</h6>
            <div class="form-container">
                      Current Password
      
                      <asp:TextBox ID="TextBox1" runat="server" TextMode="Password" required="true" > </asp:TextBox>
      
                       <br />
   
                      New Password&nbsp;
         
                      <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" required="true"></asp:TextBox>
                      <br />
         
                      <br />
                      Confirm New Password
         
                      <asp:TextBox ID="TextBox3" runat="server" TextMode="Password" required="true"></asp:TextBox>
         
                    <br />

                      <asp:Button ID="Button2" runat="server" Text="Change Password" OnClick="Button2_Click" />
                 
                  <br />
             
            
            
            </div>
          
        </div>
           
    </div>
</section>
</asp:Content>
<%--<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="SocietyManagementSystem.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>--%>
