<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="BillDetails.aspx.cs" Inherits="SocietyManagementSystem.BillDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .bill-container{
        }
        .bill-details {
            display: flex;
            justify-content: center;
            flex-direction: column;
            align-items: center;
        }

        .bill-details-inner {
            display: flex;
            justify-content: space-between;
            width: 50%;
            padding: 1rem;
            background: white;
            box-shadow: 0 0 0 2px rgba(0,0,0,10);
        }
        .bill-btn{
            margin-top: 1rem;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bill-container">
        <h2>Bill Details</h2>
        <div class="bill-details">
            <div class="bill-details-inner">
                <p><strong>Bill Title:</strong></p>
                <p><asp:Label ID="lblBillTitle" runat="server" /></p>
            </div>
            <div class="bill-details-inner">
                <p><strong>Amount:</strong></p>
                <p><asp:Label ID="lblAmount" runat="server" /></p>
            </div>
            <div class="bill-details-inner">
                <p><strong>Month:</strong></p>
                <p><asp:Label ID="lblMonth" runat="server" /></p>
            </div>
            <div class="bill-details-inner">
                <p><strong>Paid Date:</strong></p>
                <p><asp:Label ID="lblPaidDate" runat="server" /></p>
            </div>
            <div class="bill-details-inner">
                <p><strong>Payment Method:</strong></p>
                <p><asp:Label ID="lblPaymentMethod" runat="server" /></p>
            </div>
            <div class="bill-details-inner">
                <p><strong>Paid Amount:</strong></p>
                <p><asp:Label ID="lblPaidAmount" runat="server" /></p>
            </div>
            <div class="bill-details-inner">
                <p><strong>Created At:</strong></p>
                <p><asp:Label ID="lblCreatedAt" runat="server" /></p>
            </div>
            <asp:Button ID="btnBack" runat="server" Text="Back" class="btn btn-primary bill-btn" OnClick="btnBack_Click" />
            <asp:Button ID="btnDownloadInvoice" runat="server" Text="Download Invoice" class="btn btn-success bill-btn" OnClick="btnDownloadInvoice_Click" />

        </div>
    </div>
</asp:Content>
