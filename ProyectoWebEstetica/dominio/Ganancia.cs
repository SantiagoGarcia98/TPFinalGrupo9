using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class GananciaEspecialidad
    {
        public string Especialidad { get; set; }
        public int Cantidad { get; set; }
        public decimal Cobrado { get; set; }
        public decimal Pendiente { get; set; }
        public decimal Total { get; set; }
        public decimal Porcentaje { get; set; }
    }

    public class GananciaMes
    {
        public string MesAnio { get; set; }
        public int Cantidad { get; set; }
        public decimal Cobrado { get; set; }
        public decimal Pendiente { get; set; }
        public decimal Total { get; set; }
    }
}
