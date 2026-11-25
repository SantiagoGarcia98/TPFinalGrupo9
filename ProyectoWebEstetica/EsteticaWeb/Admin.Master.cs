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
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuario"] as Usuario;

            if (usuario == null)
            {
                lblUsuarioNavbar.Visible = false;
                btnCerrarSesion.Visible = false;
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