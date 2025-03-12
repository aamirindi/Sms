<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddBills.aspx.cs" Inherits="SocietyManagementSystem.AddBills" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="row">
            <h2>Add Bill</h2>
            <div class="form-group">
                <label for="TextBox1">Bill Title:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Cannot be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                <br />
                <label for="DropDownList1">Flat No:</label>
                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                </asp:DropDownList>
                <br />
                <label for="TextBox2">Amount:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox2" ErrorMessage="Cannot be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox2" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
                <br />
                <label for="TextBox3">Month:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox3" ErrorMessage="Cannot be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox3" runat="server" TextMode="Month" CssClass="form-control"></asp:TextBox>
                <br />
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add" CssClass="btn btn-primary" />
            </div>
        </div>
    </section>
</asp:Content>
