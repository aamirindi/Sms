
<%@ Page Title="View Visitor" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeBehind="ViewVisitor.aspx.cs" Inherits="SocietyManagementSystem.ViewVisitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">View Visitor</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="Visitors.aspx">Visitor Management</a></li>
            <li class="breadcrumb-item active">View Visitor</li>
        </ol>
        <div class="col-md-4">
            <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger"></asp:Label>
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">View Visitor Details</h5>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-4"><b>Flat Number</b></div>
                        <div class="col-md-8"><asp:Label ID="lblFlatNumber" runat="server"></asp:Label></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4"><b>Visitor Name</b></div>
                        <div class="col-md-8"><asp:Label ID="lblName" runat="server"></asp:Label></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4"><b>Visitor Phone Number</b></div>
                        <div class="col-md-8"><asp:Label ID="lblPhone" runat="server"></asp:Label></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4"><b>Visitor Address</b></div>
                        <div class="col-md-8"><asp:Label ID="lblAddress" runat="server"></asp:Label></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4"><b>Person to Meet</b></div>
                        <div class="col-md-8"><asp:Label ID="lblPersonToMeet" runat="server"></asp:Label></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4"><b>Reason for Visit</b></div>
                        <div class="col-md-8"><asp:Label ID="lblReason" runat="server"></asp:Label></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4"><b>In Date & Time</b></div>
                        <div class="col-md-8"><asp:Label ID="lblInDateTime" runat="server"></asp:Label></div>
                    </div>
                    <asp:Panel ID="pnlOutDetails" runat="server" Visible="false">
                        <div class="row mb-3">
                            <div class="col-md-4"><b>Out Remark</b></div>
                            <div class="col-md-8"><asp:Label ID="lblOutRemark" runat="server"></asp:Label></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4"><b>Out Date & Time</b></div>
                            <div class="col-md-8"><asp:Label ID="lblOutDateTime" runat="server"></asp:Label></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4"><b>Status</b></div>
                            <div class="col-md-8"><span class="badge bg-success">Out</span></div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="pnlMarkOut" runat="server" Visible="false">
                        <div class="row mb-3">
                            <div class="col-md-4"><b>Status</b></div>
                            <div class="col-md-8"><span class="badge bg-danger">In</span></div>
                        </div>
                        <div class="mb-3">
                            <label for="out_datetime">Out Date/Time</label>
                            <asp:TextBox ID="txtOutDateTime" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="out_remark">Out Remark</label>
                            <asp:TextBox ID="txtOutRemark" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <asp:HiddenField ID="hdnVisitorId" runat="server" />
                        <asp:Button ID="btnMarkOut" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnMarkOut_Click" />
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
