<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionMaster.Master" AutoEventWireup="true" CodeBehind="ListaCliente.aspx.cs" Inherits="EsteticaWeb.ListaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container-fluid py-5 px-4">
        <asp:Button ID="Btnvolver2" runat="server" CssClass="btn btn-primary" OnClick="Btnvolver2_Click" Text="Panel Principal" />
        <div class="mx-auto" style="max-width: 1300px">
            <div class="d-flex justify-content-between align-items-center mx-auto mb-4">
                <h2 class="fw-bold mb-0">Listado de Clientes</h2>
            </div>
            <div class="row">
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Label Text="CAMPO" ID="ddlcampo" runat="server" CssClass="fw-bold" />
                        <asp:DropDownList runat="server" CssClass="form-control">

                            <asp:ListItem Text="Nombre" />
                            <asp:ListItem Text="Email" />
                            <asp:ListItem Text="Dni" />
                            <asp:ListItem Text="telefono" />

                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Label Text="FILTRO" runat="server" CssClass="fw-bold" />
                        <asp:TextBox runat="server" ID="txtFiltro" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-3">
                    <div class="mb-3">
                        <asp:Label Text="ESTADO" ID="txtEstado" runat="server" CssClass="fw-bold" />
                        <asp:DropDownList runat="server" ID="dllEstado" CssClass="form-control">
                            <asp:ListItem Text="Activo" />
                            <asp:ListItem Text="Inactivo" />
                            <asp:ListItem Text="Todos" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-3 d-flex flex-column justify-content-end align-items-center ">
                    <div class="mb-3 ">
                        <asp:Button ID="BtnLimpiar" runat="server" CssClass="btn btn-secondary" OnClick="BtnLimpiar_Click" Text="Limpiar" />
                    </div>
                </div>
            </div>
            <div class="card border rounded shadow-sm overflow-hidden mx-auto">
                <div class="table-responsive">
                    <asp:GridView runat="server" ID="dgvclientes" AutoGenerateColumns="false"
                        CssClass="table table-hover mb-0" GridLines="None"
                        DataKeyNames="IdCliente"
                        OnSelectedIndexChanged="dgvclientes_SelectedIndexChanged">
                        <Columns>
                            <asp:BoundField HeaderText="NOMBRE" DataField="Nombre" />
                            <asp:BoundField HeaderText="APELLIDO" DataField="Apellido" />
                            <asp:BoundField HeaderText="DNI" DataField="DNI" />
                            <asp:BoundField HeaderText="TELEFONO" DataField="Telefono" />
                            <asp:BoundField HeaderText="EMAIL" DataField="Email" />
                            <%--<asp:CommandField HeaderText="ACCIONES" ShowSelectButton="true" SelectText="Modificar" />--%>
                            <asp:CommandField HeaderText="ACCIONES" ShowSelectButton="true" SelectText="Modificar">
                                <ControlStyle CssClass="btn btn-sm btn-outline-primary px-3" />
                                <HeaderStyle CssClass="text-end pe-4" />
                                <ItemStyle CssClass="text-end pe-4" />
                            </asp:CommandField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
