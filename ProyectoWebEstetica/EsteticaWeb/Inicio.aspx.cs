using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuario"] as Usuario;
            if (usuario == null)
            {
                return;
            }

            if (string.Equals(usuario.Rol, "Administrador", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("~/PanelAdmin.aspx", false);
            }
            else if (string.Equals(usuario.Rol, "Recepcionista", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("~/Recepcion.aspx", false);
            }
            else if (string.Equals(usuario.Rol, "Cliente", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("~/MenuCliente.aspx", false);
            }
            else if (string.Equals(usuario.Rol, "Profesional", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("~/Recepcion.aspx", false);
            }

            Context.ApplicationInstance.CompleteRequest();
        }
    }
}