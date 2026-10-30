<%@ Page Title="" Language="C#" MasterPageFile="~/MiMaster.Master" AutoEventWireup="true" CodeBehind="SolicitudTurno.aspx.cs" Inherits="EsteticaWeb.SolicitudTurno" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlTituloSolicitud" runat="server" HorizontalAlign="Center" Width="100%">
        <asp:Label ID="lblTituloSolicitud" runat="server" Text="Solicitud de turno" Font-Bold="True" Font-Size="24pt"></asp:Label>
    </asp:Panel>
    <p>
        <br />
        <asp:Label ID="lblfTratamiento" runat="server" Font-Bold="True" Text="Tratamiento:"></asp:Label>
        <asp:DropDownList ID="ddlTratamiento" runat="server" style="margin-left: 30px" Width="250px">
        </asp:DropDownList>
    </p>
    <p>
        <asp:Label ID="lblProfesional" runat="server" Font-Bold="True" Text="Profesional: "></asp:Label>
        <asp:DropDownList ID="ddlProfesional" runat="server" style="margin-left: 32px" Width="250px">
        </asp:DropDownList>
    </p>
    <p>
        <asp:Label ID="lblFechaTurno" runat="server" Font-Bold="True" Text="Fecha del turno:"></asp:Label>
    </p>
    <asp:Calendar ID="calFechaTurno" runat="server" ShowGridLines="True" Width="300px"></asp:Calendar>
    <br />
    <asp:Label ID="lblHorarioturno" runat="server" Font-Bold="True" Text="Horario del turno:"></asp:Label>
    <asp:DropDownList ID="ddHorarioTurno" runat="server" style="margin-left: 5px" Width="250px">
    </asp:DropDownList>
    <br />
    <br />
    <asp:Panel ID="pnlBotonesSolicitud" runat="server" HorizontalAlign="Center" Width="100%">
        <asp:Button ID="btnSolicitarTurno" runat="server" BackColor="#99CCFF" CausesValidation="False" Text="Solicitar turno" Width="200px" />
    </asp:Panel>
    <asp:HyperLink ID="lnkVolverMEnu" runat="server" NavigateUrl="~/MenuCliente.aspx">Volver al menú</asp:HyperLink>
    <br />
    <br />
    <br />
    <br />
    <p>
        &nbsp;</p>
</asp:Content>
