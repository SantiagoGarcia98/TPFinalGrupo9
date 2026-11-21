<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ListarSucursales.aspx.cs" Inherits="EsteticaWeb.Sucursales.ListarSucursales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="h4 mb-4">Listado de sucursales</h2>
    <div class="d-flex mb-3">
        <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control me-2" Style="max-width: 320px" placeholder="Buscar sucursal, DIreccion o telefono" />
        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary" />
    </div>
    <asp:GridView ID="dgvSucursales" runat="server" CssClass="table" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="Direccion" HeaderText="Direccion" />
            <asp:BoundField DataField="Telefono" HeaderText="Telefono" />
            <asp:BoundField DataField="Activo" HeaderText="Activo" />

            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <asp:HyperLink
                        ID="lnkModificar"
                        runat="server"
                        Text="Modificar"
                        NavigateUrl='<%# "ModificarSucursal.aspx?IdSucursal=" + Eval("IdSucursal") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
