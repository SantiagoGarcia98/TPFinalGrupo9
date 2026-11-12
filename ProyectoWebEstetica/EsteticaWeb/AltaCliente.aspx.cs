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
            if (!IsPostBack)
            {
                lblMensaje.Text = ""; // Solo se limpia la primera vez que entrás
            }

            Usuario logueado = Session["usuario"] as Usuario;
            filaRol.Visible = logueado != null && logueado.TipoUsuarioId == 1;

            if (logueado == null)
                lnkVolverMenu.NavigateUrl = "~/Login.aspx";
            else if (logueado.TipoUsuarioId == 1)
                lnkVolverMenu.NavigateUrl = "~/PanelAdmin.aspx";
            else if (logueado.TipoUsuarioId == 2 || logueado.TipoUsuarioId == 4)
                lnkVolverMenu.NavigateUrl = "~/Recepcion.aspx";
            else
                lnkVolverMenu.NavigateUrl = "~/MenuCliente.aspx";
            try
            {
                if (!IsPostBack)
                {
                    DataCliente cliente = new DataCliente();
                    List<Cliente> lista = cliente.ListarClientes();
                    ddlSucursal.DataSource = new DataSucursal().Listar();
                    ddlSucursal.DataValueField = "IdSucursal";
                    ddlSucursal.DataTextField = "Nombre";
                    ddlSucursal.DataBind();

                    cblEspecialidades.DataSource = new DataEspecialidad().Listar();
                    cblEspecialidades.DataValueField = "IdEspecialidad";
                    cblEspecialidades.DataTextField = "Descripcion";
                    cblEspecialidades.DataBind();
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
            if (Page.IsValid)
            {
                try
                {
                    int tipo = 3;
                    Usuario logueado = Session["usuario"] as Usuario;
                    if (logueado != null && logueado.Rol == "Administrador")
                        tipo = int.Parse(ddlRol.SelectedValue);

                    DateTime? fecha = null;
                    if (tipo == 3)
                        fecha = DateTime.Parse(txtFechaNac.Text);

                    List<string> ids = new List<string>();
                    foreach (ListItem item in cblEspecialidades.Items)
                    {
                        if (item.Selected)
                            ids.Add(item.Value);
                    }
                    string especialidades = string.Join(",", ids);

                    int? sucursal = null;
                    if (tipo == 4)
                        sucursal = int.Parse(ddlSucursal.SelectedValue);

                    new DataUsuario().Agregar(
                        tipo,
                        txtEmail.Text.Trim(),
                        txtEmail.Text.Trim(),
                        txtpass.Text,
                        txtNombre.Text.Trim(),
                        txtApellido.Text.Trim(),
                        txtDNI.Text.Trim(),
                        txtTelefono.Text.Trim(),
                        fecha,
                        txtMatricula.Text.Trim(),
                        sucursal,
                        especialidades);

                    lblMensaje.ForeColor = System.Drawing.Color.Green;
                    lblMensaje.Text = "Usuario registrado con éxito.";

                }
                catch (Exception ex)
                {

                    //lblMensaje.Text = ex.Message;
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = ex.Message;
                }


            }
            else
            {
                lblMensaje.ForeColor = System.Drawing.Color.Orange;
                lblMensaje.Text = "Faltan completar campos o hay datos inválidos.";
            }

        }

        protected void ddlRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool esProfesional = ddlRol.SelectedValue == "4";
            filaMatricula.Visible = esProfesional;
            filaSucursal.Visible = esProfesional;
            filaEspecialidades.Visible = esProfesional;
        }
    }
}