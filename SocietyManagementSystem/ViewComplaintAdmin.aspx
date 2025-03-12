<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ViewComplaintadmin.aspx.cs" Inherits="SocietyManagementSystem.ViewComplaintadmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>View Complaint</h2>
        <nav>
            <a href="Dashboard.aspx">Dashboard</a> /
            <a href="ComplaintManagement.aspx">Complaints Management</a> /
            <span>View Complaint</span>
        </nav>

        <div class="complaint-box">
            <h3>Complaint Details</h3>
            <table>
                <tr>
                    <td><strong>User Name:</strong></td>
                    <td><asp:Label ID="lblUserName" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Flat Number:</strong></td>
                    <td><asp:Label ID="lblFlatNumber" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Complaint Details:</strong></td>
                    <td><asp:Label ID="lblComplaintDetails" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Status:</strong></td>
                    <td>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>

            <h4>Master Comment</h4>
            <asp:TextBox ID="txtMasterComment" runat="server" TextMode="MultiLine"></asp:TextBox>

            <h4>Complaint Status</h4>
    <asp:DropDownList ID="ddlStatus" runat="server">
        <asp:ListItem Text="Pending" Value="pending" />
        <asp:ListItem Text="Resolved" Value="resolved" />
        <asp:ListItem Text="In Progress" Value="in_progress" />
    </asp:DropDownList>

            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        </div>
    </div>
</asp:Content>
