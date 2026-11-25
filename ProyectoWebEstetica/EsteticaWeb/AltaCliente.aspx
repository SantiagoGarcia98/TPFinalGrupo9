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
  
    <div class="container my-5 px-4 px-md-5">
        <div class="bg-white border rounded-3 shadow-sm p-4 p-md-5">

            <div class="row g-3">
                <div class="col-md-6">
                    <div id="filaRol" runat="server" visible="false" class="col-12">
                        <asp:Label ID="lblRol" runat="server" CssClass="form-label fw-bold" Text="Rol:"></asp:Label>
                        <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select" AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="ddlRol_SelectedIndexChanged">
                            <asp:ListItem Value="3" Text="Cliente" Selected="True" />
                            <asp:ListItem Value="4" Text="Profesional" />
                            <asp:ListItem Value="2" Text="Recepcionista" />
                            <asp:ListItem Value="1" Text="Administrador" />
                        </asp:DropDownList>
                    </div>
                    <asp:Label ID="lblNombre" runat="server" CssClass="form-label fw-bold" Text="Nombre:"></asp:Label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                        ControlToValidate="txtNombre"
                        ErrorMessage="El nombre es obligatorio."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revNombre" runat="server"
                        ControlToValidate="txtNombre"
                        ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$"
                        ErrorMessage="El nombre solo admite letras."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>

                <div class="col-md-6">
                    <asp:Label ID="lblApellido" runat="server" CssClass="form-label fw-bold" Text="Apellido:"></asp:Label>
                    <asp:TextBox ID="txtApellido" runat="server" EnableViewState="False" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvApellido" runat="server"
                        ControlToValidate="txtApellido"
                        ErrorMessage="El apellido es obligatorio."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revApellido" runat="server"
                        ControlToValidate="txtApellido"
                        ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$"
                        ErrorMessage="El apellido solo admite letras."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>

                <div class="col-md-6">
                    <asp:Label ID="lblDNI" runat="server" CssClass="form-label fw-bold" Text="DNI:"></asp:Label>
                    <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDNI" runat="server"
                        ControlToValidate="txtDNI"
                        ErrorMessage="El DNI es obligatorio."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revDNI" runat="server"
                        ControlToValidate="txtDNI"
                        ValidationExpression="^\d{7,8}$"
                        ErrorMessage="El DNI debe tener 7 u 8 números."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>

                <div class="col-md-6">
                    <asp:Label ID="lblTelefono" runat="server" CssClass="form-label fw-bold" Text="Teléfono:"></asp:Label>
                    <asp:TextBox ID="txtTelefono" runat="server" TextMode="Phone" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server"
                        ControlToValidate="txtTelefono"
                        ErrorMessage="El teléfono es obligatorio."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revTelefono" runat="server"
                        ControlToValidate="txtTelefono"
                        ValidationExpression="^\d{8,15}$"
                        ErrorMessage="El teléfono debe tener entre 8 y 15 números."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>


                <div class="col-md-6">
                    <label for="<%= txtFechaNac.ClientID %>" class="form-label fw-bold">Fecha de Nacimiento:</label>
                    <asp:TextBox ID="txtFechaNac" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFecha" runat="server"
                        ControlToValidate="txtFechaNac"
                        ErrorMessage="La fecha de nacimiento es obligatoria."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>


                <div class="col-md-6">
                    <asp:Label ID="lblEmail" runat="server" CssClass="form-label fw-bold" Text="Correo Electrónico:"></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="El correo es obligatorio."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        ErrorMessage="El correo no es válido."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>

                <div class="col-md-6">
                    <asp:Label ID="lblContrasena" runat="server" CssClass="form-label fw-bold" Text="Contraseña:"></asp:Label>
                    <asp:TextBox ID="txtpass" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPass" runat="server"
                        ControlToValidate="txtpass"
                        ErrorMessage="La contraseña es obligatoria."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPass" runat="server"
                        ControlToValidate="txtpass"
                        ValidationExpression="^.{4,50}$"
                        ErrorMessage="La contraseña debe tener entre 4 y 50 caracteres."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>

                <div id="filaMatricula" runat="server" visible="false" class="col-md-6">
                    <asp:Label ID="lblMatricula" runat="server" CssClass="form-label fw-bold" Text="Matrícula:"></asp:Label>
                    <asp:TextBox ID="txtMatricula" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMatricula" runat="server"
                        ControlToValidate="txtMatricula"
                        ErrorMessage="La matrícula es obligatoria."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revMatricula" runat="server"
                        ControlToValidate="txtMatricula"
                        ValidationExpression="^[a-zA-Z0-9\-]{3,30}$"
                        ErrorMessage="La matrícula debe tener entre 3 y 30 letras o números."
                        CssClass="text-danger small" Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>

                <div id="filaSucursal" runat="server" visible="false" class="col-md-6">
                    <asp:Label ID="lblSucursal" runat="server" CssClass="form-label fw-bold" Text="Sucursal:"></asp:Label>
                    <asp:DropDownList ID="ddlSucursal" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <div id="filaEspecialidades" runat="server" visible="false" class="col-12">
                    <asp:Label ID="lblEspecialidades" runat="server" CssClass="form-label fw-bold d-block" Text="Especialidades:"></asp:Label>
                    <div class="border rounded-3 p-3 bg-light">
                        <asp:CheckBoxList ID="cblEspecialidades" runat="server" CssClass="form-check"></asp:CheckBoxList>
                        <asp:CustomValidator ID="cvEspecialidades" runat="server"
                            OnServerValidate="cvEspecialidades_ServerValidate"
                            ErrorMessage="Elegí al menos una especialidad."
                            CssClass="text-danger small" Display="Dynamic">
                        </asp:CustomValidator>
                    </div>
                </div>
            </div>

            <asp:Panel ID="pnlBotonRegistro" runat="server" CssClass="text-start mt-4">
                <asp:Label ID="lblMensaje" runat="server" CssClass="d-block mb-2 fw-semibold"></asp:Label>
                <div class="d-flex align-items-center gap-3">
                    <asp:Button ID="btnRegistrarse" runat="server" OnClick="btnRegistrarse_Click" CausesValidation="true" Text="Registrarse" CssClass="btn btn-primary px-4" />
                    <asp:HyperLink ID="lnkVolverMenu" runat="server" CssClass="btn btn-outline-secondary">Volver al menú</asp:HyperLink>
                </div>
            </asp:Panel>

        </div>
    </div>
</asp:Content>
