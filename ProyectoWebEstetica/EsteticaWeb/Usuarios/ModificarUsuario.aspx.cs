using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb.Usuarios
{
    public partial class ModificarUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarUsuarioElegido();
        }

        private void CargarUsuarioElegido()
        {
            string id = Request.QueryString["id"];
            dgvUsuarios.DataSource = new DataUsuario().ListarUsrElegido(id);
            dgvUsuarios.DataBind();
        }
        protected void ddlTipo_SelectedIndexChanged(object sender, EventArgs e)
        {

            pnlUsuario.Visible = false;
            pnlCliente.Visible = false;
            string id = Request.QueryString["id"];
            Usuario Modificar = new DataUsuario().UsuarioAMod(id);

            if (ddlTipo.SelectedValue == "Usuario")
            {
                pnlUsuario.Visible = true;
                btnModificar.Visible = true;
            }
            else if (ddlTipo.SelectedValue == "Cliente")
            {
                if (Modificar.TipoUsuarioId == 3)
                {
                    pnlCliente.Visible = true;
                    lblMensaje.Visible = false;
                    btnModificar.Visible = true;
                }
                else
                {
                    pnlCliente.Visible = false;

                    lblMensaje.Text = "El usuario seleccionado no posee un registro asociado en la tabla Cliente.";
                    lblMensaje.Visible = true;
                    btnModificar.Visible = false;
                }
            }
        }
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                string id = Request.QueryString["id"];
                
                if (ddlTipo.SelectedValue == "Usuario") {
                    DataUsuario.modificarUsuario(id, txtPass.Text, ddlBaja.SelectedValue, ddlTipoUsuario.SelectedValue);

                    LabelMensajeActualizado.Text = "Usuario actualizado correctamente.";
                    LabelMensajeActualizado.Visible = true;

                }
                else if(ddlTipo.SelectedValue == "Cliente")
                {
                    DataCliente.modificarClienteAdmin(id,txtNombre.Text,txtApellido.Text,TxtDni.Text,txtTelefono.Text);
                    LabelMensajeActualizado.Text = "Usuario actualizado correctamente.";
                    LabelMensajeActualizado.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = ex.Message;
                lblMensaje.Visible = true;
            }

        }

    }
}