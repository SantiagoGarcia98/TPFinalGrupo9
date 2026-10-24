using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class DataCategoria
    {
        public List<Categoria> listar()
        {
            List<Categoria> listarCategoria = new List<Categoria>();
            AccesoSQL datos = new AccesoSQL();
            datos.setConsulta("select id,Descripcion from categorias");

            try
            {
                datos.ConsultaBD();
                while (datos.Lector.Read())
                {
                    Categoria categoria = new Categoria();
                    categoria.Id = (int)datos.Lector["id"];
                    categoria.descripcion = (string)datos.Lector["Descripcion"];
                    listarCategoria.Add(categoria);
                }


                return listarCategoria;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
