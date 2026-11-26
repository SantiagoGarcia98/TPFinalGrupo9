using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb.Profesional
{
    public partial class ListarTurnos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (ProfesionalActual() == null)
                return;

            if (!IsPostBack)
                ViewState["dia"] = "todos";

            Cargar();
        }

        protected void btnHoy_Click(object sender, EventArgs e)
        {
            ViewState["dia"] = "hoy";
            txtFecha.Text = "";
            Cargar();
        }

        protected void btnManana_Click(object sender, EventArgs e)
        {
            ViewState["dia"] = "manana";
            txtFecha.Text = "";
            Cargar();
        }

        protected void btnTodos_Click(object sender, EventArgs e)
        {
            ViewState["dia"] = "todos";
            txtFecha.Text = "";
            Cargar();
        }

        protected void txtFiltro_TextChanged(object sender, EventArgs e)
        {
            Cargar();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            ViewState["dia"] = "todos";
            Cargar();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtFiltro.Text = "";
            txtFecha.Text = "";
            ddlEstado.SelectedIndex = 0;
            ViewState["dia"] = "todos";
            Cargar();
        }

        private dominio.Profesional ProfesionalActual()
        {
            Usuario usuario = Session["usuario"] as Usuario;

            if (usuario == null || usuario.TipoUsuarioId != 4)
            {
                Response.Redirect("~/Login.aspx");
                return null;
            }

            dominio.Profesional profesional = new DataProfesional().BuscarPorUsuario(usuario.Id);

            if (profesional == null)
            {
                litMedico.Text = "No hay un profesional asociado a este usuario.";
                return null;
            }

            litMedico.Text = profesional.Apellido + ", " + profesional.Nombre
                + " · Matrícula " + profesional.Matricula
                + " · " + profesional.SucursalNombre;

            return profesional;
        }

        private void Cargar()
        {
            Usuario usuario = Session["usuario"] as Usuario;
            if (usuario == null)
                return;

            List<Turno> turnos = new DataTurno().ListarPorProfesional(usuario.Id);

            if (!IsPostBack)
            {
                ddlEstado.Items.Clear();
                ddlEstado.Items.Add(new ListItem("Todos", ""));
                foreach (string estado in turnos.Select(t => t.Estado.Descripcion).Distinct())
                    ddlEstado.Items.Add(estado);
            }

            IEnumerable<Turno> filtrados = turnos;
            string dia = ViewState["dia"] as string;

            if (dia == "hoy")
                filtrados = filtrados.Where(t => t.fecha.Date == DateTime.Today);
            else if (dia == "manana")
                filtrados = filtrados.Where(t => t.fecha.Date == DateTime.Today.AddDays(1));

            DateTime fechaElegida;
            if (DateTime.TryParse(txtFecha.Text, out fechaElegida))
                filtrados = filtrados.Where(t => t.fecha.Date == fechaElegida.Date);

            if (!string.IsNullOrWhiteSpace(ddlEstado.SelectedValue))
                filtrados = filtrados.Where(t => t.Estado.Descripcion == ddlEstado.SelectedValue);

            string texto = txtFiltro.Text.Trim();
            if (texto != "")
            {
                filtrados = filtrados.Where(t =>
                    (t.cliente.Nombre != null && t.cliente.Nombre.IndexOf(texto, StringComparison.OrdinalIgnoreCase) >= 0) ||
                    (t.Especialidad.Descripcion != null && t.Especialidad.Descripcion.IndexOf(texto, StringComparison.OrdinalIgnoreCase) >= 0));
            }

            dgvTurnos.DataSource = filtrados.ToList();
            dgvTurnos.DataBind();
        }
    }
}
