using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb
{
    public partial class SolicitudTurno : System.Web.UI.Page
    {
      
            protected void Page_Load(object sender, EventArgs e)
            {
                dominio.Usuario usuario = Session["usuario"] as dominio.Usuario;

                if (usuario.TipoUsuarioId !=2 && usuario.TipoUsuarioId != 3)
                {
                    Response.Redirect("~/Login.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                if (!IsPostBack)
                {
                    negocio.DataEspecialidad datos = new negocio.DataEspecialidad();

                    ddlTratamiento.DataSource = datos.Listar();
                    ddlTratamiento.DataTextField = "Descripcion";
                    ddlTratamiento.DataValueField = "IdEspecialidad";
                    ddlTratamiento.DataBind();

                    ddlTratamiento.Items.Insert(0,
                        new ListItem("Seleccioná un tratamiento", ""));
                }
            }

            protected void ddlTratamiento_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlProfesional.Items.Clear();
            ddHorarioTurno.Items.Clear();

            if (string.IsNullOrEmpty(ddlTratamiento.SelectedValue))
            {
                ddlProfesional.Items.Insert(0,
                    new ListItem("Seleccioná un profesional", ""));
                return;
            }

            int especialidadId = int.Parse(ddlTratamiento.SelectedValue);

            negocio.DataProfesional datos = new negocio.DataProfesional();

            var profesionales = datos.ListarPorEspecialidad(especialidadId);

            ddlProfesional.DataSource = profesionales;
            ddlProfesional.DataTextField = "Nombre";
            ddlProfesional.DataValueField = "IdProfesional";
            ddlProfesional.DataBind();

            ddlProfesional.Items.Insert(0,
                new ListItem("Seleccioná un profesional", ""));
        }

        protected void calFechaTurno_SelectionChanged(object sender, EventArgs e)
        {
            CargarHorariosDisponibles();
        }

        protected void ddlProfesional_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarHorariosDisponibles();
        }

        private void CargarHorariosDisponibles()
        {
            ddHorarioTurno.Items.Clear();

            ddHorarioTurno.Items.Add(
                new ListItem("Seleccioná un horario", ""));

            if (string.IsNullOrEmpty(ddlTratamiento.SelectedValue) ||
                string.IsNullOrEmpty(ddlProfesional.SelectedValue) ||
                calFechaTurno.SelectedDate == DateTime.MinValue)
            {
                return;
            }

            DateTime fecha = calFechaTurno.SelectedDate.Date;

            if (fecha < DateTime.Today)
            {
                ddHorarioTurno.Items[0].Text =
                    "No podés seleccionar una fecha pasada";

                return;
            }

            if (fecha.DayOfWeek == DayOfWeek.Saturday ||
                fecha.DayOfWeek == DayOfWeek.Sunday)
            {
                ddHorarioTurno.Items[0].Text =
                    "No hay atención los fines de semana";

                return;
            }

            int especialidadId = int.Parse(ddlTratamiento.SelectedValue);
            int profesionalId = int.Parse(ddlProfesional.SelectedValue);

            negocio.DataEspecialidad datosEspecialidad =
                new negocio.DataEspecialidad();

            int duracion =
                datosEspecialidad.ObtenerDuracionMinutos(especialidadId);

            negocio.DataTurno datosTurno = new negocio.DataTurno();

            System.Data.DataTable horariosOcupados =
                datosTurno.ListarHorariosOcupados(profesionalId, fecha);

            DateTime apertura = fecha.AddHours(9);
            DateTime cierre = fecha.AddHours(19);


            for (DateTime inicio = apertura;
            inicio.AddMinutes(duracion) <= cierre;
            inicio = inicio.AddMinutes(30))
            {
                DateTime fin = inicio.AddMinutes(duracion);

                if (inicio <= DateTime.Now)
                {
                    continue;
                }

                bool disponible = true;

                foreach (System.Data.DataRow fila in horariosOcupados.Rows)
                {
                    DateTime inicioOcupado =
                        Convert.ToDateTime(fila["FechaTurno"]);

                    int duracionOcupada =
                        Convert.ToInt32(fila["DuracionMinutos"]);

                    DateTime finOcupado =
                        inicioOcupado.AddMinutes(duracionOcupada);

                    if (inicio < finOcupado && fin > inicioOcupado)
                    {
                        disponible = false;
                        break;
                    }
                }

                if (disponible)
                {
                    string hora = inicio.ToString("HH:mm");

                    ddHorarioTurno.Items.Add(
                        new ListItem(hora, hora));
                }

            }



        }

        protected void btnSolicitarTurno_Click(object sender, EventArgs e)
        {
            lblMensajeTurno.Text = "";

            dominio.Usuario usuario = Session["usuario"] as dominio.Usuario;

            if (usuario == null || usuario.TipoUsuarioId != 3)
            {
                lblMensajeTurno.Text = "Debés iniciar sesión como cliente.";
                lblMensajeTurno.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (string.IsNullOrEmpty(ddlTratamiento.SelectedValue) ||
                string.IsNullOrEmpty(ddlProfesional.SelectedValue) ||
                calFechaTurno.SelectedDate == DateTime.MinValue ||
                string.IsNullOrEmpty(ddHorarioTurno.SelectedValue))
            {
                lblMensajeTurno.Text = "Seleccioná un tratamiento, profesional, fecha y horario.";
                lblMensajeTurno.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                int especialidadId = int.Parse(ddlTratamiento.SelectedValue);
                int profesionalId = int.Parse(ddlProfesional.SelectedValue);

                TimeSpan hora = TimeSpan.Parse(ddHorarioTurno.SelectedValue);

                DateTime fechaTurno = calFechaTurno.SelectedDate.Date.Add(hora);

                negocio.DataTurno datos = new negocio.DataTurno();

                datos.ReservarTurno(usuario.Id, especialidadId, profesionalId, fechaTurno);

                lblMensajeTurno.Text = "¡Tu turno fue reservado correctamente!";
                lblMensajeTurno.ForeColor = System.Drawing.Color.Green;

                CargarHorariosDisponibles();
            }
            catch (Exception ex)
            {
                lblMensajeTurno.Text = "No se pudo reservar el turno: " + ex.Message;
                lblMensajeTurno.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}