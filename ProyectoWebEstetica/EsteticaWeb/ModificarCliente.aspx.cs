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
                        txtFecha.Text = seleccionado.fechaNac.ToString("yyyy-mm-dd");
                    }

                }
            }
        }

    }
}
