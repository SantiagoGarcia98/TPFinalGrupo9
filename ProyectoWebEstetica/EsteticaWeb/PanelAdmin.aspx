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
                        <a href="#" class="btn btn-outline-primary btn-sm">Ver usuarios</a>
                        <a href="#" class="btn btn-primary btn-sm me-2">Cargar usuario</a>
                        <a href="#" class="btn btn-primary btn-sm me-2">Modificar usuario</a>

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
                        <a href="#" class="btn btn-outline-primary btn-sm">Ver servicios</a>
                        <a href="#" class="btn btn-primary btn-sm me-2">Nuevo servicio</a>
                        <a href="#" class="btn btn-primary btn-sm me-2">Modificar servicio</a>

                    </div>
                </div>
            </div>
        </div>

        <div class="md:col-4">
            <div class="card h-100">
                <div class="card-body">
                    <h2 class="h5">Profesional</h2>
                    <p class="text-muted">Crear, consultar y modificar Profesionales del sistema.</p>
                    <div>
                        <a href="#" class="btn btn-outline-primary btn-sm">Ver Profesionales</a>
                        <a href="#" class="btn btn-primary btn-sm me-2">Nuevo Profesional</a>
                        <a href="#" class="btn btn-primary btn-sm me-2">Modificar Profesionales</a>

                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
