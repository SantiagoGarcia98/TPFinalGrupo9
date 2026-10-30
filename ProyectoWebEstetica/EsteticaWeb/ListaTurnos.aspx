<%@ Page Title="" Language="C#" MasterPageFile="~/MiMaster.Master" AutoEventWireup="true" CodeBehind="ListaTurnos.aspx.cs" Inherits="EsteticaWeb.ListaTurnos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
    </p>
    <asp:Panel ID="pnlTituloTurnos" runat="server" HorizontalAlign="Center" Width="100%" Wrap="False">
        <asp:Label ID="lblTituloTurnos" runat="server" Text="Mis turnos" Font-Bold="True" Font-Size="24pt"></asp:Label>
    </asp:Panel>
    <p>
    </p>
    <p>
        <asp:GridView ID="gvTurnosCliente" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="gvTurnosCliente_SelectedIndexChanged" Width="100%">
            <Columns>
                <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
                <asp:BoundField DataField="Horario" HeaderText="Horario" />
                <asp:BoundField DataField="Tratamiento" HeaderText="Tratamiento" />
                <asp:BoundField DataField="Profesional" HeaderText="Profesional" />
                <asp:BoundField DataField="Estado" HeaderText="Estado" />
            </Columns>
        </asp:GridView>
    </p>
    <p>
        <asp:HyperLink ID="lnkVolverMenu" runat="server" NavigateUrl="~/MenuCliente.aspx">Volver al menú</asp:HyperLink>
    </p>
    <p>
    </p>
    <p>
        &nbsp;</p>
    <p>
    </p>
    <p>
    </p>
    <p>
    </p>
    <p>
    </p>
    <p>
    </p>
    <p>
    </p>
    <p>
    </p>
    <p>
    </p>
    <p>
    </p>
</asp:Content>
