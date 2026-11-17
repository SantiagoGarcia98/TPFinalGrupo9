using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb.Servicios
{
    public partial class ModificarEspecialidades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            dgvUsuarios.DataSource = new DataEspecialidad().ListarEspecialidadElegida(id);
            dgvUsuarios.DataBind();
        }

    protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                string id = Request.QueryString["id"];
                string descripcion = txtDescripcion.Text;
                string precio = txtPrecio.Text.Replace(",", ".");
                string Activo = ddlActivo.SelectedValue;
                string duracionMinutos = txtDuracion.Text;

                DataEspecialidad.modificarEspecialidad(id, descripcion, precio, Activo ,duracionMinutos);
                LabelMensajeActualizado.Text = "Especialidad modificada correctamente.";
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