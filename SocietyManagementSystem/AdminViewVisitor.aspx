<%@ Page Title="View Visitor" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewVisitor.aspx.cs" Inherits="SocietyManagementSystem.Admin.AdminViewVisitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .detail-container { margin-top: 20px; }
        .detail-group { margin-bottom: 15px; }
        .detail-label { font-weight: bold; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">View Visitor</h1>
        <div class="col-md-6 detail-container">
            <asp:Label ID="lblError" runat="server" ForeColor="Red" CssClass="mb-3"></asp:Label>
            <div class="card">
                <div class="card-header"><h5 class="card-title">View Visitor</h5></div>
                <div class="card-body">
                    <div class="detail-group"><label class="detail-label">Flat Number:</label><asp:Label ID="lblFlatNumber" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Visitor Name:</label><asp:Label ID="lblName" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Phone Number:</label><asp:Label ID="lblPhone" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Address:</label><asp:Label ID="lblAddress" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Person to Meet:</label><asp:Label ID="lblPersonToMeet" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Reason for Visit:</label><asp:Label ID="lblReason" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">In Date/Time:</label><asp:Label ID="lblInDateTime" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Out Remark:</label><asp:Label ID="lblOutRemark" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Out Date/Time:</label><asp:Label ID="lblOutDateTime" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Status:</label><asp:Label ID="lblStatus" runat="server"></asp:Label></div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<%--<%@ Page Title="View Visitor" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewVisitor.aspx.cs" Inherits="SocietyManagementSystem.Admin.AdminViewVisitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .detail-container { margin-top: 20px; }
        .detail-group { margin-bottom: 15px; }
        .detail-label { font-weight: bold; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">View Visitor</h1>
        <div class="col-md-6 detail-container">
            <asp:Label ID="lblError" runat="server" ForeColor="Red" CssClass="mb-3"></asp:Label>
            <div class="card">
                <div class="card-header"><h5 class="card-title">View Visitor</h5></div>
                <div class="card-body">
                    <div class="detail-group"><label class="detail-label">Flat Number:</label><asp:Label ID="lblFlatNumber" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Visitor Name:</label><asp:Label ID="lblName" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Phone Number:</label><asp:Label ID="lblPhone" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Address:</label><asp:Label ID="lblAddress" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Person to Meet:</label><asp:Label ID="lblPersonToMeet" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Reason for Visit:</label><asp:Label ID="lblReason" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">In Date/Time:</label><asp:Label ID="lblInDateTime" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Out Remark:</label><asp:Label ID="lblOutRemark" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Out Date/Time:</label><asp:Label ID="lblOutDateTime" runat="server"></asp:Label></div>
                    <div class="detail-group"><label class="detail-label">Status:</label><asp:Label ID="lblStatus" runat="server"></asp:Label></div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>
