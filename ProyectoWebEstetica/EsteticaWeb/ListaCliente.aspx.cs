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
            if (!IsPostBack)
            {
                CargarCliente();
            }
        }

        protected void CargarCliente()
        {
            DataCliente data = new DataCliente();
            dgvclientes.DataSource = data.ListarClientes();
            dgvclientes.DataBind();

     
        }
        protected void aplicarFiltro()
        {
            DataCliente data = new DataCliente();
            string campo = ddlcampo.SelectedItem.Text;
            string filtro = txtFiltro.Text;

            dgvclientes.DataSource = data.FiltrarClientes(campo, filtro);
            dgvclientes.DataBind();

      
        }
        protected void txtFiltro_TextChanged(object sender, EventArgs e)
        {
            aplicarFiltro();
        }
        protected void ddlcampo_TextChanged(object sender, EventArgs e)
        {
            aplicarFiltro();
        }

        protected void dgvclientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvclientes.SelectedDataKey.Value.ToString();
            Response.Redirect("ModificarCliente.aspx?id=" + id);
        }
        protected void Btnvolver2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Recepcion.aspx");

        }
        protected void BtnLimpiar_Click(object sender, EventArgs e)
        {
            txtFiltro.Text = string.Empty;
            ddlcampo.SelectedIndex = 0;
            CargarCliente();
        }
    }

}