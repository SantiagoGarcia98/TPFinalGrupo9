<%@ Page Title="" Language="C#" MasterPageFile="~/ProfesionalMaster.Master" AutoEventWireup="true" CodeBehind="PanelProfesional.aspx.cs" Inherits="EsteticaWeb.Profesional.PanelProfesional" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row g-3">
        <div class="md:col-4">
            <div class="card h-100">
                <div class="card-body">
                    <h2 class="h5">Turnos</h2>
                    <p class="text-muted">Registrar,listar o revisar turnos agendados.</p>
                    <div>
                        <a href="Profesional/ListarTurnos.aspx" class="btn btn-outline-primary btn-sm">Ver turnos</a>                        
                    </div>
                </div>
        </div>
    </div>
</asp:Content>
