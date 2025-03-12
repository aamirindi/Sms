<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="SocietyManagementSystem.UserManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


        <style>
       .container-fluid {
    padding: 20px;
    font-family: Arial, sans-serif;
}

/* Page Title */
.mt-4 {
    font-size: 5rem;
    color: #2c3e50;
    margin-bottom: 20px;
}

/* Breadcrumb Navigation */
nav a {
    color: #3498db;
    text-decoration: none;
    margin-right: 5px;
}

nav span {
    color: #7f8c8d;
}

/* Header and Add Button */
.grid-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.grid-header span {
    font-size: 1.5rem;
    font-weight: bold;
}

.grid-header a {
    padding: 8px 16px;
    background-color: #2ecc71;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    transition: background 0.3s ease;
}

.grid-header a:hover {
    background-color: #27ae60;
}

/* Grid Container */
.grid-container {
    margin-top: 20px;
}

/* GridView Styling */
.grid-container table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

.grid-container th, .grid-container td {
    padding: 12px 15px;
    border: 1px solid #ddd;
    text-align: left;
}

.grid-container th {
    background-color: #34495e;
    color: white;
    text-transform: uppercase;
}

.grid-container tr:nth-child(even) {
    background-color: #f2f2f2;
}

.grid-container tr:hover {
    background-color: #e6f7ff;
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 10px;
}

.grid-container .btn-edit {
    padding: 5px 10px;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.grid-container .btn-edit:hover {
    background-color: #2980b9;
}

.grid-container .btn-delete {
    padding: 5px 10px;
    background-color: #e74c3c;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.grid-container .btn-delete:hover {
    background-color: #c0392b;
}

/* Feedback Message */
.feedback {
    margin-top: 10px;
    color: green;
    font-weight: bold;
}
    </style>








</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>

           <div class="container-fluid px-4">
       <h1 class="mt-4" >User Management</h1>
       <nav>
           <a href="Dashboard.aspx">Dashboard</a> / 
           
           <a href="UserManagement.aspx">User Management</a> / 
           
         <span>Add Flats Management</span>
       </nav>
              
              <div >
                  <div>
                   <span>Users Managements</span> 
                 </div>
                  <div>
                   <a href="AddUser.aspx">Add</a>
                  </div>
             </div>
                
               <div>
                        <div>
                            <%--////////    show entries    //////////--%>
                        </div>
                         <%-- /////////// search by Id ///////////////--%>
                        <div>
                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            <asp:Button ID="Button3" runat="server" Text="Button" OnClick="Button3_Click" CssClass="btn btn-sm  btn-danger" />
                           
                        </div>

               </div>


               <div class="grid-container">


               
               <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowDeleting="GridView1_RowDeleting" DataKeyNames="id" OnRowEditing="GridView1_RowEditing" >
                   <Columns>
                       <asp:TemplateField HeaderText="ID">
                           <ItemTemplate> 
                               <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                           </ItemTemplate>
                       </asp:TemplateField>


                        <asp:TemplateField HeaderText="Name">
                   <ItemTemplate> 
                       <asp:Label ID="Label2" runat="server" Text='<%# Eval("name") %>'></asp:Label>
           </ItemTemplate>
        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Email">
                        <ItemTemplate> 
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("email") %>'></asp:Label>
               </ItemTemplate>
               </asp:TemplateField>


                        <asp:TemplateField HeaderText="Role">
                        <ItemTemplate> 
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("role") %>'></asp:Label>
                      </ItemTemplate>
                   </asp:TemplateField>


                        <asp:TemplateField HeaderText="CreateRole">
                  <ItemTemplate> 
                      <asp:Label ID="Label5" runat="server" Text='<%# Eval("created_at") %>'></asp:Label>
                 </ItemTemplate>
                 </asp:TemplateField>

                      <asp:TemplateField HeaderText="Actions">
               <ItemTemplate> 
                   <asp:Button ID="Button1" runat="server" Text="Edit" CommandName="edit" CssClass="btn btn-sm btn-info"  />
                   <asp:Button ID="Button2" runat="server" Text="Delete" CommandName="Delete" CssClass="btn btn-sm  btn-danger"  CommandArgument='<%#Eval("id") %>'/>
                </ItemTemplate>
           </asp:TemplateField>



                   </Columns>
               </asp:GridView>

                   </div>


    </section>
</asp:Content>
<%--<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="SocietyManagementSystem.UserManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>--%>
