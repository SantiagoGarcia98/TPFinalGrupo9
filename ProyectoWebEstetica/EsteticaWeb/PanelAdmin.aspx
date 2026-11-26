<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="PanelAdmin.aspx.cs" Inherits="EsteticaWeb.PanelAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row g-3">
        <div class="md:col-4">
            <div class="card h-100">
                <div class="card-body">
                    <h2 class="h5">Usuarios</h2>
                    <p class="text-muted">Crear, consultar y modificar usuarios del sistema.</p>
                    <div>
                        <a href="Usuarios/ListarUsuario.aspx" class="btn btn-outline-primary btn-sm">Ver usuarios</a>
                        <a href="AltaCliente.aspx" class="btn btn-primary btn-sm me-2">Cargar usuario</a>
                        <%--                        <a href="Usuarios/ModificarUsuario.aspx" class="btn btn-primary btn-sm me-2">Modificar usuario</a>--%>
                    </div>
                </div>
            </div>
        </div>

        <div class="md:col-4">
            <div class="card h-100">
                <div class="card-body">
                    <h2 class="h5">Servicios</h2>
                    <p class="text-muted">Crear, consultar y modificar servicios del sistema.</p>
                    <div>
                        <a href="Servicios/ListarEspecialidades.aspx" class="btn btn-outline-primary btn-sm">Ver servicios</a>
                        <a href="Servicios/AgregarEspecialidad.aspx" class="btn btn-primary btn-sm me-2">Nuevo servicio</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="md:col-4">
            <div class="card h-100">
                <div class="card-body">
                    <h2 class="h5">Sucursales</h2>
                    <p class="text-muted">Crear, consultar y modificar Sucursales del sistema.</p>
                    <div>
                        <a href="Sucursales/ListarSucursales.aspx" class="btn btn-outline-primary btn-sm">Ver sucursales</a>
                        <a href="Sucursales/AgregarSucursal.aspx" class="btn btn-primary btn-sm me-2">Nueva sucursal</a>
                    </div>
                </div>
            </div>
        </div>


    </div>

    <div class="row g-3 mt-2">
        <div class="md:col-6">
            <div class="card h-100">
                <div class="card-body">
                    <h2 class="h5">Usuarios activos e inactivos</h2>
                    <div class="mx-auto" style="max-width: 280px;">
                        <canvas id="graficoEstado"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="md:col-6">
            <div class="card h-100">
                <div class="card-body">
                    <h2 class="h5">Usuarios por tipo</h2>
                    <div class="mx-auto" style="max-width: 280px;">
                        <canvas id="graficoTipo"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="md:col-6">
            <div class="card h-100">
                <div class="card-body">
                    <h2 class="h5">Turnos por Estado</h2>
                    <div class="mx-auto" style="max-width: 280px;">
                        <canvas id="graficoTurnos"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
    <script>
        function torta(id, datos, colores) {
            new Chart(document.getElementById(id), {
                type: 'pie',
                data: {
                    labels: datos.labels,
                    datasets: [{
                        data: datos.valores,
                        backgroundColor: colores
                    }]
                },
                options: {
                    plugins: {
                        legend: { position: 'bottom' }
                    }
                }
            });
        }

        torta('graficoEstado', <%= JsonEstado %>, ['#198754', '#dc3545']);
        torta('graficoTipo', <%= JsonTipo %>, ['#0d6efd', '#6f42c1', '#fd7e14', '#20c997']);
        torta('graficoTurnos', <%= JsonTurno %>, ['#ffc107', '#0d6efd', '#dc3545', '#198754', '#6c757d']);
    </script>
</asp:Content>
