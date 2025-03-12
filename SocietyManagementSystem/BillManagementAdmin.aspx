<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="BillManagementAdmin.aspx.cs" Inherits="SocietyManagementSystem.BillManagementAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .search-bill {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            margin-top: 3rem;
        }

        .search-bill-inner {
            width: 45%;
            display: flex;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row-management">
        <h2>Bill Management</h2>
        <div class="form-group">
            <asp:Button ID="Button1" OnClick="Add_Bill" runat="server" Text="Add" class="btn btn-primary" />
            <div class="search-bill">
                <div class="search-bill-inner">
                    <label for="txtName">Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                </div>
                <div class="search-bill-inner">
                    <label for="txtFromMonth">From</label>
                    <asp:TextBox ID="txtFromMonth" runat="server" CssClass="form-control" TextMode="Month"></asp:TextBox>
                </div>
                <div class="search-bill-inner">
                    <label for="txtToMonth">To</label>
                    <asp:TextBox ID="txtToMonth" runat="server" CssClass="form-control" TextMode="Month"></asp:TextBox>
                </div>
                <div class="search-bill-inner">
                    <label for="ddlPaymentStatus">Payment Status</label>
                    <asp:DropDownList ID="ddlPaymentStatus" runat="server" CssClass="form-control">
                        <asp:ListItem Text="All" Value=""></asp:ListItem>
                        <asp:ListItem Text="Paid" Value="Paid"></asp:ListItem>
                        <asp:ListItem Text="Not Paid" Value="Not Paid"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                </div>
            </div>
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                AllowPaging="True" PageSize="6" DataKeyNames="id" OnRowCommand="GridView1_RowCommand"
                OnPageIndexChanging="GridView1_PageIndexChanging">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="bill_title" HeaderText="Bill Title" />
                    <asp:BoundField DataField="amount" HeaderText="Amount" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="month" HeaderText="Month" />
                    <asp:BoundField DataField="paid_date" HeaderText="Paid Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="payment_method" HeaderText="Payment Method" />
                    <asp:BoundField DataField="paid_amount" HeaderText="Paid Amount" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="created_at" HeaderText="Created At" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-warning btn-sm"
                                CommandName="ViewRow" CommandArgument='<%# Eval("id") %>' />
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-primary btn-sm"
                                CommandName="EditRow" CommandArgument='<%# Eval("id") %>' />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"
                                CommandName="DeleteRow" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirm('Are you sure?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
