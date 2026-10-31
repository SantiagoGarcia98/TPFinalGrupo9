<%@ Page Title="" Language="C#" MasterPageFile="~/MiMaster.Master" AutoEventWireup="true" CodeBehind="MenuCliente.aspx.cs" Inherits="EsteticaWeb.MenuCliente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlBienvenida" runat="server" HorizontalAlign="Center">
        <asp:Label ID="lblBienvenida" runat="server" CssClass="text-center" Font-Bold="True" Font-Size="24pt" style="text-align: center" Text="Bienvenido a EstetiMed"></asp:Label>
    </asp:Panel>
    <br />
    <asp:Panel ID="Panel1" runat="server">
    </asp:Panel>
    <asp:Panel ID="pnlSolicitarTurno" runat="server" HorizontalAlign="Center">
    <asp:Button ID="btnSolicitarTurno" runat="server" CausesValidation="False" Text="Solicitar Turno" BackColor="#99CCFF" Width="200px" PostBackUrl="~/SolicitudTurno.aspx" />
        <asp:Panel ID="pnlMisTurnos" runat="server">
    <asp:Button ID="btnMisTurnos" runat="server" BackColor="#99CCFF" CausesValidation="False" Text="Mis turnos" Width="200px" PostBackUrl="~/ListaTurnos.aspx" />
        </asp:Panel>
    </asp:Panel>
</asp:Content>
