<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="FlatsManagement.aspx.cs" Inherits="SocietyManagementSystem.FlatsManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container mt-4">
        <h2 class="mb-4">Flats Management</h2>
         <nav>
             <a href="Dashboard.aspx">Dashboard</a> / 
             <a href="FlatsManagement.aspx">Flats Management</a> 
     
         </nav>
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span>Flats Management</span>
                <asp:Button ID="btnAddFlat" runat="server" CssClass="btn btn-success" Text="Add Flat" OnClick="btnAddFlat_Click" />
            </div>
            <div class="card-body">
                <br />
                <asp:GridView ID="GridViewFlats" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="false" DataKeyNames="id"
                    OnRowEditing="GridViewFlats_RowEditing" OnRowDeleting="GridViewFlats_RowDeleting" OnSelectedIndexChanged="GridViewFlats_SelectedIndexChanged" Height="237px" Width="1065px">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="flat_number" HeaderText="Flat Number" />
                        <asp:BoundField DataField="floor" HeaderText="Floor Number" />
                        <asp:BoundField DataField="block_number" HeaderText="Block Number" />
                        <asp:BoundField DataField="flat_type" HeaderText="Type" />
                        <asp:BoundField DataField="created_at" HeaderText="Created At" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-primary btn-sm" CommandName="Edit" Text="Edit" />
                                <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm" CommandName="Delete" Text="Delete" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

