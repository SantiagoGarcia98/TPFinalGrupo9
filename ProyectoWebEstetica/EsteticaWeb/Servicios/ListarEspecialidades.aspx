<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ListarEspecialidades.aspx.cs" Inherits="EsteticaWeb.Servicios.ListarEspecialidades" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="h4 mb-4">Listado de especialidades registradas</h2>
<div class="d-flex mb-3">
    <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control me-2" Style="max-width: 320px" placeholder="Buscar Especialidad" />
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary" />
</div>
<asp:GridView ID="dgvEspecialidades" runat="server" CssClass="table" AutoGenerateColumns="false">
    <Columns>
        <asp:BoundField DataField="idEspecialidad" HeaderText="id" />
        <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
        <asp:BoundField DataField="Precio" HeaderText="Precio" />
        <asp:BoundField DataField="Activo" HeaderText="Activo" />
        <asp:TemplateField HeaderText="Acciones">
            <ItemTemplate>
                <asp:HyperLink
                    ID="lnkModificar"
                    runat="server"
                    Text="Modificar"
                    NavigateUrl='<%# "ModificarEspecialidades.aspx?id=" + Eval("idEspecialidad") %>' />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
</asp:Content>
