<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionMaster.Master" AutoEventWireup="true" CodeBehind="Recepcion.aspx.cs" Inherits="EsteticaWeb.Recepcion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container my-4">

        <div class="mb-4">
            <h1 class="h3 mb-1">Panel Principal</h1>
            <asp:Label ID="Label1" runat="server" CssClass="text-muted" />
        </div>

        <div class="row g-3">

            <div id="CardClientes" runat="server" class="col-12 col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h2 class="h5">Clientes</h2>
                        <p class="text-muted">Registrar y consultar clientes.</p>
                        <div class="d-flex gap-2">
                            <asp:LinkButton ID="LnkAltaClientes" runat="server" CssClass="btn btn-primary btn-sm">Nuevo cliente</asp:LinkButton>
                            <asp:LinkButton ID="LnkListaClientes" runat="server" OnClick="LnkListaClientes_Click" CssClass="btn btn-outline-primary btn-sm">Ver clientes</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>

            <div id="CardTurnos" runat="server" class="col-12 col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h2 class="h5">Turnos</h2>
                        <p class="text-muted">Registrar, listar o revisar turnos asignados.</p>
                        <div class="d-flex gap-2">
                            <asp:LinkButton ID="LnkAltaTurno" runat="server" CssClass="btn btn-primary btn-sm">Nuevo turno</asp:LinkButton>
                            <asp:LinkButton ID="LnkListaTurnos" runat="server" onclick="LnkListaTurnos_Click" CssClass="btn btn-outline-primary btn-sm">Ver turnos</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
            <div id="CardLiquidaciones" runat="server" class="col-12 col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h2 class="h5">Liquidaciones</h2>
                        <p class="text-muted">listar ganancias.</p>
                        <div class="d-flex gap-2">
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary btn-sm">Ver liquidaciones</asp:LinkButton>                          
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
