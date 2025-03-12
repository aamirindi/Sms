<%@ Page Title="Meeting Notifications" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="UserMeetings.aspx.cs" Inherits="SocietyManagementSystem.UserMeetings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Meeting Notifications</h1>
    <asp:GridView ID="gvNotifications" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:BoundField DataField="MeetingDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="MeetingTime" HeaderText="Time" DataFormatString="{0:HH:mm}" />
            <asp:BoundField DataField="ReadStatus" HeaderText="Status" />
        </Columns>
    </asp:GridView>
</asp:Content>
<%--<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="UserMeetings.aspx.cs" Inherits="SocietyManagementSystem.UserMeetings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>--%>
