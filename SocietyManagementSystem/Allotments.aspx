<%@ Page Title="Allotments Management" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Allotments.aspx.cs" Inherits="SocietyManagementSystem.Allotments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #007bff;
            color: white;
            border-bottom: none;
            padding: 15px;
        }

        .card-title {
            font-size: 1.25rem;
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

        .table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
        }

        .table td {
            vertical-align: middle;
        }

        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        .search-box {
            margin-bottom: 20px;
        }

            .search-box input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Allotments Management</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item active">Allotments Management</li>
        </ol>
        <asp:Label ID="lblSuccess" runat="server" Visible="false" CssClass="alert alert-success"></asp:Label>
        <div class="card mb-4">
            <div class="card-header">
                <div class="row align-items-center">
                    <div class="col">
                        <h5 class="card-title mb-0">Allotments List</h5>
                    </div>
                    <div class="col text-end">
                        <a href="AddAllotment.aspx" class="btn btn-success btn-sm">
                            <i class="fas fa-plus me-2"></i>Add New Allotment
                        </a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="search-box">
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by name..." CssClass="form-control"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-sm mt-2" OnClick="btnSearch_Click" />
                </div>
                <div class="table-responsive">
                    <asp:GridView ID="gvAllotments" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        OnRowCommand="gvAllotments_RowCommand" OnRowDeleting="gvAllotments_RowDeleting" AllowPaging="True" AllowSorting="True"
                        OnPageIndexChanging="gvAllotments_PageIndexChanging" DataKeyNames="id" PageSize="10">
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="ID" SortExpression="id" />
                            <asp:BoundField DataField="AllotedTo" HeaderText="Alloted To" SortExpression="AllotedTo" />
                            <asp:BoundField DataField="flat_number" HeaderText="Flat Number" SortExpression="flat_number" />
                            <asp:BoundField DataField="block_number" HeaderText="Block Number" SortExpression="block_number" />
                            <asp:BoundField DataField="flat_type" HeaderText="Type" SortExpression="flat_type" />
                            <asp:BoundField DataField="move_in_date" HeaderText="Move In Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="move_in_date" />
                            <asp:BoundField DataField="move_out_date" HeaderText="Move Out Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="move_out_date" />
                            <asp:BoundField DataField="created_at" HeaderText="Created At" DataFormatString="{0:dd/MM/yyyy HH:mm}" SortExpression="created_at" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-primary me-2">
                                        <i class="fas fa-edit me-1"></i>Edit
                                    </asp:LinkButton>
                                    <%--<asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure you want to delete this allotment?');">
                                        <i class="fas fa-trash-alt me-1"></i>Delete
                                    </asp:LinkButton>--%>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>'
                                        CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure you want to delete this allotment?');">
    <i class="fas fa-trash-alt me-1"></i>Delete
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pagination-ys" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<%--<%@ Page Title="Allotments Management" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Allotments.aspx.cs" Inherits="SocietyManagementSystem.Allotments" %>

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
        .search-box {
            margin-bottom: 20px;
        }
        .search-box input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Allotments Management</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item active">Allotments Management</li>
        </ol>
        <asp:Label ID="lblSuccess" runat="server" Visible="false" CssClass="alert alert-success"></asp:Label>
        <div class="card mb-4">
            <div class="card-header">
                <div class="row align-items-center">
                    <div class="col">
                        <h5 class="card-title mb-0">Allotments Management</h5>
                    </div>
                    <div class="col text-end">
                        <a href="AddAllotment.aspx" class="btn btn-success btn-sm">
                            <i class="fas fa-plus me-2"></i>Add New Allotment
                        </a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="search-box">
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by name..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-sm" OnClick="btnSearch_Click" />
                </div>
                <div class="table-responsive">
                    <asp:GridView ID="gvAllotments" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        OnRowCommand="gvAllotments_RowCommand" OnRowDeleting="gvAllotments_RowDeleting" AllowPaging="True" AllowSorting="True"
                        OnPageIndexChanging="gvAllotments_PageIndexChanging" OnSorting="gvAllotments_Sorting" PageSize="10">
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="ID" SortExpression="id" />
                            <asp:BoundField DataField="AllotedTo" HeaderText="Alloted to" SortExpression="AllotedTo" />
                            <asp:BoundField DataField="flat_number" HeaderText="Flat Number" SortExpression="flat_number" />
                            <asp:BoundField DataField="block_number" HeaderText="Block Number" SortExpression="block_number" />
                            <asp:BoundField DataField="flat_type" HeaderText="Type" SortExpression="flat_type" />
                            <asp:BoundField DataField="move_in_date" HeaderText="Move in Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="move_in_date" />
                            <asp:BoundField DataField="move_out_date" HeaderText="Move Out Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="move_out_date" />
                            <asp:BoundField DataField="created_at" HeaderText="Created At" DataFormatString="{0:dd/MM/yyyy HH:mm}" SortExpression="created_at" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-primary me-2">
                                        <i class="fas fa-edit me-1"></i>Edit
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure you want to remove this allotment?');">
                                        <i class="fas fa-trash-alt me-1"></i>Delete
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pagination-ys" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>

<%--<%@ Page Title="Allotments Management" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Allotments.aspx.cs" Inherits="SocietyManagementSystem.Allotments" %>

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
        <h1 class="mt-4">Allotments Management</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item active">Allotments Management</li>
        </ol>
        <asp:Label ID="lblSuccess" runat="server" Visible="false" CssClass="alert alert-success"></asp:Label>
        <div class="card mb-4">
            <div class="card-header">
                <div class="row align-items-center">
                    <div class="col">
                        <h5 class="card-title mb-0">Allotments Management</h5>
                    </div>
                    <div class="col text-end">
                        <a href="AddAllotment.aspx" class="btn btn-success btn-sm">
                            <i class="fas fa-plus me-2"></i>Add New Allotment
                        </a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvAllotments" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        OnRowCommand="gvAllotments_RowCommand" OnRowDeleting="gvAllotments_RowDeleting" AllowPaging >
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="ID" />
                            <asp:BoundField DataField="AllotedTo" HeaderText="Alloted to" />
                            <asp:BoundField DataField="flat_number" HeaderText="Flat Number" />
                            <asp:BoundField DataField="block_number" HeaderText="Block Number" />
                            <asp:BoundField DataField="flat_type" HeaderText="Type" />
                            <asp:BoundField DataField="move_in_date" HeaderText="Move in Date" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="move_out_date" HeaderText="Move Out Date" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="created_at" HeaderText="Created At" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-primary me-2">
                                        <i class="fas fa-edit me-1"></i>Edit
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure you want to remove this allotment?');">
                                        <i class="fas fa-trash-alt me-1"></i>Delete
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>
<%--<%@ Page Title="Allotments Management" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Allotments.aspx.cs" Inherits="SocietyManagementSystem.Allotments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Allotments Management</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item active">Allotments Management</li>
        </ol>
        <asp:Label ID="lblSuccess" runat="server" Visible="false" CssClass="alert alert-success"></asp:Label>
        <div class="card">
            <div class="card-header">
                <div class="row">
                    <div class="col col-6">
                        <h5 class="card-title">Allotments Management</h5>
                    </div>
                    <div class="col col-6">
                        <div class="float-end"><a href="AddAllotment.aspx" class="btn btn-success btn-sm">Add</a></div>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvAllotments" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
                        OnRowCommand="gvAllotments_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="ID" />
                            <asp:BoundField DataField="name" HeaderText="Alloted to" />
                            <asp:BoundField DataField="flat_number" HeaderText="Flat Number" />
                            <asp:BoundField DataField="block_number" HeaderText="Block Number" />
                            <asp:BoundField DataField="flat_type" HeaderText="Type" />
                            <asp:BoundField DataField="move_in_date" HeaderText="Move in Date" />
                            <asp:BoundField DataField="move_out_date" HeaderText="Move Out Date" />
                            <asp:BoundField DataField="created_at" HeaderText="Created At" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-primary">Edit</asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure you want to remove this allotment?');">Delete</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>
