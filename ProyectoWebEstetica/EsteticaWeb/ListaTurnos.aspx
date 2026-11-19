<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionMaster.Master" AutoEventWireup="true" CodeBehind="ListaTurnos.aspx.cs" Inherits="EsteticaWeb.ListaTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

 

    <div class="container-fluid py-5 px-4">
        <asp:Button ID="BtnVolver" runat="server" Text="Panel Principal" OnClick="BtnVolver_Click" cssclass="btn btn-secondary"/>

        <!-- Encabezado y botón de alta -->
        <div class="d-flex justify-content-between align-items-center mx-auto mb-4" style="max-width: 1300px;">
            <h2 class="fw-bold mb-0">Listado de Turnos</h2>
           
        </div>
      
        <div class="card border rounded shadow-sm overflow-hidden mx-auto" style="max-width: 1300px;">
            <div class="table-responsive">
                <asp:GridView runat="server" ID="dgvTurnos" AutoGenerateColumns="false"
                    CssClass="table table-hover align-middle mb-0"
                    HeaderStyle-CssClass="table-light text-secondary small text-uppercase"
                    GridLines="None"
                    DataKeyNames="id"
                    OnSelectedIndexChanged="dgvTurnos_SelectedIndexChanged"
                    EmptyDataText="No hay turnos registrados para mostrar.">
                    <Columns>
                        <asp:BoundField HeaderText="Fecha y Hora" DataField="fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                        <asp:BoundField HeaderText="Cliente" DataField="cliente.Nombre" />
                        <asp:BoundField HeaderText="Tratamiento" DataField="Especialidad.Descripcion" />
                        <asp:BoundField HeaderText="Profesional" DataField="Profesional.Nombre" />
                        <asp:BoundField HeaderText="Sucursal" DataField="Sucursal.Nombre" />
                        <asp:BoundField HeaderText="Precio" DataField="precio" DataFormatString="${0:N2}" />
                        <asp:BoundField HeaderText="Estado" DataField="Estado.Descripcion" />

                        <asp:TemplateField HeaderText="Abonado">
                            <ItemTemplate>
                                <span class='<%# (bool)Eval("Abonado") ? "text-success fw-bold" : "text-danger fw-bold" %>'>
                                    <%# (bool)Eval("Abonado") ? "Sí" : "No" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Observaciones" DataField="observaciones" />

                        <asp:CommandField HeaderText="Acciones" ShowSelectButton="true" SelectText="Modificar">
                            <ControlStyle CssClass="btn btn-sm btn-outline-primary px-3" />
                            <HeaderStyle CssClass="text-end pe-4" />
                            <ItemStyle CssClass="text-end pe-4" />
                        </asp:CommandField>
                    </Columns>
                </asp:GridView>
            </div>
            
        </div>              
    </div>

</asp:Content>
