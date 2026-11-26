<%@ Page Title="" Language="C#" MasterPageFile="~/ProfesionalMaster.Master" AutoEventWireup="true" CodeBehind="ListarTurnos.aspx.cs" Inherits="EsteticaWeb.Profesional.ListarTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        input[type="date"].form-control {
            position: relative;
        }

            input[type="date"].form-control::-webkit-calendar-picker-indicator {
                position: absolute;
                right: 0.75rem;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="row mb-2">
            <div class="col">
                <div class="big text-secondary">
                    <asp:Literal ID="litMedico" runat="server" />
                </div>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col">
                <h1 class="h3 mb-2">Mis Turnos asignados</h1>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-12 d-flex flex-wrap gap-2">
                <asp:Button ID="btnHoy" runat="server" Text="Hoy" CssClass="btn btn-primary"
                    OnClick="btnHoy_Click" />
                <asp:Button ID="btnManana" runat="server" Text="Manana" CssClass="btn btn-outline-primary"
                    OnClick="btnManana_Click" />
                <asp:Button ID="btnTodos" runat="server" Text="Todos" CssClass="btn btn-outline-secondary"
                    OnClick="btnTodos_Click" />
            </div>
        </div>

        <div class="row mb-3">
            <div class="md:col-4">
                <asp:Label runat="server" Text="Filtrar" CssClass="form-label" />
                <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control"
                    AutoPostBack="true" OnTextChanged="txtFiltro_TextChanged" />
            </div>
            <div class="md:col-3">
                <asp:Label runat="server" Text="Fecha" CssClass="form-label" />
                <asp:TextBox ID="txtFecha" runat="server" TextMode="Date" CssClass="form-control" />
            </div>
            <div class="md:col-3">
                <asp:Label runat="server" Text="Estado" CssClass="form-label" />
                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control" />
            </div>
            <div class="md:col-2 d-flex align-items-end gap-2">
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary"
                    OnClick="btnBuscar_Click" />
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-outline-primary"
                    OnClick="btnLimpiar_Click" />
            </div>
        </div>

        <asp:GridView ID="dgvTurnos" runat="server" AutoGenerateColumns="false"
            CssClass="table table-striped table-hover table-bordered align-middle"
            GridLines="None" UseAccessibleHeader="true" HeaderStyle-CssClass="table-dark"
            EmptyDataText="No se encontraron turnos asignados.">
            <Columns>
                <asp:BoundField HeaderText="Fecha y hora" DataField="fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                <asp:BoundField HeaderText="Cliente" DataField="cliente.Nombre" />
                <asp:BoundField HeaderText="Tratamiento" DataField="Especialidad.Descripcion" />
                <asp:BoundField HeaderText="Sucursal" DataField="Sucursal.Nombre" />
                <asp:BoundField HeaderText="Precio" DataField="precio" DataFormatString="{0:N2}" />
                <asp:BoundField HeaderText="Estado" DataField="Estado.Descripcion" />
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:HyperLink
                            ID="lnkTomarTurno"
                            runat="server"
                            Text="Tomar Turno"
                            NavigateUrl='<%# "AtenderTurno.aspx?id=" + Eval("id") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
