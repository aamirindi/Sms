<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="SocietyManagementSystem.UserDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
        }

        .dashboard-box {
            width: 300px;
            height: 150px;
            color: white;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-radius: 10px;
            font-size: 18px;
            box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2);
            font-weight: bold;
        }

        .bills {
            background-color: #4e69a2; /* Blue */
        }

        .complaints {
            background-color: #e74c3c; /* Red */
        }

        .visitors {
            background-color: #2ecc71; /* Green */
        }

        .dashboard-box h3 {
            margin: 0;
            font-size: 3rem;
            color: #e5e5e5;
        }

        .dashboard-box p {
            margin: 5px 0 0;
            font-size: 22px;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>User Dashboard</h2>

    <div class="dashboard-container">
        <div class="dashboard-box bills">
            <h3>Bills</h3>
            <p>
                <asp:Label ID="lblBillsCount" runat="server" Text="0"></asp:Label>
            </p>
        </div>

        <div class="dashboard-box complaints">
            <h3>Complaints</h3>
            <p>
                <asp:Label ID="lblComplaintsCount" runat="server" Text="0"></asp:Label>
            </p>
        </div>

        <div class="dashboard-box visitors">
            <h3>Visitors</h3>
            <p>
                <asp:Label ID="lblVisitorsCount" runat="server" Text="0"></asp:Label>
            </p>
        </div>
    </div>
</asp:Content>