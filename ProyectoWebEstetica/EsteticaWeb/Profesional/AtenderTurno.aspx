<%@ Page Title="" Language="C#" MasterPageFile="~/ProfesionalMaster.Master" AutoEventWireup="true" CodeBehind="AtenderTurno.aspx.cs" Inherits="EsteticaWeb.Profesional.AtenderTurno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
        <div class="row mb-3">
            <div class="col">
                <h1 class="h3 mb-3">Detalle de Turno</h1>
                <p class="text-secondary">Consulta, edicion y ciclo de vida del turno</p>
            </div>
        </div>

        <asp:Panel ID="pnlContenido" runat="server" Visible="false">
            <div class="row g-3 mb-4">
                <div class="md:col-3">
                    <asp:Label runat="server" Text="Id" CssClass="form-label" />
                    <asp:TextBox ID="txtIdTurno" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
                <div class="md:col-3">
                    <asp:Label runat="server" Text="Estado" CssClass="form-label" />
                    <asp:TextBox ID="txtEstado" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
                <div class="md:col-3">
                    <asp:Label runat="server" Text="Fecha" CssClass="form-label" />
                    <asp:TextBox ID="txtFechaActual" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>

                <div class="md:col-6">
                    <asp:Label runat="server" Text="Cliente" CssClass="form-label" />
                    <asp:TextBox ID="txtCliente" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
                <div class="md:col-6">
                    <asp:Label runat="server" Text="Profesional" CssClass="form-label" />
                    <asp:TextBox ID="txtProfesional" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
                <div class="md:col-6">
                    <asp:Label runat="server" Text="Especialidad" CssClass="form-label" />
                    <asp:TextBox ID="txtEspecialidad" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
                <div class="md:col-6">
                    <asp:Label runat="server" Text="Email paciente" CssClass="form-label" />
                    <asp:TextBox ID="txtEmailPaciente" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-12">
                    <asp:Label runat="server" Text="Observaciones" CssClass="form-label" />
                    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Rows="4"
                        MaxLength="500" CssClass="form-control" />
                </div>
            </div>

            <div class="d-flex flex-wrap gap-2">
                <asp:Button ID="btnAtendido" runat="server" Text="Atendido"
                    CssClass="btn btn-primary" OnClick="btnAtendido_Click" />
                <asp:Button ID="btnNoAsistio" runat="server" Text="No asistió"
                    CssClass="btn btn-outline-danger" OnClick="btnNoAsistio_Click" />
                <asp:Button ID="btnHistorial" runat="server" Text="Ver historial"
                    CssClass="btn btn-outline-primary" OnClick="btnHistorial_Click" />
                <asp:Button ID="btnVolverMenu" runat="server" Text="Volver al menú"
                    CssClass="btn btn-outline-secondary" OnClick="btnVolverMenu_Click"
                    CausesValidation="false" />
            </div>

            <asp:Panel ID="pnlHistorial" runat="server" Visible="false" CssClass="mt-4">
                <h2 class="h5 mb-3">Historial del cliente</h2>
                <asp:GridView ID="gvHistorial" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-striped table-hover table-bordered align-middle"
                    GridLines="None" UseAccessibleHeader="true" HeaderStyle-CssClass="table-dark"
                    EmptyDataText="Este cliente no tiene turnos anteriores.">
                    <Columns>
                        <asp:BoundField HeaderText="Fecha" DataField="fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                        <asp:BoundField HeaderText="Servicio" DataField="Especialidad.Descripcion" />
                        <asp:BoundField HeaderText="Observaciones" DataField="observaciones" />
                        <asp:BoundField HeaderText="Estado" DataField="Estado.Descripcion" />
                        <asp:BoundField HeaderText="Profesional" DataField="Profesional.Nombre" />
                    </Columns>
                </asp:GridView>
            </asp:Panel>
            <%--<div class="mt-4">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary"
                    OnClick="btnGuardar_Click" />
                <asp:Button ID="btnReprogramar" runat="server" Text="Reprogramar turno"
                    CssClass="btn btn-outline-primary" OnClick="btnReprogramar_Click" />
                <asp:Button ID="btnCancelarTurno" runat="server" Text="Cancelar turno"
                    CssClass="btn btn-outline-danger" OnClick="btnCancelarTurno_Click" />
                <asp:Button ID="btnNoAsistio" runat="server" Text="Marcar no asistio"
                    CssClass="btn btn-outline-secondary" OnClick="btnNoAsistio_Click" />
                <asp:Button ID="btnCerrarTurno" runat="server" Text="Cerrar turno"
                    CssClass="btn btn-outline-success" OnClick="btnCerrarTurno_Click" />
                <asp:Button ID="btnVolver" runat="server" Text="Cancelar"
                    CssClass="btn btn-outline-primary" OnClick="btnVolver_Click" CausesValidation="false" />
            </div>--%>
        </asp:Panel>



    </div>
</asp:Content>
