using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace EsteticaWeb
{
    public partial class RecepcionMaster : System.Web.UI.MasterPage
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            // Obtener el usuario conectado
            Usuario usuario = Session["usuario"] as Usuario;

            // Verificar que haya iniciado sesión
            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", true);
                return;
            }

            // Permitir el acceso únicamente a Recepcionistas
            if (usuario.TipoUsuarioId != 2)
            {
                Response.Redirect("~/Inicio.aspx", true);
                return;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            // Cerrar la autenticación
            FormsAuthentication.SignOut();

            // Limpiar los datos de la sesión
            Session.Clear();
            Session.Abandon();

            // Redirigir al login
            Response.Redirect("~/Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}