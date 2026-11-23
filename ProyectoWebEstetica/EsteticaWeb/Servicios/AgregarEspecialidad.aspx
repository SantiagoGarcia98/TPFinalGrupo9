<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AgregarEspecialidad.aspx.cs" Inherits="EsteticaWeb.Servicios.AgregarEspecialidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlTituloAltaEspecialidad" runat="server" HorizontalAlign="Center" Width="100%">
        <asp:Label ID="lblAltaEspecialidad" runat="server" Text="Creacion Nuevo Servicio " Font-Bold="True" Font-Size="24pt"></asp:Label>
    </asp:Panel>
    <div class="container my-5">
        <div class="bg-white border rounded-3 shadow-sm p-4 mx-auto" style="max-width: 640px;">
            <div class="mb-3">
                <label class="form-label fw-bold">Descripcion</label>
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server"
                    ControlToValidate="txtDescripcion"
                    ErrorMessage="La descripción es obligatoria."
                    CssClass="text-danger small" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revDescripcion" runat="server"
                    ControlToValidate="txtDescripcion"
                    ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s]+$"
                    ErrorMessage="La descripción solo admite letras y números."
                    CssClass="text-danger small" Display="Dynamic" />
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Precio</label>
                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvPrecio" runat="server"
                    ControlToValidate="txtPrecio"
                    ErrorMessage="El precio es obligatorio."
                    CssClass="text-danger small" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revPrecio" runat="server"
                    ControlToValidate="txtPrecio"
                    ValidationExpression="^\d+([.,]\d{1,2})?$"
                    ErrorMessage="El precio debe ser un número, con hasta 2 decimales."
                    CssClass="text-danger small" Display="Dynamic" />
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Duracion</label>
                <asp:TextBox ID="txtDuracion" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvDuracion" runat="server"
                    ControlToValidate="txtDuracion"
                    ErrorMessage="La duración es obligatoria."
                    CssClass="text-danger small" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revDuracion" runat="server"
                    ControlToValidate="txtDuracion"
                    ValidationExpression="^[1-9]\d{0,2}$"
                    ErrorMessage="La duración debe ser entre 1 y 999 minutos."
                    CssClass="text-danger small" Display="Dynamic" />
            </div>
            <asp:Label ID="LabelMensajeActualizado" runat="server" CssClass="text-danger d-block mb-2" Visible="false"></asp:Label>
            <div class="d-flex justify-content-center gap-3">
                <asp:Button ID="btnAgregar" runat="server" Text="Agregar" OnClick="btnAgregar_Click" CssClass="btn btn-primary" />
                <asp:HyperLink ID="lnkVolverMenu" runat="server" NavigateUrl="~/PanelAdmin.aspx" CssClass="btn btn-outline-secondary">Volver al menú</asp:HyperLink>
            </div>
        </div>
    </div>

</asp:Content>
