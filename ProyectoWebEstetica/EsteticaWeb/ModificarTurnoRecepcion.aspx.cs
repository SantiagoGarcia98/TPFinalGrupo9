using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class ModificarTurnoRecepcion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDesplegables();

                if (Request.QueryString["id"] != null)
                {
                    int idTurno = int.Parse(Request.QueryString["id"]);
                    CargarDatosTurno(idTurno);
                }
            }
        }

        private void CargarDesplegables()
        {
            ddlHorario.Items.Clear();
            for (int hora = 9; hora < 19; hora++)
            {
                ddlHorario.Items.Add($"{hora:D2}:00");
                ddlHorario.Items.Add($"{hora:D2}:30");
            }

            // 2. Carga de combos desde la base de datos
            CargarCombo(ddlCliente,
                "SELECT C.Id, C.Nombre + ' ' + C.Apellido AS Texto FROM Cliente C INNER JOIN Usuario U ON C.UsuarioId = U.Id WHERE U.Baja = 0 ORDER BY C.Apellido, C.Nombre");

            CargarCombo(ddlSucursal,
                "SELECT Id, Nombre AS Texto FROM Sucursal WHERE Activo = 1 ORDER BY Nombre");

            CargarCombo(ddlTratamiento,
                "SELECT Id, Descripcion AS Texto FROM Especialidad WHERE Activo = 1 ORDER BY Descripcion");

            CargarCombo(ddlProfesional,
                "SELECT P.Id, P.Nombre + ' ' + P.Apellido AS Texto FROM Profesional P INNER JOIN Usuario U ON P.UsuarioId = U.Id WHERE U.Baja = 0 ORDER BY P.Apellido, P.Nombre");

            CargarCombo(ddlEstado,
                "SELECT Id, Descripcion AS Texto FROM TurnoEstado ORDER BY Id");
        }
        private void CargarCombo(DropDownList combo, string consultaSql)
        {
            AccesoSQL data = new AccesoSQL();
            try
            {
                combo.Items.Clear();
                data.setConsulta(consultaSql);
                data.ConsultaBD();

                while (data.Lector.Read())
                {
                    string id = data.Lector["Id"].ToString();
                    string texto = data.Lector["Texto"].ToString();
                    combo.Items.Add(new ListItem(texto, id));
                }
            }
            finally
            {
                data.cerrarConexion();
            }
        }

        private void CargarDatosTurno(int idTurno)
        {
            try
            {
                DataTurno datos = new DataTurno();
                Turno turno = datos.ObtenerPorId(idTurno);

                if (turno != null)
                {
                    txtFechaTurno.Text = turno.fecha.ToString("yyyy-MM-dd");
                    ddlHorario.SelectedValue = turno.fecha.ToString("HH:mm");
                    txtPrecio.Text = turno.precio.ToString("0.00");
                    txtObservaciones.Text = turno.observaciones;
                    chkAbonado.Checked = turno.Abonado;
                    chkBaja.Checked = turno.Baja;

                    ddlCliente.SelectedValue = turno.cliente.IdCliente.ToString();
                    ddlProfesional.SelectedValue = turno.Profesional.IdProfesional.ToString();
                    ddlSucursal.SelectedValue = turno.Sucursal.IdSucursal.ToString();
                    ddlEstado.SelectedValue = turno.Estado.Id.ToString();

                    if (turno.Especialidad.IdEspecialidad > 0)
                        ddlTratamiento.SelectedValue = turno.Especialidad.IdEspecialidad.ToString();
                }
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al cargar el turno: " + ex.Message;
            }
        }


        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    Turno mod = new Turno();
                    mod.id = int.Parse(Request.QueryString["id"]);
                    mod.cliente.IdCliente = int.Parse(ddlCliente.SelectedValue);
                    mod.Profesional.IdProfesional = int.Parse(ddlProfesional.SelectedValue);
                    mod.Sucursal.IdSucursal = int.Parse(ddlSucursal.SelectedValue);
                    mod.Especialidad.IdEspecialidad = int.Parse(ddlTratamiento.SelectedValue);
                    mod.Estado.Id = int.Parse(ddlEstado.SelectedValue);

                    DateTime fechaBase = DateTime.Parse(txtFechaTurno.Text);
                    TimeSpan hora = TimeSpan.Parse(ddlHorario.SelectedValue);
                    mod.fecha = fechaBase.Add(hora);

                    mod.precio = decimal.Parse(txtPrecio.Text);
                    mod.observaciones = txtObservaciones.Text.Trim();
                    mod.Abonado = chkAbonado.Checked;
                    mod.Baja = chkBaja.Checked;

                    DataTurno datos = new DataTurno();
                    datos.ModificarTurno(mod);

                    lblMensaje.ForeColor = System.Drawing.Color.Green;
                    lblMensaje.Text = "Turno modificado correctamente.";
                }
                catch (Exception ex)
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Error al modificar el turno: " + ex.Message;
                }
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListaTurnos.aspx");
        }
    }
}