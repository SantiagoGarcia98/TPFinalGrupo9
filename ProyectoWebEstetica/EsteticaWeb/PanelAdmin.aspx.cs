using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.UI;
using negocio;

namespace EsteticaWeb
{
    public partial class PanelAdmin : System.Web.UI.Page
    {
        public string JsonEstado { get; private set; }
        public string JsonTipo { get; private set; }
        public string JsonTurno { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            DataUsuario datos = new DataUsuario();
            DataTurno data = new DataTurno();
            JsonEstado = AJson(datos.ContarPorBaja());
            JsonTipo = AJson(datos.ContarPorTipo());
            JsonTurno = AJson(data.contarTurnosxEstado());
        }

        private string AJson(Dictionary<string, int> conteo)
        {
            StringBuilder labels = new StringBuilder();
            StringBuilder valores = new StringBuilder();
            bool primero = true;

            foreach (KeyValuePair<string, int> item in conteo)
            {
                if (!primero)
                {
                    labels.Append(',');
                    valores.Append(',');
                }

                primero = false;
                labels.Append('"');
                labels.Append(HttpUtility.JavaScriptStringEncode(item.Key));
                labels.Append('"');
                valores.Append(item.Value);
            }

            return "{\"labels\":[" + labels + "],\"valores\":[" + valores + "]}";
        }
    }
}