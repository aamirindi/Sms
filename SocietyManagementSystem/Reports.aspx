<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="SocietyManagementSystem.Reports" MasterPageFile="~/AdminMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Head content (e.g., CSS, scripts) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Main content -->
    <div class="container-fluid px-4">
        <h1 class="mt-4">Reports</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
            <li class="breadcrumb-item active">Reports</li>
        </ol>

        <!-- Error Messages -->
        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false"></asp:Label>

        <!-- Report Filters -->
        <div class="card">
            <div class="card-header">
                <h5 class="card-title">Generate Report</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <label for="ddlReportType">Report For</label>
                        <asp:DropDownList ID="ddlReportType" runat="server" CssClass="form-control">
                            <asp:ListItem Value="">Select</asp:ListItem>
                            <asp:ListItem Value="Bill">Bill</asp:ListItem>
                            <asp:ListItem Value="Complaint">Complaint</asp:ListItem>
                            <asp:ListItem Value="Visitor">Visitor</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label for="txtStartDate">Start Date</label>
                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label for="txtEndDate">End Date</label>
                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" CssClass="btn btn-primary mt-4" OnClick="btnGenerateReport_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Report Output -->
        <asp:Panel ID="pnlReportOutput" runat="server" Visible="false">
            <div class="card mt-3">
                <div class="card-header">
                    <div class="row">
                        <div class="col-md-9">
                            <h5 class="card-title" runat="server" id="lblReportTitle"></h5>
                        </div>
                        <div class="col-md-3">
                            <asp:Button ID="btnExport" runat="server" Text="Export" CssClass="btn btn-success btn-sm float-end" OnClick="btnExport_Click" />
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="gvReport" runat="server" CssClass="table table-bordered" AutoGenerateColumns="true">
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
<%--<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="SocietyManagementSystem.Reports" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid px-4">
            <h1 class="mt-4">Reports</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Reports</li>
            </ol>

            <!-- Error Messages -->
            <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false"></asp:Label>

            <!-- Report Filters -->
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Generate Report</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <label for="ddlReportType">Report For</label>
                            <asp:DropDownList ID="ddlReportType" runat="server" CssClass="form-control">
                                <asp:ListItem Value="">Select</asp:ListItem>
                                <asp:ListItem Value="Bill">Bill</asp:ListItem>
                                <asp:ListItem Value="Complaint">Complaint</asp:ListItem>
                                <asp:ListItem Value="Visitor">Visitor</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3">
                            <label for="txtStartDate">Start Date</label>
                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <label for="txtEndDate">End Date</label>
                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" CssClass="btn btn-primary mt-4" OnClick="btnGenerateReport_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Report Output -->
            <asp:Panel ID="pnlReportOutput" runat="server" Visible="false">
                <div class="card mt-3">
                    <div class="card-header">
                        <div class="row">
                            <div class="col-md-9">
                                <h5 class="card-title" runat="server" id="lblReportTitle"></h5>
                            </div>
                            <div class="col-md-3">
                                <asp:Button ID="btnExport" runat="server" Text="Export" CssClass="btn btn-success btn-sm float-end" OnClick="btnExport_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:GridView ID="gvReport" runat="server" CssClass="table table-bordered" AutoGenerateColumns="true">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>--%>
