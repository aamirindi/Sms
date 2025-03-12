<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="BillPaymentUser.aspx.cs" Inherits="SocietyManagementSystem.BillPaymentUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="row">
            <h2>Bill Payment</h2>
            <div class="row-inner">
                <div class="inner-data">
                    <label>Flat Number:</label>
                    <asp:Label ID="lblFlatNumber" runat="server"></asp:Label>
                </div>
                <br />
                <div class="inner-data">
                    <label>Bill Details:</label>
                    <asp:Label ID="lblBillTitle" runat="server"></asp:Label>
                </div>
                <br />
                <div class="inner-data">
                    <label>Bill Month:</label>
                    <asp:Label ID="lblBillMonth" runat="server"></asp:Label>
                </div>
                <br />
                <div class="inner-data">
                    <label>Bill Amount:</label>
                    <asp:Label ID="lblBillAmount" runat="server"></asp:Label>
                </div>
                <br />
                <div>
                    <label>Payment Date:</label>
                    <asp:TextBox ID="txtPaymentDate" runat="server" TextMode="Date" class="form-control"></asp:TextBox>
                </div>
                <br />
                <div>
                    <label>Paid Bill Amount:</label>
                    <asp:TextBox ID="txtPaidAmount" runat="server" class="form-control"></asp:TextBox>
                </div>
                <br />
                <div>
                    <label>Payment Method:</label>
                    <asp:DropDownList ID="ddlPaymentMethod" runat="server" class="form-control">
                        <asp:ListItem Text="Select Payment Method" Value="" />
                        <asp:ListItem Text="Cash" Value="Cash" />
                        <asp:ListItem Text="Online" Value="Online" />
                    </asp:DropDownList>
                </div>
                <br />
                <asp:Button ID="btnSubmit" runat="server" Text="Payment" OnClick="btnSubmit_Click" class="btn btn-primary" />
                <asp:Button ID="Button1" runat="server" Text="Back" OnClick="btnBack_Click" class="btn btn-secondary" />
            </div>
        </div>
    </section>
</asp:Content>
