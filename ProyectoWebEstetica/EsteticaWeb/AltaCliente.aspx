<%@ Page Title="" Language="C#" MasterPageFile="~/MiMaster.Master" AutoEventWireup="true" CodeBehind="AltaCliente.aspx.cs" Inherits="EsteticaWeb.AltaCliente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
    </p>
    <p>
    </p>
    <asp:Panel ID="pnlTituloAltaCliente" runat="server" HorizontalAlign="Center" Width="100%">
        <asp:Label ID="lblAltaCliente" runat="server" Text="Registro de cliente   " Font-Bold="True" Font-Size="24pt"></asp:Label>
    </asp:Panel>
    <p style="width: 500px; margin-right: auto; margin-left: auto;">
        <table style="width: 500px; margin-right: auto; margin-left: auto;">
            <tr>
                <td class="auto-style1">
                    <asp:Label ID="lblNombre" runat="server" Font-Bold="True" Text="Nombre:"></asp:Label>
                </td>
                <td class="auto-style1">
                    <asp:TextBox ID="txtNombre" runat="server" Width="250px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblApellido" runat="server" Font-Bold="True" Text="Apellido:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtApellido" runat="server" EnableViewState="False" Font-Bold="False" style="margin-bottom: 0px" Width="250px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblDNI" runat="server" Font-Bold="True" Text="DNI:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDNI" runat="server" Width="250px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblEmail" runat="server" Font-Bold="True" Text="Correo Electrónico:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" Width="250px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblTelefono" runat="server" Font-Bold="True" Text="Teléfono:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTelefono" runat="server" TextMode="Phone" Width="250px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblContrasena" runat="server" Font-Bold="True" Text="Contraseña: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtcontrsena" runat="server" TextMode="Password" Width="250px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </p>
    <p>
        &nbsp;</p>
    <asp:Panel ID="pnlBotonRegistro" runat="server" HorizontalAlign="Center" Width="100%">
        <asp:Button ID="btnRegistrarse" runat="server" BackColor="#99CCFF" CausesValidation="False" Text="Registrarse" Width="250px" />
    </asp:Panel>
    <p>
        <asp:HyperLink ID="lnkVolverMenu" runat="server" NavigateUrl="~/MenuCliente.aspx">Vovler al menú</asp:HyperLink>
    </p>
    <p>
        &nbsp;</p>
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
</asp:Content>
