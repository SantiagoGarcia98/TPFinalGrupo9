<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionMaster.Master" AutoEventWireup="true" CodeBehind="ModificarCliente.aspx.cs" Inherits="EsteticaWeb.ModificarCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%-- IdCliente
 DNI 
 Nombre 
 Apellido 
 Telefono 
 Email 
 DateTime fechaNac 
 int UsuarioId --%>


    <%--    <div class="row">

        <div class="col-md-6">
            <div>
                <label for="txtNombre" class="form-label">Nombre</label>               
                <asp:textbox runat="server" ID="txtNombre" cssclass="form-control"/>
            </div>
            <div>
                <label for="txtApellido" class="form-label">Apellido</label>
                <asp:TextBox runat="server" ID="txtApellido" cssclass="form-control" />
            </div>
            <div>
                <label for="txtDni" class="form-label">DNI</label>
                <asp:TextBox runat="server" ID="txtDni" cssclass="form-control" />  
            </div>
            <div>
                <label for="TxtTelefono" class="form-label">Telefono</label>
                <asp:TextBox runat="server" ID="TxtTelefono" cssclass="form-control" />  
            </div>
            <div>
                <label for="txtEmail" class="form-label">Email</label>
                <asp:TextBox runat="server" ID="txtEmail" cssclass="form-control" />  
            </div>
            <div class="form-field">
                <label for="txtFecha" class="form-label">Fecha de nacimiento</label>
                <asp:TextBox runat="server" TextMode="Date" ID="txtFecha" cssclass="form-control w-12"  />  
                <div class="form-text">
                </div>
            </div>
            <button type="button" class="btn">Modificar</button>
        </div>
    </div>--%>

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

                <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>

</asp:Content>
