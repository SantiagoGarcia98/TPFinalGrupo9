<%@ Page Title="Solicitud de turno" Language="C#" MasterPageFile="~/MiMaster.Master" AutoEventWireup="true" CodeBehind="SolicitudTurno.aspx.cs" Inherits="EsteticaWeb.SolicitudTurno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .contenedor-volver {
            max-width: 1100px;
            margin: 25px auto;
        }

        .btn-volver-menu {
            display: inline-block;
            padding: 12px 24px;
            background-color: #f8f1ff;
            color: #512b79;
            border: 1px solid #d9c5ee;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-volver-menu:hover {
            background-color: #512b79;
            color: white;
            text-decoration: none;
        }

        .btn-solicitar-turno {
            background: linear-gradient(135deg, #9b42d3, #512b79);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 14px 35px;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(81, 43, 121, 0.2);
            transition: 0.3s;
        }

        .btn-solicitar-turno:hover {
            background: linear-gradient(135deg, #512b79, #9b42d3);
            transform: translateY(-2px);
        }
    </style>

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
            CausesValidation="False"
            Text="Solicitar turno"
            CssClass="btn-solicitar-turno"
            OnClick="btnSolicitarTurno_Click" />
        <br />
        <br />
        <asp:Label ID="lblMensajeTurno" runat="server"
            Font-Bold="True"
            Text="">
        </asp:Label>


    </asp:Panel>

    <br />

 <div class="contenedor-volver">
    <asp:HyperLink
        ID="lnkVolverMEnu"
        runat="server"
        NavigateUrl="~/MenuCliente.aspx"
        CssClass="btn-volver-menu">
        ← Volver al menú
    </asp:HyperLink>
</div>

    <br />
    <br />

</asp:Content>
