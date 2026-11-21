<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ModificarSucursal.aspx.cs" Inherits="EsteticaWeb.Sucursales.ModificarSucursal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1 class="h3 mb-3">Modificar sucursal</h1>
    <h2 class="h4 mb-4">Lista de sucursal elegida</h2>
    <asp:GridView ID="dgvSuc" runat="server" CssClass="table" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="Direccion" HeaderText="Direccion" />
            <asp:BoundField DataField="Telefono" HeaderText="Telefono" />
            <asp:BoundField DataField="Activo" HeaderText="Activo" />
        </Columns>
    </asp:GridView>

    <div class="container my-5">
        <div class="bg-white border rounded-3 shadow-sm p-4 mx-auto" style="max-width: 640px;">

            <div class="mb-3">
                <label>Nombre</label>
                <asp:TextBox ID="txtNombreSuc" runat="server" CssClass="form-control" />
            </div>

            <div class="mb-3">
                <label>Direccion</label>
                <asp:TextBox ID="txtDireccionSuc" runat="server" CssClass="form-control" />
            </div>

            <div class="mb-3">
                <label>Telefono</label>
                <asp:TextBox ID="txtTelefonoSuc" runat="server" CssClass="form-control" />
            </div>

            <label>Activo</label>
            <asp:DropDownList ID="ddlActivoSuc" runat="server" CssClass="form-select">
                <asp:ListItem Text="No cambiar" Value="" />
                <asp:ListItem Text="Activo" Value="true" />
                <asp:ListItem Text="De baja" Value="false" />
            </asp:DropDownList>

        </div>
    </div>

    <asp:Button ID="btnModificar" runat="server" Text="Modificar" OnClick="btnModificar_Click" CssClass="btn btn-primary" Visible="true" />
    <asp:Label ID="LabelMensajeActualizado"
        runat="server"
        CssClass="text-danger"
        Visible="false">
    </asp:Label>


    <asp:HyperLink ID="lnkVolverMenu" runat="server" NavigateUrl="~/PanelAdmin.aspx" CssClass="btn btn-outline-secondary">Volver al menú</asp:HyperLink>

</asp:Content>
