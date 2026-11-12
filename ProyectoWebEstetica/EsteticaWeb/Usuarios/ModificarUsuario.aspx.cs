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

    }
}