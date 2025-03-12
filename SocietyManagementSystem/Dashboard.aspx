<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/AdminMaster.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="SocietyManagementSystem.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Dashboard</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Dashboard</li>
        </ol>
        <div class="row">
            <asp:Panel ID="pnlAdmin" runat="server" Visible="false">
                <div class="col-xl-3 col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Flats</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblTotalFlats" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Bills</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblTotalBills" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Allotments</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblTotalAllotments" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total In-Progress Complaints</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblTotalInProgressComplaints" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mt-3">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Visitors</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblTotalVisitors" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mt-3">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Unresolved Complaints</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblTotalUnresolvedComplaints" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mt-3">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Resolved Complaints</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblTotalResolvedComplaints" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mt-3">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Complaints</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblTotalComplaints" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlUser" runat="server" Visible="false">
                <div class="col-xl-4 col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total In-Progress Complaints</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblUserTotalInProgressComplaints" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-md-6 mt-3">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Unresolved Complaints</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblUserTotalUnresolvedComplaints" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-md-6 mt-3">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Resolved Complaints</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblUserTotalResolvedComplaints" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-md-6 mt-3">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Complaints</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblUserTotalComplaints" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-md-6 mt-3">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Bills</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblUserTotalBills" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-md-6 mt-3">
                    <div class="card">
                        <div class="card-header">
                            <h5>Total Visitors</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><asp:Label ID="lblUserTotalVisitors" runat="server"></asp:Label></p>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
