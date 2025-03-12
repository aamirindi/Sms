<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="EditBill.aspx.cs" Inherits="SocietyManagementSystem.EditBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .edit-form {
            width: 50%;
        }
        .edit-panel{
            margin-left: 3rem;
        }

        .form-control {
            width: 100%;
            padding: 10px;
        }

        .btn-container {
            margin-top: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="edit-form">
        <h2>Edit Bill</h2>
        <asp:Panel ID="EditPanel" runat="server" class="edit-panel">
            <label>Bill Title</label>
            <asp:TextBox ID="txtBillTitle" runat="server" CssClass="form-control" required></asp:TextBox>
            <br />
            <label>Amount</label>
            <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" required></asp:TextBox>
            <br />
            <label>Month</label>
            <asp:TextBox ID="txtMonth" runat="server" CssClass="form-control" required></asp:TextBox>
            <br />
            <label>Paid Date</label>
            <asp:TextBox ID="txtPaidDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            <br />
            <label>Payment Method</label>
            <asp:TextBox ID="txtPaymentMethod" runat="server" CssClass="form-control"></asp:TextBox>
            <br />
            <label>Paid Amount</label>
            <asp:TextBox ID="txtPaidAmount" runat="server" CssClass="form-control"></asp:TextBox>
            <br />
        </asp:Panel>
        <div class="btn-container">
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" PostBackUrl="BillManagementAdmin.aspx" />
        </div>
    </div>
</asp:Content>
