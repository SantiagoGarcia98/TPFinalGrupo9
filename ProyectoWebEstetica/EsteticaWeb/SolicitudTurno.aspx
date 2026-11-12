<%@ Page Title="Solicitud de turno" Language="C#" MasterPageFile="~/MiMaster.Master" AutoEventWireup="true" CodeBehind="SolicitudTurno.aspx.cs" Inherits="EsteticaWeb.SolicitudTurno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="pnlTituloSolicitud" runat="server"
        HorizontalAlign="Center" Width="100%">

        <asp:Label
            ID="lblTituloSolicitud"
            runat="server"
            Text="Solicitud de turno"
            Font-Bold="True"
            Font-Size="24pt">
        </asp:Label>

    </asp:Panel>

    <br />
    <br />

    <p>
        <asp:Label
            ID="lblfTratamiento"
            runat="server"
            Font-Bold="True"
            Text="Tratamiento:">
        </asp:Label>

        <asp:DropDownList
            ID="ddlTratamiento"
            runat="server"
            Width="250px"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlTratamiento_SelectedIndexChanged">
        </asp:DropDownList>
    </p>

    <br />


    <p>
        <asp:Label
            ID="lblProfesional"
            runat="server"
            Font-Bold="True"
            Text="Profesional:">
        </asp:Label>

        <asp:DropDownList
            ID="ddlProfesional"
            runat="server"
            Width="250px"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlProfesional_SelectedIndexChanged">
        </asp:DropDownList>
    </p>

    <br />


    <p>
        <asp:Label
            ID="lblFechaTurno"
            runat="server"
            Font-Bold="True"
            Text="Fecha del turno:">
        </asp:Label>
    </p>

    <asp:Calendar
        ID="calFechaTurno"
        runat="server"
        ShowGridLines="True"
        Width="300px"
        OnSelectionChanged="calFechaTurno_SelectionChanged"></asp:Calendar>

    <br />
    <br />

    <p>
        <asp:Label
            ID="lblHorarioturno"
            runat="server"
            Font-Bold="True"
            Text="Horario del turno:">
        </asp:Label>

        <asp:DropDownList
            ID="ddHorarioTurno"
            runat="server"
            Width="250px">
        </asp:DropDownList>
    </p>

    <br />
    <br />


    <asp:Panel
        ID="pnlBotonesSolicitud"
        runat="server"
        HorizontalAlign="Center"
        Width="100%">

        <asp:Button
            ID="btnSolicitarTurno"
            runat="server"
            BackColor="#99CCFF"
            CausesValidation="False"
            Text="Solicitar turno"
            Width="200px"
            OnClick="btnSolicitarTurno_Click" />
        <br />
        <br />
        <asp:Label ID="lblMensajeTurno" runat="server"
            Font-Bold="True"
            Text="">
        </asp:Label>


    </asp:Panel>

    <br />

    <asp:HyperLink
        ID="lnkVolverMEnu"
        runat="server"
        NavigateUrl="~/MenuCliente.aspx">
        Volver al menú
    </asp:HyperLink>

    <br />
    <br />

</asp:Content>
