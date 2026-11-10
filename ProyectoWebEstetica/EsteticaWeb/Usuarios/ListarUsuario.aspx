<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ListarUsuario.aspx.cs" Inherits="EsteticaWeb.Usuarios.ListarUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="h3 mb-3">Lista Usuarios</h1>
    <h2 class="h4 mb-4">Listado de usuarios registrados</h2>
    <asp:GridView ID="dgvUsuarios" runat="server" CssClass="table" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="User" HeaderText="Usuario" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Rol" HeaderText="Rol" />
        </Columns>
    </asp:GridView>
</asp:Content>
