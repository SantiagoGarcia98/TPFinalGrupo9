using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace EsteticaWeb
{
    public partial class ListaTurnos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTurnos();
                CargarEstados();
            }

        }
        private void CargarTurnos()
        {
            DataTurno data = new DataTurno();
            dgvTurnos.DataSource = data.ListarTurnoSp();
            dgvTurnos.DataBind();

        }
        private void CargarEstados()
        {
            DataTurno data = new DataTurno();
            List<string> estados = data.ListarTurnoSp()
                .Where(t => t.Estado != null && !string.IsNullOrWhiteSpace(t.Estado.Descripcion))
                .Select(t => t.Estado.Descripcion.Trim())
                .Distinct()
                .ToList();

            ddlEstado.DataSource = estados;
            ddlEstado.DataBind();

            ddlEstado.Items.Insert(0, new ListItem("Todos", "Todos"));
        }
        private string FiltroFechaActual 
        {
            get { return ViewState["FiltroFecha"] != null ? ViewState["FiltroFecha"].ToString() : string.Empty; }
            set { ViewState["FiltroFecha"] = value; }
        }
        private void ActualizarEstiloBotonesFecha()
        {
            btnTurnosPasados.CssClass = FiltroFechaActual == "pasados" ? "btn btn-dark btn-sm" : "btn btn-outline-secondary btn-sm";
            btnTurnosHoy.CssClass = FiltroFechaActual == "hoy" ? "btn btn-dark btn-sm" : "btn btn-outline-secondary btn-sm";
            btnTurnosProximos.CssClass = FiltroFechaActual == "proximos" ? "btn btn-dark btn-sm" : "btn btn-outline-secondary btn-sm";
        }
        private void AplicarFiltro()
        {
            DataTurno data = new DataTurno();
            string campo = ddlCampo.SelectedItem.Text;
            string filtro = txtFiltrot.Text;
            string estado = ddlEstado.SelectedItem != null ? ddlEstado.SelectedItem.Text : "Todos";
            bool abonado = chkAbonado.Checked;

            dgvTurnos.DataSource = data.FiltrarTurnos(campo, filtro, estado, abonado,FiltroFechaActual);
            dgvTurnos.DataBind();

        }
        protected void dgvTurnos_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvTurnos.SelectedDataKey.Value.ToString();
            Response.Redirect("ModificarTurnoRecepcion.aspx?id=" + id);
        }

        protected void BtnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Recepcion.aspx");
        }

        protected void BtnLimpiart_Click(object sender, EventArgs e)
        {
            txtFiltrot.Text = string.Empty;
            ddlCampo.SelectedIndex = 0;
            ddlEstado.SelectedIndex = 0;
            chkAbonado.Checked = false;
            FiltroFechaActual = string.Empty;
            ActualizarEstiloBotonesFecha();
            CargarTurnos();

        }

        protected void ddlCampo_SelectedIndexChanged(object sender, EventArgs e)
        {
            AplicarFiltro();
        }

        protected void txtFiltrot_TextChanged(object sender, EventArgs e)
        {
            AplicarFiltro();
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            AplicarFiltro();
        }

        protected void chkAbonado_CheckedChanged(object sender, EventArgs e)
        {
            AplicarFiltro();
        }

        protected void BtnfiltroFecha_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string seleccionado = btn.CommandArgument;

            // Si vuelve a hacer clic en el que ya estaba activo, lo desactiva
            FiltroFechaActual = (FiltroFechaActual == seleccionado) ? string.Empty : seleccionado;

            ActualizarEstiloBotonesFecha();
            AplicarFiltro();

        }
    }
}