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
    }
}