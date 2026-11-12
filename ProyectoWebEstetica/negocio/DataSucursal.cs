using dominio;
using System;
using System.Collections.Generic;

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
    }
}