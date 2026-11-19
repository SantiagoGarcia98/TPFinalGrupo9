using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class ListaTurnos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTurno data = new DataTurno();
            dgvTurnos.DataSource = data.ListarTurnoSp();
            dgvTurnos.DataBind();

        }
        protected void dgvTurnos_SelectedIndexChanged(object sender, EventArgs e)
        {
            //int idTurno = Convert.ToInt32(dgvTurnos.SelectedDataKey.Value);
            //Response.Redirect("ModificarTurno.aspx?id=" + idTurno);
            string id = dgvTurnos.SelectedDataKey.Value.ToString();
            Response.Redirect("ModificarTurnoRecepcion.aspx?id=" + id);
        }

        protected void BtnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Recepcion.aspx");
        }
    }
}