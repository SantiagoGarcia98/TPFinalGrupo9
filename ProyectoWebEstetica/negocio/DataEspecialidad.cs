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
                    "SELECT Id, Descripcion, precio FROM Especialidad ORDER BY Descripcion"
                    );

                datos.ConsultaBD();

                while (datos.Lector.Read())
                {
                    Especialidad especialidad = new Especialidad();

                    especialidad.IdEspecialidad = (int)datos.Lector["Id"];
                    especialidad.Descripcion = (string)datos.Lector["Descripcion"];
                    especialidad.Precio = (decimal)datos.Lector["Precio"];
                    lista.Add(especialidad);
                }

                return lista;

            }
            finally
            { datos.cerrarConexion();
            }
        }

        public List<Especialidad> ListarAdmin(string Filtro)
        {
            List<Especialidad> lista = new List<Especialidad>();
            AccesoSQL datos = new AccesoSQL();

            try
            {
                string consulta = "SELECT Id, Descripcion, precio ,activo  FROM Especialidad ";
                if (!string.IsNullOrWhiteSpace(Filtro))
                {
                    consulta += " WHERE id LIKE @filtro OR Descripcion LIKE @filtro OR precio LIKE @filtro ";
                }
                consulta += " ORDER BY id";
                datos.setConsulta(consulta);
                if (!string.IsNullOrWhiteSpace(Filtro))
                {
                    datos.setParametro("@filtro", "%" + Filtro.Trim() + "%");
                }
                datos.ConsultaBD();
                while (datos.Lector.Read())
                {
                    Especialidad especialidad = new Especialidad();

                    especialidad.IdEspecialidad = (int)datos.Lector["Id"];
                    especialidad.Descripcion = (string)datos.Lector["Descripcion"];
                    especialidad.Precio = (decimal)datos.Lector["Precio"];
                    especialidad.Activo = (bool)datos.Lector["Activo"];
                    lista.Add(especialidad);
                }

                return lista;

            }
            finally
            {
                datos.cerrarConexion();
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
        public List<Especialidad> ListarEspecialidadElegida(string id)
        {
            List<Especialidad> lista = new List<Especialidad>();
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setConsulta("select descripcion,precio,activo,duracionminutos from especialidad where id=@id");
                datos.setParametro("@id", int.Parse(id));
                datos.ConsultaBD();

                if(datos.Lector.Read())
                {
                    Especialidad especialidad = new Especialidad();
                    especialidad.Descripcion = (string)datos.Lector["descripcion"];
                    especialidad.Precio = (decimal)datos.Lector["precio"];
                    especialidad.Activo = (bool)datos.Lector["Activo"];
                    especialidad.duracionMinutos = (int)datos.Lector["duracionMinutos"];
                    lista.Add(especialidad);
                }
                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public static void modificarEspecialidad(string id, string descripcion, string precio, string activo, string duracion)
        {
            AccesoSQL datos = new AccesoSQL();
            try
            {
                datos.setConsulta("update especialidad set descripcion = ISNULL(@descripcion,descripcion),precio = ISNULL(@precio,precio), activo = ISNULL(@activo,activo) , duracionMinutos = ISNULL(@duracionMinutos,duracionMinutos)   where id=@id");
                datos.setParametro("@id", int.Parse(id));
                datos.setParametro("@descripcion", string.IsNullOrWhiteSpace(descripcion) ? (object)DBNull.Value : descripcion);
                datos.setParametro("@precio", string.IsNullOrWhiteSpace(precio) ? (object)DBNull.Value : Convert.ToDecimal(precio));
                datos.setParametro("@activo", string.IsNullOrWhiteSpace(activo) ? (object)DBNull.Value : bool.Parse(activo));
                datos.setParametro("@duracionMinutos", string.IsNullOrWhiteSpace(duracion) ? (object)DBNull.Value : int.Parse(duracion));
                datos.ejecutarAccion();

            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public static void CrearEspecialidad(string descripcion, string precio, string duracion)
        {
            AccesoSQL datos = new AccesoSQL();
            try
            {
                datos.setConsulta("insert into especialidad (descripcion,precio,duracionMinutos) values (@descripcion,@precio,@duracion)");
                datos.setParametro("@descripcion", descripcion);
                datos.setParametro("@precio", Convert.ToDecimal(precio));
                datos.setParametro("@duracion", int.Parse(duracion));
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}