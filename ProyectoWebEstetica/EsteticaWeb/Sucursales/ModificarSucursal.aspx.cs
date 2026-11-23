using dominio;
using System;
using negocio;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsteticaWeb.Sucursales
{
    public partial class ModificarSucursal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            cargarDatosSucursalBuscada();
        }

        private void cargarDatosSucursalBuscada()
        {
            string id = Request.QueryString["IdSucursal"];
            dgvSuc.DataSource = new DataSucursal().listarUsrElegido(id);
            dgvSuc.DataBind();

        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string id = Request.QueryString["IdSucursal"];
            try
            {
                Sucursal suc = new Sucursal();
                suc.IdSucursal = Convert.ToInt32(id);
                suc.Nombre = txtNombreSuc.Text;
                suc.Direccion = txtDireccionSuc.Text;
                suc.Telefono = txtTelefonoSuc.Text;
                if (string.IsNullOrWhiteSpace(ddlActivoSuc.SelectedValue))
                    suc.Activo = null;
                else
                    suc.Activo = Convert.ToBoolean(ddlActivoSuc.SelectedValue);


                DataSucursal.modificar(suc);

                LabelMensajeActualizado.Text = "Usuario actualizado correctamente.";
                LabelMensajeActualizado.Visible = true;

            }
            catch (Exception ex)
            {
                LabelMensajeActualizado.Text = ex.Message;
                LabelMensajeActualizado.Visible = true;
            }

        }
    }
}