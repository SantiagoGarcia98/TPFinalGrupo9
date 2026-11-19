<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionMaster.Master" AutoEventWireup="true" CodeBehind="ListaCliente.aspx.cs" Inherits="EsteticaWeb.ListaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid py-5 px-4">
        <asp:Button ID="Btnvolver2" runat="server" CssClass="btn btn-primary" OnClick="Btnvolver2_Click" Text="Panel Principal" />
        <div class="d-flex justify-content-between align-items-center mx-auto mb-4" style="max-width: 1300px;">
            <h2 class="fw-bold mb-0">Listado de Clientes</h2>
        </div>
        <div class="card border rounded shadow-sm overflow-hidden mx-auto" style="max-width: 1300px">
            <div class="table-responsive">
                <asp:GridView runat="server" ID="dgvclientes" AutoGenerateColumns="false"
                    CssClass="table table-hover mb-0" GridLines="None"
                    DataKeyNames="IdCliente"
                    OnSelectedIndexChanged="dgvclientes_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                        <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                        <asp:BoundField HeaderText="DNI" DataField="DNI" />
                        <asp:BoundField HeaderText="Teléfono" DataField="Telefono" />
                        <asp:BoundField HeaderText="Email" DataField="Email" />
                        <asp:CommandField HeaderText="Modificar" ShowSelectButton="true" SelectText="Modificar" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

</asp:Content>
