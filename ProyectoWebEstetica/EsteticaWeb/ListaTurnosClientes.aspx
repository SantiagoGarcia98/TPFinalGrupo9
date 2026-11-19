<%@ Page Title="" Language="C#" MasterPageFile="~/MiMaster.Master" AutoEventWireup="true" CodeBehind="ListaTurnosClientes.aspx.cs" Inherits="EsteticaWeb.ListaTurnosClientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .titulo-mis-turnos {
            background: linear-gradient(135deg, #f8f1ff, #ffffff);
            border-radius: 20px;
            padding: 35px 20px;
            margin: 30px auto;
            max-width: 1100px;
            color: #512b79;
            box-shadow: 0 5px 20px rgba(81, 43, 121, 0.08);
        }
        .tabla-turnos {
            width: 100%;
            max-width: 1100px;
            margin: 30px auto;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(81, 43, 121, 0.12);
        }

        .tabla-turnos th {
            background-color: #512b79;
            color: white;
            padding: 15px;
            text-align: center;
        }

        .tabla-turnos td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #eadcf7;
            color: #444;
        }

        .tabla-turnos tr:nth-child(even) td {
            background-color: #f8f1ff;
        }

        .buscador-turnos {
            max-width: 1100px;
            margin: 20px auto;
            display: flex;
            gap: 12px;
        }

        .btn-buscar-turnos {
            background-color: #512b79;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 25px;
            cursor: pointer;
        }

        .btn-buscar-turnos:hover {
            background-color: #6d3b9c;
        }

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
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
    </p>
   <asp:Panel ID="pnlTituloTurnos" runat="server"
    HorizontalAlign="Center"
    Width="100%"
    Wrap="False"
    CssClass="titulo-mis-turnos">
        <asp:Label ID="lblTituloTurnos" runat="server" Text="Mis turnos" Font-Bold="True" Font-Size="24pt"></asp:Label>
    </asp:Panel>
   <div class="buscador-turnos">

    <asp:TextBox
        ID="txtBuscarTurnos"
        runat="server"
        CssClass="form-control"
        placeholder="Buscar por tratamiento o profesional..." />

    <asp:Button
    ID="btnBuscarTurnos"
    runat="server"
    Text="🔍 Buscar"
    CssClass="btn-buscar-turnos"
    OnClick="btnBuscarTurnos_Click" />

</div>
    <asp:GridView ID="gvTurnosCliente" runat="server"
    AutoGenerateColumns="False"
    OnSelectedIndexChanged="gvTurnosCliente_SelectedIndexChanged"
    Width="100%"
    CssClass="tabla-turnos">
            <Columns>
                <asp:BoundField DataField="Fecha" HeaderText="Fecha"
                    DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="Horario" HeaderText="Horario" />
                <asp:BoundField DataField="Tratamiento" HeaderText="Tratamiento" />
                <asp:BoundField DataField="Profesional" HeaderText="Profesional" />
                <asp:BoundField DataField="Estado" HeaderText="Estado" />
            </Columns>
        </asp:GridView>
   
       <div class="contenedor-volver">
    <asp:HyperLink
        ID="lnkVolverMenu"
        runat="server"
        NavigateUrl="~/MenuCliente.aspx"
        CssClass="btn-volver-menu">
        ← Volver al menú
    </asp:HyperLink>
</div>
 
</asp:Content>
