using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb.Servicios
{
    public partial class AgregarEspecialidad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                string descripcion = txtDescripcion.Text;
                string precio = txtPrecio.Text;
                string duracion = txtDuracion.Text;

                DataEspecialidad.CrearEspecialidad(descripcion, precio, duracion);

                LabelMensajeActualizado.Text = "Creado con exito.";
                LabelMensajeActualizado.Visible = true;


            }
            catch(Exception ex)
            {
                LabelMensajeActualizado.Text = ex.Message;
                LabelMensajeActualizado.Visible = true;
            }
        }
    }
}