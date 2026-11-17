<%@ Page Title="ModUsuario" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ModificarUsuario.aspx.cs" Inherits="EsteticaWeb.Usuarios.ModificarUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1 class="h3 mb-3">Modificar Usuario</h1>
    <h2 class="h4 mb-4">Listado de usuarios registrados</h2>
    <asp:GridView ID="dgvUsuarios" runat="server" CssClass="table" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="User" HeaderText="Usuario" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Pass" HeaderText="Contraseña" />
            <asp:BoundField DataField="Baja" HeaderText="Baja" />
            <asp:BoundField DataField="TipoUsuarioId" HeaderText="Tipo" />
            <asp:BoundField DataField="Rol" HeaderText="Rol" />
        </Columns>
    </asp:GridView>

    <div class="mb-3">
        <label class="form-label">Tabla a modificar</label>

        <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged">
            <asp:ListItem Text="Seleccione..." Value="" />
            <asp:ListItem Text="Usuario" Value="Usuario" />
            <asp:ListItem Text="Cliente" Value="Cliente" />
        </asp:DropDownList>
    </div>

    <asp:Panel ID="pnlUsuario" runat="server" Visible="false">
        <h4>Datos de Usuario</h4>

        <div class="mb-3">
            <label>Pass</label>
            <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" />
        </div>

        <label>Baja</label>
        <asp:DropDownList ID="ddlBaja" runat="server" CssClass="form-select">
            <asp:ListItem Text="No cambiar" Value="" />
            <asp:ListItem Text="Activo" Value="false" />
            <asp:ListItem Text="De baja" Value="true" />
        </asp:DropDownList>

        <div class="mb-3">
            <label>Tipo Usuario</label>
            <asp:DropDownList ID="ddlTipoUsuario" runat="server" CssClass="form-select">
                <asp:ListItem Text="Seleccione..." Value="" />
                <asp:ListItem Text="Administrador" Value="1" />
                <asp:ListItem Text="Recepcionista" Value="2" />
                <asp:ListItem Text="Cliente" Value="3" />
                <asp:ListItem Text="Profesional" Value="4" />
            </asp:DropDownList>
        </div>
    </asp:Panel>


    <asp:Panel ID="pnlCliente" runat="server" Visible="false">
        <h4>Datos de Cliente</h4>

        <div class="mb-3">
            <label>Nombre</label>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
        </div>

        <div class="mb-3">
            <label>Apellido</label>
            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
        </div>

        <div class="mb-3">
            <label>DNI</label>
            <asp:TextBox ID="TxtDni" runat="server" CssClass="form-control" />
        </div>

        <div class="mb-3">
            <label>Telefono</label>
            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
        </div>

    </asp:Panel>

    <asp:Label ID="lblMensaje"
        runat="server"
        CssClass="text-danger"
        Visible="false">
    </asp:Label>
    <asp:Button ID="btnModificar" runat="server" Text="Modificar" OnClick="btnModificar_Click" CssClass="btn btn-primary" Visible="false" />
    <asp:Label ID="LabelMensajeActualizado"
        runat="server"
        CssClass="text-danger"
        Visible="false">
    </asp:Label>


    <asp:HyperLink ID="lnkVolverMenu" runat="server" NavigateUrl="~/PanelAdmin.aspx" CssClass="btn btn-outline-secondary">Volver al menú</asp:HyperLink>


</asp:Content>
