using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class MiMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuario"] as Usuario;

            if (usuario != null)
            {
                lnkIngresar.Visible = false;

                lblUsuarioNavbar.Visible = true;
                lblUsuarioNavbar.Text = "Hola, " + Server.HtmlEncode(usuario.User);

                btnCerrarSesion.Visible = true;
            }
            else
            {
                lnkIngresar.Visible = true;

                lblUsuarioNavbar.Visible = false;
                btnCerrarSesion.Visible = false;
            }

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