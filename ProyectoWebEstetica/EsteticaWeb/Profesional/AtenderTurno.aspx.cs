using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb.Profesional
{
    public partial class AtenderTurno : System.Web.UI.Page
    {
        private readonly Turno turno = new Turno();

        protected void Page_Load(object sender, EventArgs e)
        {
            pnlContenido.Visible = true;
            Usuario usuario = Session["usuario"] as Usuario;
            if (usuario == null || usuario.TipoUsuarioId != 4)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int turnoId;
            if (!int.TryParse(Request.QueryString["id"], out turnoId))
                return;

            Turno encontrado = new DataTurno().BuscarParaProfesional2(turnoId, usuario.Id);
            if (encontrado == null)
                return;

            if (!IsPostBack)
            {
                txtIdTurno.Text = encontrado.id.ToString();
                txtEstado.Text = encontrado.Estado.Descripcion;
                txtFechaActual.Text = encontrado.fecha.ToString("dd/MM/yyyy");
                txtCliente.Text = encontrado.cliente.Nombre;
                txtEspecialidad.Text = encontrado.Especialidad.Descripcion;
                TextBox1.Text = encontrado.observaciones;
                txtProfesional.Text = encontrado.Profesional.Nombre + " - " + encontrado.Profesional.Matricula;
                txtEmailPaciente.Text = encontrado.cliente.Email;
            }


        }

        protected void btnAtendido_Click(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuario"] as Usuario;
            int turnoId = int.Parse(Request.QueryString["id"]);

            new DataTurno().MarcarAtendido(turnoId, usuario.Id, TextBox1.Text);
            Response.Redirect("~/Profesional/ListarTurnos.aspx");
        }

        protected void btnNoAsistio_Click(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuario"] as Usuario;
            int turnoId = int.Parse(Request.QueryString["id"]);

            new DataTurno().MarcarNoAsistio(turnoId, usuario.Id, TextBox1.Text);
            Response.Redirect("~/Profesional/ListarTurnos.aspx");
        }

        protected void btnVolverMenu_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/PanelProfesional.aspx");
        }

        protected void btnHistorial_Click(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuario"] as Usuario;
            int turnoId = int.Parse(Request.QueryString["id"]);

            gvHistorial.DataSource = new DataTurno().ListarHistorialCliente(turnoId, usuario.Id);
            gvHistorial.DataBind();
            pnlHistorial.Visible = true;
        }
    }
}