using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{

    public class Turno
    {
        public int id { get; set; }
        public decimal precio { get; set; }
        public string observaciones { get; set; }
        public bool Baja { get; set; }
        public bool Abonado { get; set; }
        public DateTime fecha { get; set; }
        public Cliente cliente { get; set; }
        public Profesional Profesional { get; set; }
        public Especialidad Especialidad { get; set; }
        public Sucursal Sucursal { get; set; }
        public TurnoEstado Estado { get; set; }

        public Turno()
        {
            cliente = new Cliente();
            Profesional = new Profesional();
            Especialidad = new Especialidad();
            Sucursal = new Sucursal();
            Estado = new TurnoEstado();
        }
    }

}
