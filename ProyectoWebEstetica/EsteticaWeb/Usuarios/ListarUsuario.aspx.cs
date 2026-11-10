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
            CargarUsuarios(); 
        }

        private void CargarUsuarios()
        {
            dgvUsuarios.DataSource = new DataUsuario().Listar();
            dgvUsuarios.DataBind();
        }

    }

}