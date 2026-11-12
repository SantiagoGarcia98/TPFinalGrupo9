using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class DataTurno
    {
        public List<Turno> ListarTurnoSp()
        {
            List<Turno> list = new List<Turno>();
            AccesoSQL datos = new AccesoSQL();
            try
            {
                datos.setearprocedimiento("storedListarTurnos");
                datos.ConsultaBD();
                while (datos.Lector.Read())
                {

                    Turno aux = new Turno();


                    aux.id = (int)datos.Lector["Id"];
                    aux.fecha = (DateTime)datos.Lector["FechaTurno"];
                    aux.precio = (decimal)datos.Lector["Precio"];

                    aux.cliente = new Cliente();
                    aux.cliente.Nombre = (string)datos.Lector["Cliente"];

                    aux.Profesional = new Profesional();
                    aux.Profesional.Nombre = (string)datos.Lector["Profesional"];

                    aux.Sucursal = new Sucursal();
                    aux.Sucursal.Nombre = (string)datos.Lector["Sucursal"];


                    list.Add(aux);

                }
                return list;
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

        public System.Data.DataTable ListarTurnosPorCliente(int usuarioId)
        {
            AccesoSQL datos = new AccesoSQL();
            System.Data.DataTable tabla = new System.Data.DataTable();

            try
            {
                datos.setearprocedimiento("storedListarTurnosPorCliente");
                datos.setParametro("@UsuarioId", usuarioId);
                datos.ConsultaBD();

                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
