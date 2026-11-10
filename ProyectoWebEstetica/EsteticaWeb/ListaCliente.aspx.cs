using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class ListaCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataCliente data = new DataCliente();
            dgvclientes.DataSource = data.ListarClientes();
            dgvclientes.DataBind();
        }

        protected void dgvclientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvclientes.SelectedDataKey.Value.ToString();
            Response.Redirect("ModificarCliente.aspx?id="+id);
        }
    }
}