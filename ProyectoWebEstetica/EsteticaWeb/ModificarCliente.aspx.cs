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
    public partial class ModificarCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";
                if (id != "")
                {

                    DataCliente data = new DataCliente();
                    List<Cliente> lista = data.ListarClientes(id);

                    if (lista.Count > 0)
                    {

                        Cliente seleccionado = lista[0];
                        //Precarga de datos
                        txtDni.Text = seleccionado.DNI;
                        txtNombre.Text = seleccionado.Nombre;
                        txtApellido.Text = seleccionado.Apellido;
                        TxtTelefono.Text = seleccionado.Telefono;
                        txtEmail.Text = seleccionado.Email;
                        txtFecha.Text = seleccionado.fechaNac.ToString("yyyy-MM-dd");
                    }

                }
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Page.Validate("Modificar");
            if (!Page.IsValid)
                return;
            try
            {
                int idCliente = int.Parse(Request.QueryString["id"]);
                string nombre = txtNombre.Text.Trim();
                string apellido = txtApellido.Text.Trim();
                string dni = txtDni.Text.Trim();
                string telefono = TxtTelefono.Text.Trim();
                string email = txtEmail.Text.Trim();

                DateTime fecha;
                if (!DateTime.TryParseExact(txtFecha.Text, "yyyy-MM-dd",
                        System.Globalization.CultureInfo.InvariantCulture,
                        System.Globalization.DateTimeStyles.None, out fecha) &&
                    !DateTime.TryParse(txtFecha.Text, out fecha))
                {
                    MostrarError("Ingresá una fecha de nacimiento válida.");
                    return;
                }

                if (fecha > DateTime.Today || fecha < new DateTime(1900, 1, 1))
                {
                    MostrarError("La fecha de nacimiento debe estar entre 01/01/1900 y hoy.");
                    return;
                }

                Cliente mod = new Cliente();
                mod.IdCliente = int.Parse(Request.QueryString["id"]);
                mod.Nombre = txtNombre.Text;
                mod.Apellido = txtApellido.Text;
                mod.DNI = txtDni.Text;
                mod.Telefono = TxtTelefono.Text;
                mod.Email = txtEmail.Text;

                DataCliente data = new DataCliente();
                data.modificarCliente(mod);

                Response.Redirect("listaCliente.aspx"); // O el nombre de tu página de listado
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                throw;
            }
        }
        private void MostrarError(string mensaje)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.CssClass = "alert alert-danger d-block mt-2";
            lblMensaje.Visible = true;
        }

    }
}
