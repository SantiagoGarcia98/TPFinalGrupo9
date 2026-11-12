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
                </div>
                <div class="mb-3">
                    <label for="txtApellido" class="form-label">Apellido</label>
                    <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label for="txtDni" class="form-label">DNI</label>
                    <asp:TextBox runat="server" ID="txtDni" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label for="TxtTelefono" class="form-label">Teléfono</label>
                    <asp:TextBox runat="server" ID="TxtTelefono" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label for="txtEmail" class="form-label">Email</label>
                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label for="txtFecha" class="form-label">Fecha de nacimiento</label>
                    <asp:TextBox runat="server" TextMode="Date" ID="txtFecha" CssClass="form-control" />
                </div>
                <asp:Button ID="btnModificar" runat="server" Text="Modificar"  OnClick="btnModificar_Click" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>

</asp:Content>
