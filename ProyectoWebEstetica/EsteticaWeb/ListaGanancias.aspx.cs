using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class ListaGanancias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDesplegables();
                CalcularGanancias();
            }
        }

        private void CargarDesplegables()
        {
            DataTurno data = new DataTurno();
            List<Turno> lista = data.ListarTurnoSp();
            //Carga Meses disponibles desde los turnos cargados
            ddlMes.Items.Clear();
            ddlMes.Items.Add(new ListItem("Todos", ""));

            List<DateTime> meses = lista
                .Select(t => new DateTime(t.fecha.Year, t.fecha.Month, 1))
                .Distinct()
                .OrderBy(m => m)
                .ToList();

            foreach (DateTime m in meses)
            {
                string texto = FormatearMesAnio(m.Year, m.Month);
                string valor = $"{m.Year}-{m.Month:00}";
                ddlMes.Items.Add(new ListItem(texto, valor));
            }

            //Carga Sucursales disponibles
            ddlSucursal.Items.Clear();
            ddlSucursal.Items.Add(new ListItem("Todas", ""));

            List<string> sucursales = lista
                .Where(t => t.Sucursal != null && !string.IsNullOrWhiteSpace(t.Sucursal.Nombre))
                .Select(t => t.Sucursal.Nombre)
                .Distinct()
                .OrderBy(s => s)
                .ToList();

            foreach (string suc in sucursales)
            {
                ddlSucursal.Items.Add(new ListItem(suc, suc));
            }
        }
        private string FormatearMesAnio(int anio, int mes)
        {
            string[] meses = { "", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
                       "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };
            return $"{meses[mes]} {anio}";
        }

        private void CalcularGanancias()
        {
            DataTurno data = new DataTurno();
            List<Turno> lista = data.ListarTurnoSp();

            //Excluye turnos Cancelados para no inflar las ganancias
            var turnosValidos = lista
                .Where(t => t.Estado == null ||
                            t.Estado.Descripcion == null ||
                            t.Estado.Descripcion.Trim().ToLower() != "cancelado")
                .ToList();

            //Filtra por Mes/Año seleccionado
            if (!string.IsNullOrEmpty(ddlMes.SelectedValue))
            {
                turnosValidos = turnosValidos
                    .Where(t => t.fecha.ToString("yyyy-MM") == ddlMes.SelectedValue)
                    .ToList();
            }

            //Filtra por Sucursal seleccionada
            if (!string.IsNullOrEmpty(ddlSucursal.SelectedValue))
            {
                turnosValidos = turnosValidos
                    .Where(t => t.Sucursal != null && t.Sucursal.Nombre == ddlSucursal.SelectedValue)
                    .ToList();
            }

            // Calcula las 2 tarjetas (KPIs)
            decimal cobrado = turnosValidos.Where(t => t.Abonado).Sum(t => t.precio);
            decimal pendiente = turnosValidos.Where(t => !t.Abonado).Sum(t => t.precio);
            decimal totalGeneral = cobrado + pendiente;

            lblGananciaCobrada.Text = "$" + cobrado.ToString("N2");
            lblPendienteCobro.Text = "$" + pendiente.ToString("N2");

            // Agrupar por Especialidad
            List<GananciaEspecialidad> porEspecialidad = turnosValidos
                .GroupBy(t => (t.Especialidad != null && !string.IsNullOrWhiteSpace(t.Especialidad.Descripcion))
                              ? t.Especialidad.Descripcion
                              : "Sin especificar")
                .Select(g => new GananciaEspecialidad
                {
                    Especialidad = g.Key,
                    Cantidad = g.Count(),
                    Cobrado = g.Where(x => x.Abonado).Sum(x => x.precio),
                    Pendiente = g.Where(x => !x.Abonado).Sum(x => x.precio),
                    Total = g.Sum(x => x.precio),
                    Porcentaje = totalGeneral > 0 ? (g.Sum(x => x.precio) / totalGeneral) * 100 : 0
                })
                .OrderByDescending(x => x.Total)
                .ToList();

            dgvGananciasEspecialidad.DataSource = porEspecialidad;
            dgvGananciasEspecialidad.DataBind();

            //  Agrupar por Mes / Año
            List<GananciaMes> porMes = turnosValidos
                .GroupBy(t => new DateTime(t.fecha.Year, t.fecha.Month, 1))
                .OrderBy(g => g.Key)
                .Select(g => new GananciaMes
                {
                    MesAnio = FormatearMesAnio(g.Key.Year, g.Key.Month),
                    Cantidad = g.Count(),
                    Cobrado = g.Where(x => x.Abonado).Sum(x => x.precio),
                    Pendiente = g.Where(x => !x.Abonado).Sum(x => x.precio),
                    Total = g.Sum(x => x.precio)
                })
                .ToList();

            dgvGananciasMes.DataSource = porMes;
            dgvGananciasMes.DataBind();
        }

        protected void Filtros_SelectedIndexChanged(object sender, EventArgs e)
        {
            CalcularGanancias();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            ddlMes.SelectedIndex = 0;
            ddlSucursal.SelectedIndex = 0;
            CalcularGanancias();
        }
    }
}