<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="ViewNotiDetail.aspx.cs" Inherits="SocietyManagementSystem.ViewNotiDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="table-container">
        <h2>Notification Details</h2>
        <asp:Panel ID="pnlDetails" runat="server">
            <div class="table-inner">
                <table class="table">
                    <tr>
                        <th>Bill Title:</th>
                        <td>
                            <asp:Label ID="lblBillTitle" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Amount:</th>
                        <td>
                            <asp:Label ID="lblAmount" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Month:</th>
                        <td>
                            <asp:Label ID="lblMonth" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Paid Date:</th>
                        <td>
                            <asp:Label ID="lblPaidDate" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Payment Method:</th>
                        <td>
                            <asp:Label ID="lblPaymentMethod" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Paid Amount:</th>
                        <td>
                            <asp:Label ID="lblPaidAmount" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Created At:</th>
                        <td>
                            <asp:Label ID="lblCreatedAt" runat="server" /></td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
