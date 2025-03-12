<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="SocietyManagementSystem.EditUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       
     <section class="content">
    <div class="row">
   <h2>Edit Users</h2>
   <nav>
       <a href="Dashboard.aspx">Dashboard</a> / 
       
       <a href="FlatsManagement.aspx"> Users Management</a> / 
       
       <span>Edit User Data</span>
   </nav>

        <div class="form-group">
            <div>Edit Users Data</div>
            Name
           <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
             
            Email address
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <br />

            Password
           <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="Button1" runat="server" Text="Submit" Class="btn btn-primary" OnClick="Button1_Click"/>

            
        </div>

    </div>
</section>

</asp:Content>
<%--<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="SocietyManagementSystem.EditUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>--%>
