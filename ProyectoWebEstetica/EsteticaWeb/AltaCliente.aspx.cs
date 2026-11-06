using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace EsteticaWeb
{
    public partial class AltaCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (!IsPostBack)
                {
                    DataCliente cliente = new DataCliente();
                    List<Cliente> lista = cliente.ListarClientes();
                }

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                throw;
            }


        }

        protected void btnRegistrarse_Click(object sender, EventArgs e)
        {
            try
            {
                Cliente nuevo = new Cliente();
                nuevo.Nombre = txtNombre.Text;
                nuevo.Apellido = txtApellido.Text;
                nuevo.DNI = txtDNI.Text;
                nuevo.Email = txtEmail.Text;
                nuevo.Telefono = txtTelefono.Text;
                nuevo.fechaNac = DateTime.Parse(txtFechaNac.Text);

                string usuario = txtEmail.Text; // o usar txtEmail.Text como nombre de usuario
                string pass = txtpass.Text;
 

                DataCliente data = new DataCliente();
                data.AgregarCliente(nuevo, usuario, pass);

                //Response.Redirect("listaTurnos.aspx");
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
              
            }

        }
    }
}