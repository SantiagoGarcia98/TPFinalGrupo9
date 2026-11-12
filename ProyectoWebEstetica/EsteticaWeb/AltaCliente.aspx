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
        <asp:Label ID="lblAltaCliente" runat="server" Text="Creacion Nuevo Usuario   " Font-Bold="True" Font-Size="24pt"></asp:Label>
    </asp:Panel>
    <p style="width: 500px; margin-right: auto; margin-left: auto;">
        <table style="width: 500px; margin-right: auto; margin-left: auto;">
            <tr id="filaRol" runat="server" visible="false">
                <td>
                    <asp:Label ID="lblRol" runat="server" Font-Bold="True" Text="Rol:"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlRol" runat="server" Width="250px" AutoPostBack="true" OnSelectedIndexChanged="ddlRol_SelectedIndexChanged">
                        <asp:ListItem Value="3" Text="Cliente" Selected="True" />
                        <asp:ListItem Value="4" Text="Profesional" />
                        <asp:ListItem Value="2" Text="Recepcionista" />
                        <asp:ListItem Value="1" Text="Administrador" />
                    </asp:DropDownList>
                </td>
            </tr>
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
                    <asp:TextBox ID="txtApellido" runat="server" EnableViewState="False" Font-Bold="False" Style="margin-bottom: 0px" Width="250px"></asp:TextBox>
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
                    <asp:Label ID="lblTelefono" runat="server" Font-Bold="True" Text="Teléfono:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTelefono" runat="server" TextMode="Phone" Width="250px"></asp:TextBox>
                </td>
            </tr>
            <tr id="filaMatricula" runat="server" visible="false">
                <td>
                    <asp:Label ID="lblMatricula" runat="server" Font-Bold="True" Text="Matrícula:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtMatricula" runat="server" Width="250px"></asp:TextBox>
                </td>
            </tr>
            <tr id="filaSucursal" runat="server" visible="false">
                <td>
                    <asp:Label ID="lblSucursal" runat="server" Font-Bold="True" Text="Sucursal:"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlSucursal" runat="server" Width="250px"></asp:DropDownList>
                </td>
            </tr>
            <tr id="filaEspecialidades" runat="server" visible="false">
                <td>
                    <asp:Label ID="lblEspecialidades" runat="server" Font-Bold="True" Text="Especialidades:"></asp:Label>
                </td>
                <td>
                    <asp:CheckBoxList ID="cblEspecialidades" runat="server"></asp:CheckBoxList>
                </td>
            </tr>
            <tr>
                <td>
                    <label class="form-label">Fecha de Nacimiento</label>
                </td>
                <td>
                    <asp:TextBox ID="txtFechaNac" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
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
                    <asp:Label ID="lblContrasena" runat="server" Font-Bold="True" Text="Contraseña: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtpass" runat="server" TextMode="Password" Width="250px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </p>
    <p>
        &nbsp;
    </p>
    <asp:Panel ID="pnlBotonRegistro" runat="server" HorizontalAlign="Center" Width="100%">
        <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
        <asp:Button ID="btnRegistrarse" runat="server" OnClick="btnRegistrarse_Click" BackColor="#99CCFF" CausesValidation="False" Text="Registrarse" Width="250px" />
    </asp:Panel>
    <p>
         <asp:HyperLink ID="lnkVolverMenu" runat="server">Volver al menú</asp:HyperLink>
    </p>
    <p>
        &nbsp;
    </p>
    <p>
        &nbsp;
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
