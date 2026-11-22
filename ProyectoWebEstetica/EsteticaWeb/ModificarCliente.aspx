<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionMaster.Master" AutoEventWireup="true" CodeBehind="ModificarCliente.aspx.cs" Inherits="EsteticaWeb.ModificarCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-12" style="max-width: 700px;">
                <div class="mb-3">
                    <label for="txtNombre" class="form-label">Nombre</label>
                    <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre"
                        ErrorMessage="El nombre es obligatorio." Display="Dynamic"
                        CssClass="text-danger small" ValidationGroup="Modificar" />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtNombre"
                        ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]{2,50}$"
                        ErrorMessage="Ingresá solo letras (mínimo 2 caracteres)." Display="Dynamic"
                        CssClass="text-danger small" ValidationGroup="Modificar" />
                </div>
                <div class="mb-3">
                    <label for="txtApellido" class="form-label">Apellido</label>
                    <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtApellido"
                        ErrorMessage="El apellido es obligatorio." Display="Dynamic"
                        CssClass="text-danger small" ValidationGroup="Modificar" />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtApellido"
                        ValidationExpression="^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]{2,50}$"
                        ErrorMessage="Ingresá solo letras (mínimo 2 caracteres)." Display="Dynamic"
                        CssClass="text-danger small" ValidationGroup="Modificar" />
                </div>
                <div class="mb-3">
                    <label for="txtDni" class="form-label">DNI</label>
                    <asp:TextBox runat="server" ID="txtDni" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDni"
                        ErrorMessage="El DNI es obligatorio." Display="Dynamic"
                        CssClass="text-danger small" ValidationGroup="Modificar" />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDni"
                        ValidationExpression="^\d{7,8}$"
                        ErrorMessage="El DNI debe tener 7 u 8 números sin puntos." Display="Dynamic"
                        CssClass="text-danger small" ValidationGroup="Modificar" />
                </div>
                <div class="mb-3">
                    <label for="TxtTelefono" class="form-label">Teléfono</label>
                    <asp:TextBox runat="server" ID="TxtTelefono" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTelefono"
                        ErrorMessage="El teléfono es obligatorio." Display="Dynamic"
                        CssClass="text-danger small" ValidationGroup="Modificar" />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtTelefono"
                        ValidationExpression="^[0-9\+\-\s]{8,15}$"
                        ErrorMessage="Ingresá un teléfono válido (entre 8 y 15 dígitos)." Display="Dynamic"
                        CssClass="text-danger small" ValidationGroup="Modificar" />
                </div>
                <div class="mb-3">
                    <label for="txtEmail" class="form-label">Email</label>
                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                        ErrorMessage="El email es obligatorio." Display="Dynamic"
                        CssClass="text-danger small" ValidationGroup="Modificar" />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
                        ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w{2,}$"
                        ErrorMessage="Ingresá un formato de email válido." Display="Dynamic"
                        CssClass="text-danger small" ValidationGroup="Modificar" />
                </div>
                <div class="mb-3">
                    <label for="txtFecha" class="form-label">Fecha de nacimiento</label>
                    <asp:TextBox runat="server" TextMode="Date" ID="txtFecha" CssClass="form-control" />                  
                </div>
                <asp:Label ID="lblMensaje" runat="server" Visible="false" />
                <asp:Button ID="btnModificar" runat="server" Text="Modificar" OnClick="btnModificar_Click" CssClass="btn btn-primary" ValidationGroup="modificar" />
            </div>
        </div>
    </div>

</asp:Content>
