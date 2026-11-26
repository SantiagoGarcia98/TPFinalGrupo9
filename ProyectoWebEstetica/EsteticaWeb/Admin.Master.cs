using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class Admin : System.Web.UI.MasterPage
    {

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            // Obtener el usuario que inició sesión
            Usuario usuario = Session["usuario"] as Usuario;

            // Si no hay sesión, volver al login
            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", true);
                return;
            }

            // Solo los administradores pueden acceder
            if (usuario.TipoUsuarioId != 1)
            {
                Response.Redirect("~/Login.aspx", true);
                return;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuario"] as Usuario;

            if (usuario == null || usuario.TipoUsuarioId != 1)
            {
                Response.Redirect("~/Login.aspx", true);
                return;
            }

            lblUsuarioNavbar.Visible = true;
            lblUsuarioNavbar.Text = "Hola, " + Server.HtmlEncode(usuario.User);
            btnCerrarSesion.Visible = true;
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}