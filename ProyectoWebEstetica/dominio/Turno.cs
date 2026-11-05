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
            public DateTime fecha { get; set; }
            public Cliente cliente { get; set; }
            public Profesional Profesional { get; set; }
            public Especialidad Especialidad { get; set; }
            public Sucursal Sucursal { get; set; }
        }
    
}
