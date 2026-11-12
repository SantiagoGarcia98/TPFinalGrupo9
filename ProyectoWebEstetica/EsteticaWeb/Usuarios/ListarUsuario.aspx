<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ListarUsuario.aspx.cs" Inherits="EsteticaWeb.Usuarios.ListarUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="h3 mb-3">Lista Usuarios</h1>
    <h2 class="h4 mb-4">Listado de usuarios registrados</h2>
    <div class="d-flex mb-3">
        <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control me-2" Style="max-width: 320px" placeholder="Buscar usuario, email o rol" />
        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary" />
    </div>
    <asp:GridView ID="dgvUsuarios" runat="server" CssClass="table" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="User" HeaderText="Usuario" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Rol" HeaderText="Rol" />
            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <asp:HyperLink
                        ID="lnkModificar"
                        runat="server"
                        Text="Modificar"
                        NavigateUrl='<%# "ModificarUsuario.aspx?id=" + Eval("Id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
