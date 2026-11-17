<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ModificarEspecialidades.aspx.cs" Inherits="EsteticaWeb.Servicios.ModificarEspecialidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
        <div class="bg-white border rounded-3 shadow-sm p-4 mx-auto" style="max-width: 640px;">
            <h1 class="h3 mb-3">Modificar Usuario</h1>
            <h2 class="h4 mb-4">Listado de usuarios registrados</h2>
            <asp:GridView ID="dgvUsuarios" runat="server" CssClass="table" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
                    <asp:BoundField DataField="Precio" HeaderText="Precio" />
                    <asp:BoundField DataField="Activo" HeaderText="Activo" />
                    <asp:BoundField DataField="DuracionMinutos" HeaderText="DuracionMinutos" />

                </Columns>
            </asp:GridView>

            <div class="mb-3">
                <label>Descripcion</label>
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" />
            </div>

            <div class="mb-3">
                <label>Precio</label>
                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" />
            </div>

            <label>Activo</label>
            <asp:DropDownList ID="ddlActivo" runat="server" CssClass="form-select">
                <asp:ListItem Text="No cambiar" Value="" />
                <asp:ListItem Text="Activo" Value="true" />
                <asp:ListItem Text="De baja" Value="false" />
            </asp:DropDownList>

            <div class="mb-3">
                <label>duracionMinutos</label>
                <asp:TextBox ID="txtDuracion" runat="server" CssClass="form-control" />
            </div>


            <asp:Button ID="btnModificar" runat="server" Text="Modificar" OnClick="btnModificar_Click" CssClass="btn btn-primary" Visible="true" />

            <asp:Label ID="LabelMensajeActualizado"
                runat="server"
                CssClass="text-danger"
                Visible="false">
            </asp:Label>


            <asp:HyperLink ID="lnkVolverMenu" runat="server" NavigateUrl="~/PanelAdmin.aspx" CssClass="btn btn-outline-secondary">Volver al menú</asp:HyperLink>

        </div>
    </div>
</asp:Content>

