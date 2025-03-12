<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="SocietyManagementSystem.UserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
       .row h1,h4 {
               margin: .67em 39px;
        }
.form-group {
    margin: 0px 0px;
    padding: 15px;
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
    margin-bottom: 20px;
}

/* Form container styling */
.form-container {
    display: flex;
    flex-direction: column;
    gap: 16px;
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

    <h4>Edit Profile</h4>
       
        <div class="form-group">
          <div>Edit Profile</div>
            <div class="form-container">
                      Name
      
                      <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
      
              <br />
   
            Email address
         
                      <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
         
             <br />

           <asp:Button ID="Button1" runat="server" Text="Save" Class="btn btn-primary" OnClick="Button1_Click"   />
            
            </div>
          
        </div>
           
    </div>
</section>
</asp:Content>
<%--<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="SocietyManagementSystem.UserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>--%>
