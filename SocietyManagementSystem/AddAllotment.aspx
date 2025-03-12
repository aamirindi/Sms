<%@ Page Title="Add Allotment" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeBehind="AddAllotment.aspx.cs" Inherits="SocietyManagementSystem.AddAllotment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #f8f9fa;
            border-bottom: none;
            padding: 20px;
        }
        .card-title {
            color: #333;
            font-weight: 600;
        }
        .form-control {
            border-radius: 5px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Add Allotment</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="Allotments.aspx">Allotments Management</a></li>
            <li class="breadcrumb-item active">Add Allotment</li>
        </ol>
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger d-block mb-3"></asp:Label>
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Add Allotment</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="ddlUsers" class="form-label">Select User</label>
                            <asp:DropDownList ID="ddlUsers" runat="server" CssClass="form-select" AppendDataBoundItems="true">
                                <asp:ListItem Text="-- Select User --" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label for="ddlFlats" class="form-label">Select Flat</label>
                            <asp:DropDownList ID="ddlFlats" runat="server" CssClass="form-select" AppendDataBoundItems="true">
                                <asp:ListItem Text="-- Select Flat --" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label for="txtMoveInDate" class="form-label">Move In Date</label>
                            <asp:TextBox ID="txtMoveInDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtMoveOutDate" class="form-label">Move Out Date</label>
                            <asp:TextBox ID="txtMoveOutDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnAddAllotment" runat="server" Text="Add Allotment" CssClass="btn btn-primary w-100" OnClick="btnAddAllotment_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<%--<%@ Page Title="Add Allotment" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeBehind="AddAllotment.aspx.cs" Inherits="SocietyManagementSystem.AddAllotment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Add Allotment</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="Allotments.aspx">Allotments Management</a></li>
            <li class="breadcrumb-item active">Add Allotment</li>
        </ol>
        <div class="col-md-4">
            <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger"></asp:Label>
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Add Allotment</h5>
                </div>
                <div class="card-body">
                    <asp:DropDownList ID="ddlUsers" runat="server" CssClass="form-control mb-3" AppendDataBoundItems="true">
                        <asp:ListItem Text="-- Select User --" Value="" />
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlFlats" runat="server" CssClass="form-control mb-3" AppendDataBoundItems="true">
                        <asp:ListItem Text="-- Select Flat --" Value="" />
                    </asp:DropDownList>
                    <div class="mb-3">
                        <label for="move_in_date">Move In Date</label>
                        <asp:TextBox ID="txtMoveInDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="move_out_date">Move Out Date</label>
                        <asp:TextBox ID="txtMoveOutDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnAddAllotment" runat="server" Text="Add Allotment" CssClass="btn btn-primary" OnClick="btnAddAllotment_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>
