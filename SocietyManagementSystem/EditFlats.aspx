<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="EditFlats.aspx.cs" Inherits="SocietyManagementSystem.EditFlats" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="container mt-4">
        <h2 class="mb-4">Edit Flat</h2>
       <nav>
           <a href="Dashboard.aspx">Dashboard</a> / 
           <a href="FlatsManagement.aspx">Flats Management</a> / 
           <span>Edit Flats Management</span>
       </nav>

        <div class="card">
            <div class="card-body">
                <asp:HiddenField ID="flatid" runat="server" />
                
                <div class="form-group">
                    <label>Flat Number</label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" required></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Floor</label>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" required></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Block Number</label>
                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" required></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Flat Type</label>
                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" required></asp:TextBox>
                </div>

                <asp:Button ID="btnUpdateFlat" runat="server" CssClass="btn btn-primary mt-3" Text="Update Flat" OnClick="btnUpdateFlat_Click" />
                <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary mt-3" Text="Cancel" OnClick="btnCancel_Click" />
            </div>
        </div>
    </div>
</asp:Content>
