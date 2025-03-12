<%@ Page Title="Edit Allotment" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeBehind="EditAllotment.aspx.cs" Inherits="SocietyManagementSystem.EditAllotment" %>

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
        <h1 class="mt-4">Edit Allotment</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="Allotments.aspx">Allotments Management</a></li>
            <li class="breadcrumb-item active">Edit Allotment</li>
        </ol>
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger d-block mb-3"></asp:Label>
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Edit Allotment</h5>
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
                        <asp:HiddenField ID="hdnAllotmentId" runat="server" />
                        <asp:Button ID="btnEditAllotment" runat="server" Text="Update Allotment" CssClass="btn btn-primary w-100" OnClick="btnEditAllotment_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<%--<%@ Page Title="Edit Visitor" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeBehind="EditVisitor.aspx.cs" Inherits="SocietyManagementSystem.EditVisitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Edit Visitor</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="Visitors.aspx">Visitors Management</a></li>
            <li class="breadcrumb-item active">Edit Visitor</li>
        </ol>
        <div class="col-md-4">
            <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger"></asp:Label>
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Edit Visitor</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="flat_id">Flat Number</label>
                        <asp:DropDownList ID="ddlFlats" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                            <asp:ListItem Text="Select Flat" Value="" />
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label for="name">Visitor Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="phone">Phone Number</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="address">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="person_to_meet">Person to Meet</label>
                        <asp:TextBox ID="txtPersonToMeet" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="reason">Reason for Visit</label>
                        <asp:TextBox ID="txtReason" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="in_datetime">In Date/Time</label>
                        <asp:TextBox ID="txtInDateTime" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                    </div>
                    <asp:HiddenField ID="hdnVisitorId" runat="server" />
                    <asp:Button ID="btnEditVisitor" runat="server" Text="Edit Visitor" CssClass="btn btn-primary" OnClick="btnEditVisitor_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>
