using dominio;
using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace negocio
{
    public class DataSucursal
    {
        public List<Sucursal> Listar()
        {
            List<Sucursal> lista = new List<Sucursal>();
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setConsulta("SELECT Id, Nombre FROM Sucursal WHERE Activo = 1");
                datos.ConsultaBD();

                while (datos.Lector.Read())
                {
                    Sucursal sucursal = new Sucursal();
                    sucursal.IdSucursal = (int)datos.Lector["Id"];
                    sucursal.Nombre = (string)datos.Lector["Nombre"];
                    lista.Add(sucursal);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Sucursal> ListarAdmin(string filtro)
        {
            List<Sucursal> lista = new List<Sucursal>();
            AccesoSQL datos = new AccesoSQL();

            try
            {
                string consulta = "SELECT Id, Nombre, Direccion, Telefono, Activo FROM Sucursal ";
                if (!string.IsNullOrWhiteSpace(filtro))
                {
                    consulta += " WHERE nombre LIKE @filtro OR direccion LIKE @filtro OR telefono LIKE @filtro";
                }
                datos.setConsulta(consulta);
                if (!string.IsNullOrWhiteSpace(filtro))
                {
                    datos.setParametro("@filtro", "%" + filtro.Trim() + "%");
                }
                datos.ConsultaBD();

                while (datos.Lector.Read())
                {
                    Sucursal sucursal = new Sucursal();
                    sucursal.IdSucursal = (int)datos.Lector["id"];
                    sucursal.Nombre = (string)datos.Lector["Nombre"];
                    sucursal.Direccion = (string)datos.Lector["Direccion"];
                    sucursal.Telefono = (string)datos.Lector["Telefono"];
                    sucursal.Activo = (bool)datos.Lector["Activo"];
                    lista.Add(sucursal);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Sucursal> listarUsrElegido(string id)
        {
            List<Sucursal> lista = new List<Sucursal>();
            AccesoSQL datos = new AccesoSQL();
            try
            {
                datos.setConsulta("SELECT Id, Nombre, Direccion, Telefono, Activo FROM Sucursal WHERE Id = @id");
                datos.setParametro("@id", id);
                datos.ConsultaBD();

                if (datos.Lector.Read())
                {
                    Sucursal sucursal = new Sucursal();
                    sucursal.IdSucursal = (int)datos.Lector["Id"];
                    sucursal.Nombre = (string)datos.Lector["Nombre"];
                    sucursal.Direccion = (string)datos.Lector["Direccion"];
                    sucursal.Telefono = (string)datos.Lector["Telefono"];
                    sucursal.Activo = (bool)datos.Lector["Activo"];
                    lista.Add(sucursal);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public static void modificar(Sucursal sucursal)
        {
            AccesoSQL datos = new AccesoSQL();
            try
            {
               
                datos.setConsulta("UPDATE Sucursal SET Nombre = ISNULL(@Nombre,Nombre), Direccion = ISNULL(@Direccion,Direccion), telefono = ISNULL(@Telefono,Telefono), Activo = isnull(@Activo,Activo) WHERE Id = @Id");
                datos.setParametro("@Id", sucursal.IdSucursal);
                datos.setParametro("@Nombre", string.IsNullOrWhiteSpace(sucursal.Nombre) ? (object)DBNull.Value : sucursal.Nombre);
                datos.setParametro("@Direccion", string.IsNullOrWhiteSpace(sucursal.Direccion) ? (object)DBNull.Value : sucursal.Direccion);
                datos.setParametro("@Telefono", string.IsNullOrWhiteSpace(sucursal.Telefono) ? (object)DBNull.Value : sucursal.Telefono);
                datos.setParametro("@Activo", sucursal.Activo.HasValue ? (object)sucursal.Activo.Value : DBNull.Value);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public static void agregarSucursal(string nombre, string direccion, string telefono)
        {
            AccesoSQL datos = new AccesoSQL();
            try
            {
                datos.setConsulta("Insert into sucursal (nombre,direccion,telefono) values (@nombre, @direccion, @telefono)");
                datos.setParametro("@nombre", nombre);
                datos.setParametro("@direccion", direccion);
                datos.setParametro("@telefono", telefono);
                datos.ejecutarAccion();

            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}