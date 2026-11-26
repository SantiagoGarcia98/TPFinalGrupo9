using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class ListaTurnosClientes : System.Web.UI.Page
    {

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            // Obtener el usuario conectado
            dominio.Usuario usuario = Session["usuario"] as dominio.Usuario;

            // Si no inició sesión, enviarlo al Login
            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", true);
                return;
            }

            // Solo los clientes pueden consultar sus turnos
            if (usuario.TipoUsuarioId != 3)
            {
                Response.Redirect("~/Inicio.aspx", true);
                return;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dominio.Usuario usuario = Session["usuario"] as dominio.Usuario;

                if (usuario == null || usuario.TipoUsuarioId != 3)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                negocio.DataTurno datos = new negocio.DataTurno();

                gvTurnosCliente.DataSource = datos.ListarTurnosPorCliente(usuario.Id);
                gvTurnosCliente.DataBind();
            }
        }

        protected void gvTurnosCliente_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnBuscarTurnos_Click(object sender, EventArgs e)
        {
            dominio.Usuario usuario = Session["usuario"] as dominio.Usuario;

            if (usuario == null || usuario.TipoUsuarioId != 3)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            negocio.DataTurno datos = new negocio.DataTurno();

            System.Data.DataTable turnos = datos.ListarTurnosPorCliente(usuario.Id);

            string busqueda = txtBuscarTurnos.Text.Trim();

            if (!string.IsNullOrWhiteSpace(busqueda))
            {
                System.Data.DataTable filtrados = turnos.Clone();

                foreach (System.Data.DataRow fila in turnos.Rows)
                {
                    string tratamiento = Convert.ToString(fila["Tratamiento"]);
                    string profesional = Convert.ToString(fila["Profesional"]);

                    if (tratamiento.IndexOf(busqueda, StringComparison.OrdinalIgnoreCase) >= 0 ||
                        profesional.IndexOf(busqueda, StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        filtrados.ImportRow(fila);
                    }
                }

                turnos = filtrados;
            }

            gvTurnosCliente.DataSource = turnos;
            gvTurnosCliente.DataBind();
        }
    }
}