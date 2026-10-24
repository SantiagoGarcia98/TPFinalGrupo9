using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class DataMarca
    {
        public List<Marca> listar()
        {
            List<Marca> listadoMarcas = new List<Marca>();
            AccesoSQL datos = new AccesoSQL();
            datos.setConsulta("SELECT id , Descripcion FROM MARCAS");

            try
            {
                datos.ConsultaBD();
                while (datos.Lector.Read()) 
                { 
                    Marca marca = new Marca();
                    marca.Id = (int)datos.Lector["id"];
                    marca.descripcion = (string)datos.Lector["Descripcion"];
                    listadoMarcas.Add(marca);
                }
                return listadoMarcas;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion(); 
            }
        }
    }
}
