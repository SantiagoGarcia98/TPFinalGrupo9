<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionMaster.Master" AutoEventWireup="true" CodeBehind="ListaGanancias.aspx.cs" Inherits="EsteticaWeb.ListaGanancias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-3">
        <h2 class="fw-bold mb-3">Reporte de Ganancias</h2>
    </div>
        <div style="width: 75%; min-width: 650px; max-width: 100%; margin: 0 auto;">

            <div style="display: flex; gap: 16px; align-items: flex-end; flex-wrap: wrap; margin-bottom: 24px;">
                <div style="display: flex; flex-direction: column; gap: 4px; min-width: 200px;">
                    <asp:Label Text="Mes / Año" ID="lblMes" runat="server" CssClass="fw-bold" />
                    <asp:DropDownList runat="server" ID="ddlMes" CssClass="btn btn-secondary btn-sm dropdown-toggle"
                        AutoPostBack="true" OnSelectedIndexChanged="Filtros_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <div style="display: flex; flex-direction: column; gap: 4px; min-width: 200px;">
                    <asp:Label Text="Sucursal" ID="lblSucursal" runat="server" CssClass="fw-bold" />
                    <asp:DropDownList runat="server" ID="ddlSucursal" CssClass="btn btn-secondary btn-sm dropdown-toggle"
                        AutoPostBack="true" OnSelectedIndexChanged="Filtros_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar"
                    CssClass="btn btn-light border" OnClick="btnLimpiar_Click" />
            </div>


            <div style="display: flex; gap: 16px; margin-bottom: 24px; flex-wrap: wrap;">
                <div class="card border-success shadow-sm" style="flex: 1; min-width: 260px;">
                    <div class="card-body">
                        <span class="text-uppercase small fw-bold text-muted">Ganancia Cobrada</span>
                        <h2 class="fw-bold text-success mt-1 mb-0">
                            <asp:Label ID="lblGananciaCobrada" runat="server" Text="$0,00" />
                        </h2>
                        <small class="text-muted">Turnos abonados</small>
                    </div>
                </div>

                <div class="card border-warning shadow-sm" style="flex: 1; min-width: 260px;">
                    <div class="card-body">
                        <span class="text-uppercase small fw-bold text-muted">Pendiente de Cobro</span>
                        <h2 class="fw-bold text-danger mt-1 mb-0">
                            <asp:Label ID="lblPendienteCobro" runat="server" Text="$0,00" />
                        </h2>
                        <small class="text-muted">Turnos pendientes/confirmados sin abonar</small>
                    </div>
                </div>
            </div>


            <h5 class="fw-bold mb-2">Ganancias por Especialidad</h5>
            <div class="mb-4">
                <asp:GridView runat="server" ID="dgvGananciasEspecialidad" AutoGenerateColumns="false"
                    CssClass="table table-hover align-middle mb-0 table-striped table-bordered estetimed-tabla"
                    HeaderStyle-CssClass="small text-uppercase"
                    GridLines="None"
                    EmptyDataText="No hay datos de ganancias para los filtros seleccionados.">
                    <Columns>
                        <asp:BoundField HeaderText="Especialidad" DataField="Especialidad" />
                        <asp:BoundField HeaderText="Cant. Turnos" DataField="Cantidad" />
                        <asp:BoundField HeaderText="Cobrado" DataField="Cobrado" DataFormatString="${0:N2}" />
                        <asp:BoundField HeaderText="Pendiente" DataField="Pendiente" DataFormatString="${0:N2}" />
                        <asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="${0:N2}" />
                        <asp:BoundField HeaderText="% del Total" DataField="Porcentaje" DataFormatString="{0:N1}%" />
                    </Columns>
                </asp:GridView>
            </div>

            <h5 class="fw-bold mb-2">Detalle Mensual</h5>
            <div>
                <asp:GridView runat="server" ID="dgvGananciasMes" AutoGenerateColumns="false"
                    CssClass="table table-hover align-middle mb-0 table-striped table-bordered estetimed-tabla"
                    HeaderStyle-CssClass="small text-uppercase"
                    GridLines="None"
                    EmptyDataText="No hay registros mensuales para mostrar.">
                    <Columns>
                        <asp:BoundField HeaderText="Mes / Año" DataField="MesAnio" />
                        <asp:BoundField HeaderText="Cant. Turnos" DataField="Cantidad" />
                        <asp:BoundField HeaderText="Cobrado" DataField="Cobrado" DataFormatString="${0:N2}" />
                        <asp:BoundField HeaderText="Pendiente" DataField="Pendiente" DataFormatString="${0:N2}" />
                        <asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="${0:N2}" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
</asp:Content>
