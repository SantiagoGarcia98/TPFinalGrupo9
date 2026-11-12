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
            try
            {
                Cliente mod = new Cliente();
                mod.IdCliente = int.Parse(Request.QueryString["id"]);
                mod.Nombre = txtNombre.Text;
                mod.Apellido = txtApellido.Text;
                mod.DNI = txtDni.Text;
                mod.Telefono = TxtTelefono.Text;
                mod.Email = txtEmail.Text;
                DateTime fecha;
                if (DateTime.TryParse(txtFecha.Text, out fecha))
                {
                    mod.fechaNac = fecha;
                }
                else
                {                
                    return;
                }// pregunte con IA por que vivia dandome error la fecha , posible eliminacion del dato  

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
    }
}
