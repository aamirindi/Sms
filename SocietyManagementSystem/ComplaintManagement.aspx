<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ComplaintManagement.aspx.cs" Inherits="SocietyManagementSystem.ComplaintManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .grid-container {
            margin-top: 20px;
        }

        .search-bar {
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
        }

        .action-buttons {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }

        .btn-primary, .btn-success, .btn-danger {
            margin-left: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Complaints Management</h1>
        
        <div class="grid-container">
          <asp:GridView ID="gvComplaints" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
    AllowPaging="True" PageSize="5" DataKeyNames="id"
    OnPageIndexChanging="gvComplaints_PageIndexChanging"
    OnRowDeleting="gvComplaints_RowDeleting"
    OnRowEditing="gvComplaints_RowEditing"
    OnRowCommand="gvComplaints_RowCommand">
    <Columns>
        <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
        <asp:BoundField DataField="UserName" HeaderText="User Name" />
        <asp:BoundField DataField="FlatNumber" HeaderText="Flat Number" />
        <asp:BoundField DataField="Description" HeaderText="Complaint" />
        <asp:BoundField DataField="Status" HeaderText="Status" />
        <asp:BoundField DataField="CreatedAt" HeaderText="CreatedAt" />
        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
                <asp:LinkButton ID="btnView" runat="server" CommandName="View" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-info">View</asp:LinkButton>
                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-warning">Edit</asp:LinkButton>
                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure you want to delete this complaint?');">Delete</asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <PagerSettings Mode="NumericFirstLast" Position="Bottom" />
</asp:GridView>
        </div>
    </div>
</asp:Content>
