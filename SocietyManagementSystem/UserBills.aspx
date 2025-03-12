<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="UserBills.aspx.cs" Inherits="SocietyManagementSystem.UserBills" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .search-bill {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
        }

        .search-bill-inner {
            width: 45%;
            display: flex;
            margin: 1rem;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row-management">
        <h2>Bill Management</h2>
        <div class="search-bill">
            <div class="search-bill-inner">
                <label for="txtSearchMonth">Search by Month:</label>
                <asp:TextBox ID="txtSearchMonth" runat="server" CssClass="form-control" TextMode="Month"></asp:TextBox>
            </div>
            <div class="search-bill-inner">
                <label for="ddlPaymentStatus">Filter by Payment Status:</label>
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
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
            AllowPaging="True" PageSize="8" DataKeyNames="id" OnRowCommand="GridView1_RowCommand"
            OnPageIndexChanging="GridView1_PageIndexChanging">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="ID" />
                <asp:BoundField DataField="bill_title" HeaderText="Bill Title" />
                <asp:BoundField DataField="amount" HeaderText="Amount" DataFormatString="{0:C}" />
                <asp:BoundField DataField="month" HeaderText="Month" />
                <asp:BoundField DataField="paid_date" HeaderText="Paid Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="payment_method" HeaderText="Payment Method" />
                <asp:TemplateField HeaderText="Paid Amount">
                    <ItemTemplate>
                        <asp:Label ID="lblPaidAmount" runat="server" Text='<%# Eval("paid_amount", "{0:C}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="created_at" HeaderText="Created At" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-warning btn-sm"
                            CommandName="ViewRow" CommandArgument='<%# Eval("id") %>' />
                        <asp:Button ID="btnPay" runat="server" Text="Pay" CssClass="btn btn-success btn-sm"
                            CommandName="PayBill" CommandArgument='<%# Eval("id") %>'
                            Visible='<%# Eval("paid_amount").ToString() == "Not Paid" %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
