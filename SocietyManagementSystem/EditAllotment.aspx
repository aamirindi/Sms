<%@ Page Title="Edit Allotment" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeBehind="EditAllotment.aspx.cs" Inherits="SocietyManagementSystem.EditAllotment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Edit Allotment</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="Allotments.aspx">Allotments Management</a></li>
            <li class="breadcrumb-item active">Edit Allotment</li>
        </ol>
        <div class="col-md-4">
            <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger"></asp:Label>
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Edit Allotment</h5>
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
                    <asp:HiddenField ID="hdnAllotmentId" runat="server" />
                    <asp:Button ID="btnEditAllotment" runat="server" Text="Edit Allotment" CssClass="btn btn-primary" OnClick="btnEditAllotment_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
