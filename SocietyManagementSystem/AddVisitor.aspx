<%@ Page Title="Add Visitor" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddVisitor.aspx.cs" Inherits="SocietyManagementSystem.AddVisitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Add Visitor</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="Visitors.aspx">Visitors Management</a></li>
            <li class="breadcrumb-item active">Add Visitor</li>
        </ol>
        <div class="col-md-4">
            <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger"></asp:Label>
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Add Visitor</h5>
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
                    <asp:Button ID="btnAddVisitor" runat="server" Text="Add Visitor" CssClass="btn btn-primary" OnClick="btnAddVisitor_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
