<%@ Page Title="Visitor Management" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeBehind="Visitors.aspx.cs" Inherits="SocietyManagementSystem.Visitors" %>

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
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.8rem;
        }
        .table td {
            vertical-align: middle;
        }
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Visitor Management</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item active">Visitor Management</li>
        </ol>
        <asp:Label ID="lblSuccess" runat="server" Visible="false" CssClass="alert alert-success"></asp:Label>
        <div class="card mb-4">
            <div class="card-header">
                <div class="row align-items-center">
                    <div class="col">
                        <h5 class="card-title mb-0">Visitor Management</h5>
                    </div>
                    <div class="col text-end">
                        <a href="AddVisitor.aspx" class="btn btn-success btn-sm">
                            <i class="fas fa-plus me-2"></i>Add New Visitor
                        </a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvVisitors" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        OnRowCommand="gvVisitors_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="ID" />
                            <asp:BoundField DataField="flat_number" HeaderText="Flat Number" />
                            <asp:BoundField DataField="name" HeaderText="Visitor Name" />
                            <asp:BoundField DataField="phone" HeaderText="Visitor Phone" />
                            <asp:BoundField DataField="person_to_meet" HeaderText="Person to Meet" />
                            <asp:BoundField DataField="in_datetime" HeaderText="In Time" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                            <asp:BoundField DataField="out_datetime" HeaderText="Out Time" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                            <asp:BoundField DataField="is_in_out" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-primary me-2">
                                        <i class="fas fa-edit me-1"></i>Edit
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-danger me-2" OnClientClick="return confirm('Are you sure you want to remove this visitor?');">
                                        <i class="fas fa-trash-alt me-1"></i>Delete
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnView" runat="server" CommandName="View" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-info">
                                        <i class="fas fa-eye me-1"></i>View
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<%--<%@ Page Title="Visitor Management" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeBehind="Visitors.aspx.cs" Inherits="SocietyManagementSystem.Visitors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Visitor Management</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item active">Visitor Management</li>
        </ol>
        <asp:Label ID="lblSuccess" runat="server" Visible="false" CssClass="alert alert-success"></asp:Label>
        <div class="card">
            <div class="card-header">
                <div class="row">
                    <div class="col col-6">
                        <h5 class="card-title">Visitor Management</h5>
                    </div>
                    <div class="col col-6">
                        <div class="float-end"><a href="AddVisitor.aspx" class="btn btn-success btn-sm">Add</a></div>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvVisitors" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
                        OnRowCommand="gvVisitors_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="ID" />
                            <asp:BoundField DataField="flat_number" HeaderText="Flat Number" />
                            <asp:BoundField DataField="name" HeaderText="Visitor Name" />
                            <asp:BoundField DataField="phone" HeaderText="Visitor Phone" />
                            <asp:BoundField DataField="person_to_meet" HeaderText="Person to Meet" />
                            <asp:BoundField DataField="in_datetime" HeaderText="In Time" />
                            <asp:BoundField DataField="out_datetime" HeaderText="Out Time" />
                            <asp:BoundField DataField="is_in_out" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-primary">Edit</asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure you want to remove this visitor?');">Delete</asp:LinkButton>
                                    <asp:LinkButton ID="btnView" runat="server" CommandName="View" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-info">View</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>
