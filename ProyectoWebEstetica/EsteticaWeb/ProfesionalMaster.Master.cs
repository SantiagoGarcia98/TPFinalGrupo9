using System;
using System.Web.UI;

namespace EsteticaWeb.Profesional
{
    public partial class ProfesionalMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/Inicio.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}