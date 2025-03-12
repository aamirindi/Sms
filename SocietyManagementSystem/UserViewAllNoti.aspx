<%@ Page Title="" Language="C#" MasterPageFile="~/UserMaster.Master" AutoEventWireup="true" CodeBehind="UserViewAllNoti.aspx.cs" Inherits="SocietyManagementSystem.UserViewAllNoti" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .notification-item {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            transition: background-color 0.3s ease-in-out;
        }

        .notification-item .unread {
            font-weight: bold;
            color: #007bff;
            text-decoration: none;
            cursor: pointer;
        }

        .notification-item .read {
            color: #6c757d;
            text-decoration: none;
            cursor: pointer;
        }

        .notification-item:hover {
            background-color: #f1f1f1;
        }

        .notification-item .unread:hover {
            text-decoration: underline;
            color: #0056b3;
        }

        .notification-item .read:hover {
            text-decoration: underline;
            color: #495057;
        }

        h2 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #333;
        }

        .notification-container {
            max-width: 500px;
            margin: 20px auto;
            padding: 15px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        .pagination {
            text-align: center;
            margin-top: 15px;
        }

        .btn-pagination {
            padding: 8px 16px;
            margin: 5px;
            border: none;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }

        .btn-pagination:hover {
            background-color: #0056b3;
        }

        .view-btn {
            color: black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row-all-noti">
        <h2>All Notifications</h2>
        <div class="notification-container">
            <asp:Repeater ID="rptAllNotifications" runat="server" OnItemCommand="rptAllNotifications_ItemCommand">
                <ItemTemplate>
                    <div class="notification-item">
                        <p class='<%# Eval("read_status").ToString() == "read" ? "read" : "unread" %>'>
                            <%# Eval("message") %>
                        </p>
                        <asp:HiddenField ID="hfNotificationLink" runat="server" Value='<%# Eval("link") %>' />
                        <asp:LinkButton ID="btnViewNotification" runat="server" CommandName="Select" CommandArgument='<%# Eval("id") %>' class="view-btn">
                            View Details
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <!-- Pagination Controls -->
        <div class="pagination">
            <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn-pagination" OnClick="btnPrevious_Click" />
            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn-pagination" OnClick="btnNext_Click" />
        </div>
    </div>
</asp:Content>
