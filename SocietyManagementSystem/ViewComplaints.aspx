<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="ViewComplaint.aspx.cs" Inherits="SocietyManagementSystem.ViewComplaint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>View Complaint</h2>
        <nav>
            <a href="Dashboard.aspx">Dashboard</a> /
            <a href="Complaints.aspx">Complaints</a> /
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
                <tr>
        <td><strong>Master Comment:</strong></td>
        <td>
            <asp:Repeater ID="rptMasterComments" runat="server">
                <ItemTemplate>
                    <p><strong>Comment Date & Time:</strong> <%# Eval("comment_date") %></p>
                    <p><strong>Comment:</strong> <%# Eval("comment_text") %></p>
                    <hr />
                </ItemTemplate>
            </asp:Repeater>
        </td>
    </tr>

            </table>

          

        </div>
    </div>
</asp:Content>

