using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace EsteticaWeb
{
    public partial class MenuCliente : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            // Obtener el usuario conectado
            Usuario usuario = Session["usuario"] as Usuario;

            // Si no inició sesión, enviarlo al Login
            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", true);
                return;
            }

            // Solo los Clientes pueden acceder a este panel
            if (usuario.TipoUsuarioId != 3)
            {
                Response.Redirect("~/Inicio.aspx", true);
                return;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnMisTurnos_Click(object sender, EventArgs e)
        {

        }
    }
}