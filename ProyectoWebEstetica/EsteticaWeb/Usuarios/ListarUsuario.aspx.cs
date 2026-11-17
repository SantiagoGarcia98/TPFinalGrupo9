using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb.Usuarios
{
    public partial class ListarUsuario : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            CargarUsuarios(txtFiltro.Text);
        }

        private void CargarUsuarios(string filtro)
        {
            dgvUsuarios.DataSource = new DataUsuario().Listar(filtro);
            dgvUsuarios.DataBind();
        }

    }

}