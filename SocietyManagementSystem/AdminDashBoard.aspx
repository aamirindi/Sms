<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="SocietyManagementSystem.AdminDashboard" %>
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

        .users { background-color: #3498db; }      /* Blue */
        .flats { background-color: #9b59b6; }      /* Purple */
        .allotments { background-color: #f39c12; } /* Orange */
        .bills { background-color: #4e69a2; }      /* Dark Blue */
        .complaints { background-color: #e74c3c; } /* Red */
        .visitors { background-color: #2ecc71; }   /* Green */

        .dashboard-box h3 {
            margin: 0;
            font-size: 2rem;
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
    <h2>Admin Dashboard</h2>
    
    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Allotments by Month</h3>
                </div>
                <div class="panel-body">
                    <div style="height: 300px;">
                        <canvas id="allotmentsBarChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Bill Payment Status</h3>
                </div>
                <div class="panel-body">
                    <div style="height: 300px;">
                        <canvas id="billsPaymentPieChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="dashboard-container">
        <div class="dashboard-box users">
            <h3>Users</h3>
            <p>
                <asp:Label ID="lblUsersCount" runat="server" Text="0"></asp:Label>
            </p>
        </div>
        <div class="dashboard-box flats">
            <h3>Flats</h3>
            <p>
                <asp:Label ID="lblFlatsCount" runat="server" Text="0"></asp:Label>
            </p>
        </div>
        <div class="dashboard-box allotments">
            <h3>Allotments</h3>
            <p>
                <asp:Label ID="lblAllotmentsCount" runat="server" Text="0"></asp:Label>
            </p>
        </div>
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