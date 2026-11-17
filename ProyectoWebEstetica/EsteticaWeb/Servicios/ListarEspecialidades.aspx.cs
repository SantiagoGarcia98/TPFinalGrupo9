using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb.Servicios
{
    public partial class ListarEspecialidades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            cargarEspecialidades(txtFiltro.Text);
        }
        
        private void cargarEspecialidades(string filtro)
        {
            dgvEspecialidades.DataSource = new negocio.DataEspecialidad().ListarAdmin(filtro);
            dgvEspecialidades.DataBind();
        }
    }
}