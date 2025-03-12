<%@ Page Title="Admin Meetings" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminMeetings.aspx.cs" Inherits="SocietyManagementSystem.AdminMeetings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Manage Meetings</h1>
    <div>
        <h2>Create New Meeting</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <div>
            <label>Title:</label>
            <asp:TextBox ID="txtTitle" runat="server" required="true"></asp:TextBox>
        </div>
        <div>
            <label>Description:</label>
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" required="true"></asp:TextBox>
        </div>
        <div>
            <label>Date:</label>
            <asp:TextBox ID="txtDate" runat="server" TextMode="Date" required="true"></asp:TextBox>
        </div>
        <div>
            <label>Time:</label>
            <asp:TextBox ID="txtTime" runat="server" TextMode="Time" required="true"></asp:TextBox>
        </div>
        <div>
            <asp:Button ID="btnCreateMeeting" runat="server" Text="Create Meeting" OnClick="btnCreateMeeting_Click" />
        </div>
    </div>

    <div>
        <h2>Upcoming Meetings</h2>
        <asp:GridView ID="gvMeetings" runat="server" AutoGenerateColumns="false" OnRowCommand="gvMeetings_RowCommand">
            <Columns>
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="MeetingDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="MeetingTime" HeaderText="Time" DataFormatString="{0:HH:mm}" />
                <asp:BoundField DataField="CreatedByName" HeaderText="Created By" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteMeeting" CommandArgument='<%# Eval("Id") %>' OnClientClick="return confirm('Are you sure you want to delete this meeting?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content><%--<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminMeetings.aspx.cs" Inherits="SocietyManagementSystem.AdminMeetings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>--%>
