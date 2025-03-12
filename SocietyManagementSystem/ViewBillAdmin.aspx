<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ViewBillAdmin.aspx.cs" Inherits="SocietyManagementSystem.ViewBillAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .view-bill {
            max-width: 600px;
            padding: 20px;
            border-radius: 8px;
        }

        .bill-details {
            display: flex;
            flex-direction: column;
            gap: 10px;
            padding: 20px;
            border-radius: 8px;
            background: #f8f9fa;
        }

        .bill-details .form-label {
            font-size: 16px;
            font-weight: 500;
            color: #444;
            padding: 10px;
            background: #e9ecef;
            border-radius: 5px;
            display: block;
            width: 100%;
        }

        .btn-container {
            text-align: center;
            margin-top: 20px;
        }

        .btn-container .btn {
            width: 150px;
            font-size: 16px;
            font-weight: 600;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="view-bill">
        <h2>View Bill</h2>
        <div class="bill-details">
            <asp:Label ID="lblBillTitle" runat="server" CssClass="form-label"></asp:Label>
            <asp:Label ID="lblAmount" runat="server" CssClass="form-label"></asp:Label>
            <asp:Label ID="lblMonth" runat="server" CssClass="form-label"></asp:Label>
            <asp:Label ID="lblPaidDate" runat="server" CssClass="form-label"></asp:Label>
            <asp:Label ID="lblPaymentMethod" runat="server" CssClass="form-label"></asp:Label>
            <asp:Label ID="lblPaidAmount" runat="server" CssClass="form-label"></asp:Label>
            <asp:Label ID="lblCreatedAt" runat="server" CssClass="form-label"></asp:Label>
        </div>
        <div class="btn-container">
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-primary" OnClick="btnBack_Click" />
        </div>
    </section>
</asp:Content>
