<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionMaster.Master" AutoEventWireup="true" CodeBehind="ModificarTurnoRecepcion.aspx.cs" Inherits="EsteticaWeb.ModificarTurnoRecepcion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">

        <h2 class="text-center fw-bold mb-4">Modificar Turno</h2>

        <div class="card border rounded-3 shadow-sm p-4 p-md-5 mx-auto" style="max-width: 1000px;">
            <div class="row g-3">

                <!-- Cliente -->
                <div class="col-md-6">
                    <asp:Label ID="lblCliente" runat="server" CssClass="form-label fw-bold" Text="Cliente:"></asp:Label>
                    <asp:DropDownList ID="ddlCliente" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <!-- Sucursal -->
                <div class="col-md-6">
                    <asp:Label ID="lblSucursal" runat="server" CssClass="form-label fw-bold" Text="Sucursal:"></asp:Label>
                    <asp:DropDownList ID="ddlSucursal" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <!-- Tratamiento / Especialidad -->
                <div class="col-md-6">
                    <asp:Label ID="lblTratamiento" runat="server" CssClass="form-label fw-bold" Text="Tratamiento:"></asp:Label>
                    <asp:DropDownList ID="ddlTratamiento" runat="server" CssClass="form-select" AutoPostBack="false"></asp:DropDownList>
                </div>

                <!-- Profesional -->
                <div class="col-md-6">
                    <asp:Label ID="lblProfesional" runat="server" CssClass="form-label fw-bold" Text="Profesional:"></asp:Label>
                    <asp:DropDownList ID="ddlProfesional" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <!-- Fecha del Turno (con selector nativo dd/mm/aaaa igual a Fecha de Nacimiento) -->
                <div class="col-md-6">
                    <asp:Label ID="lblFechaTurno" runat="server" CssClass="form-label fw-bold" Text="Fecha del Turno:"></asp:Label>
                    <asp:TextBox ID="txtFechaTurno" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFecha" runat="server"
                        ControlToValidate="txtFechaTurno"
                        ErrorMessage="La fecha es obligatoria."
                        CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <!-- Horario del Turno -->
                <div class="col-md-6">
                    <asp:Label ID="lblHorario" runat="server" CssClass="form-label fw-bold" Text="Horario del Turno:"></asp:Label>
                    <asp:DropDownList ID="ddlHorario" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <!-- Precio -->
                <div class="col-md-6">
                    <asp:Label ID="lblPrecio" runat="server" CssClass="form-label fw-bold" Text="Precio:"></asp:Label>
                    <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPrecio" runat="server"
                        ControlToValidate="txtPrecio"
                        ErrorMessage="El precio es obligatorio."
                        CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPrecio" runat="server"
                        ControlToValidate="txtPrecio"
                        ValidationExpression="^\d+([.,]\d{1,2})?$"
                        ErrorMessage="Ingresá un monto válido."
                        CssClass="text-danger small" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>

                <!-- Estado del Turno -->
                <div class="col-md-6">
                    <asp:Label ID="lblEstado" runat="server" CssClass="form-label fw-bold" Text="Estado:"></asp:Label>
                    <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <!-- Observaciones -->
                <div class="col-md-6">
                    <asp:Label ID="lblObservaciones" runat="server" CssClass="form-label fw-bold" Text="Observaciones:"></asp:Label>
                    <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control" MaxLength="500"></asp:TextBox>
                </div>

                <!-- Checks de Estado de Pago y Vigencia -->
                <div class="col-md-6 d-flex align-items-end pb-2">
                    <div class="form-check me-4">
                        <asp:CheckBox ID="chkAbonado" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label fw-bold" for="<%= chkAbonado.ClientID %>">Abonado</label>
                    </div>
                    <div class="form-check">
                        <asp:CheckBox ID="chkBaja" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label fw-bold text-danger" for="<%= chkBaja.ClientID %>">Dar de baja</label>
                    </div>
                </div>

                <!-- Mensaje de confirmación o error -->
                <div class="col-12">
                    <asp:Label ID="lblMensaje" runat="server" CssClass="fw-bold d-block mt-2"></asp:Label>
                </div>

                <!-- Botones alineados a la izquierda igual a la plantilla -->
                <div class="col-12 mt-4 d-flex gap-2">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar cambios" OnClick="btnGuardar_Click" CssClass="btn btn-primary px-4" />
                    <asp:Button ID="btnVolver" runat="server" Text="Volver a turnos" OnClick="btnVolver_Click" CausesValidation="false" CssClass="btn btn-outline-secondary px-4" />
                </div>

            </div>
        </div>
    </div>
</asp:Content>
