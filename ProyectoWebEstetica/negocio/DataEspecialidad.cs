using dominio;
using System;
using System.Collections.Generic;

namespace negocio
{
    public class DataEspecialidad
    {
        public List<Especialidad> Listar()
        {
            List<Especialidad> lista = new List<Especialidad>();
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setConsulta("SELECT Id, Descripcion FROM Especialidad");
                datos.ConsultaBD();

                while (datos.Lector.Read())
                {
                    Especialidad especialidad = new Especialidad();
                    especialidad.IdEspecialidad = (int)datos.Lector["Id"];
                    especialidad.Descripcion = (string)datos.Lector["Descripcion"];
                    lista.Add(especialidad);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}