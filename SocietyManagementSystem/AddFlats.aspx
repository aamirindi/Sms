<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddFlats.aspx.cs" Inherits="SocietyManagementSystem.AddFlats" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
   <section class="content">
        <div class="row">
       <h2>Add Flats</h2>
       <nav>
           <a href="Dashboard.aspx">Dashboard</a> / 
           
           <a href="FlatsManagement.aspx">Flats Management</a> / 
           
           <span>Add Flats Management</span>
       </nav>

            <div class="form-group">
                Flat Number:
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                <br />

                Floor:
                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
                <br />

                Block Number:
                <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control"></asp:TextBox>
                <br />

                Type:
                <asp:DropDownList ID="ddl1" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">Select Type</asp:ListItem>
                    <asp:ListItem Value="1BHK">1 BHK Flat</asp:ListItem>
                    <asp:ListItem Value="2BHK">2 BHK Flat</asp:ListItem>
                    <asp:ListItem Value="3BHK">3 BHK Flat</asp:ListItem>
                </asp:DropDownList>
                <br />

                <asp:Button ID="btnAddFlat" runat="server" OnClick="btnAddFlat_Click" Text="Add Flat" CssClass="btn btn-primary" />
            </div>

        </div>
    </section>

</asp:Content>
