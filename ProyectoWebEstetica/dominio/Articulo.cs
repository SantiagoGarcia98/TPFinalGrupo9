using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Articulo
    {
        public int id { get; set; }
        public string Codigo { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public decimal Precio { get; set; }
        [DisplayName ("Marca")]
        public Marca NombreMarca { get; set; }
        [DisplayName("Categoria")]
        public Categoria TipoCategoria { get; set; }
        public List<Imagen> urlImagen {  get; set; }    
    }
}
