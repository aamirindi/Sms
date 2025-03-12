<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="AddComplaints.aspx.cs" Inherits="SocietyManagementSystem.AddComplaints" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0px 0px 10px #ddd;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

        <h2>Add Complaint</h2>
        <div>
            <label>Complaint Description:</label><br />
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="4"></asp:TextBox>
        </div>
        <br />
        <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
        <br />
        <asp:Button ID="btnAddComplaint" runat="server" Text="Add Complaint" CssClass="btn" OnClick="btnAddComplaint_Click" />
    </div>
</asp:Content>
