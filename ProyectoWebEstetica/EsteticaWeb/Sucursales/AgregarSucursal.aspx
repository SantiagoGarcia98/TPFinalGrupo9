<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AgregarSucursal.aspx.cs" Inherits="EsteticaWeb.Sucursales.AgregarSucursal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlTituloAltaSucursal" runat="server" HorizontalAlign="Center" Width="100%">
        <asp:Label ID="lblAltaSucursal" runat="server" Text="Agregar sucursal " Font-Bold="True" Font-Size="24pt"></asp:Label>
    </asp:Panel>
    <div class="container my-5">
        <div class="bg-white border rounded-3 shadow-sm p-4 mx-auto" style="max-width: 640px;">
            <div class="mb-3">
                <label class="form-label fw-bold">Nombre</label>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Direccion</label>
                <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Telefono</label>
                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
            </div>
            <asp:Label ID="LabelMensajeActualizado" runat="server" CssClass="text-danger d-block mb-2" Visible="false"></asp:Label>
            <div class="d-flex justify-content-center gap-3">
                <asp:Button ID="btnAgregar" runat="server" Text="Agregar" OnClick="btnAgregar_Click" CssClass="btn btn-primary" />
                <asp:HyperLink ID="lnkVolverMenu" runat="server" NavigateUrl="~/PanelAdmin.aspx" CssClass="btn btn-outline-secondary">Volver al menú</asp:HyperLink>
            </div>
        </div>
</asp:Content>
