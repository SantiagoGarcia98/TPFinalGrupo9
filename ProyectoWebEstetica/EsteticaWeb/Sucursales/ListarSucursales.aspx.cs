using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb.Sucursales
{
    public partial class ListarSucursales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarSucursales(txtFiltro.Text);
        }
        private void CargarSucursales(string filtro)
        {
            dgvSucursales.DataSource = new DataSucursal().ListarAdmin(filtro);
            dgvSucursales.DataBind();
        }
    }
}