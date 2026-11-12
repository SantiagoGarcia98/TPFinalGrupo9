<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionMaster.Master" AutoEventWireup="true" CodeBehind="ListaTurnos.aspx.cs" Inherits="EsteticaWeb.ListaTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView runat="server" ID="dgvTurnos" AutoGenerateColumns="false" CssClass="table">
        <Columns>

            <asp:BoundField HeaderText="Fecha" DataField="fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
            <asp:BoundField HeaderText="Precio" DataField="precio" DataFormatString="" />

            <asp:BoundField HeaderText="Cliente" DataField="cliente.Nombre" />
            <asp:BoundField HeaderText="Profesional" DataField="Profesional.Nombre" />
            <asp:BoundField HeaderText="Sucursal" DataField="Sucursal.Nombre" />
            <asp:CommandField headertext="Modificar" ShowSelectButton="true" />      
        </Columns>
    </asp:GridView>

</asp:Content>
