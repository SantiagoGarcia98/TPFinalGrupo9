using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class Recepcion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LnkListaTurnos_Click(object sender, EventArgs e)
        {
            Response.Redirect("listaTurnos.aspx");
        }

        protected void LnkListaClientes_Click(object sender, EventArgs e)
        {
            Response.Redirect("listaCliente.aspx");
        }

        protected void LnkAltaClientes_Click(object sender, EventArgs e)
        {
            Response.Redirect("altaCliente.aspx");
        }

        protected void LnkAltaTurno_Click(object sender, EventArgs e)
        {
            Response.Redirect("solicitudTurno.aspx");
        }
    }
}