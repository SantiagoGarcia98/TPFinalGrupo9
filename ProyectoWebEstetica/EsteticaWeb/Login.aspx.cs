using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnIngresar_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            try
            {
                Usuario usuario = new DataUsuario().Loguear(txtmail.Text.Trim(), txtpass.Text);

                if (usuario == null)
                {
                    lblError.Text = "Correo o contraseña incorrectos.";
                    return;
                }

                Session["usuario"] = usuario;

                if (string.Equals(usuario.Rol, "Admin", StringComparison.OrdinalIgnoreCase))
                {
                    Response.Redirect("PanelAdmin.aspx", false);
                }
                else if (string.Equals(usuario.Rol, "Recepcion", StringComparison.OrdinalIgnoreCase))
                {
                    Response.Redirect("Recepcion.aspx", false);
                }
                else if (string.Equals(usuario.Rol, "Profesional", StringComparison.OrdinalIgnoreCase))
                {
                    Response.Redirect("Recepcion.aspx", false); //Agregar aca cuando se creen estos perfiles.
                }
                else if (string.Equals(usuario.Rol, "Cliente", StringComparison.OrdinalIgnoreCase))
                {
                    Response.Redirect("Recepcion.aspx", false); //Agregar aca cuando se creen estos perfiles.
                }
                else
                {
                    lblError.Text = "El usuario no tiene un rol habilitado.";
                    return;
                }

                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception)
            {
                lblError.Text = "No se pudo conectar con la base de datos.";
            }
        }
    }
}