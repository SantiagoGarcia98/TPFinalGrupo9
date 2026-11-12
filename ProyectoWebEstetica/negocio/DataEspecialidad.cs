using System;
using System.Collections.Generic;
using System.ComponentModel;
using dominio;


namespace negocio
{
    public class  DataEspecialidad
    {
        public List<Especialidad> Listar()
        {
            List<Especialidad> lista = new List<Especialidad>();
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setConsulta(
                    "SELECT Id, Descripcion FROM Especialidad ORDER BY Descripcion"
                    );

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
            { datos.cerrarConexion();
            }
        }

        public int ObtenerDuracionMinutos(int especialidadId)
        {
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setConsulta(
                    "SELECT DuracionMinutos FROM Especialidad WHERE Id = @Id"
                );

                datos.setParametro("@Id", especialidadId);
                datos.ConsultaBD();

                if (!datos.Lector.Read() ||
                    datos.Lector["DuracionMinutos"] == DBNull.Value)
                {
                    throw new Exception("El tratamiento no tiene duración configurada.");
                }

                return Convert.ToInt32(datos.Lector["DuracionMinutos"]);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}