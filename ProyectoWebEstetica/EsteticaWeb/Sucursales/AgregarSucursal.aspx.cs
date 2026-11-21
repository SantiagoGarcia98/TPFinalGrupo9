using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb.Sucursales
{
    public partial class AgregarSucursal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                string nombre = txtNombre.Text;
                string direccion = txtDireccion.Text;
                string telefono = txtTelefono.Text;

                DataSucursal.agregarSucursal(nombre, direccion, telefono);

                LabelMensajeActualizado.Text = "Creado con exito.";
                LabelMensajeActualizado.Visible = true;
            }
            catch (Exception ex)
            {
                LabelMensajeActualizado.Text = ex.Message;
                LabelMensajeActualizado.Visible = true;
            }
        }
    }
}