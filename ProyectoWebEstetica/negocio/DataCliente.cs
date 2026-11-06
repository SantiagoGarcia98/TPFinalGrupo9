using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class DataCliente
    {
        public List<Cliente> ListarClientes()
        {
            List<Cliente> lista = new List<Cliente>();
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setearprocedimiento("storedListarClientes");
                datos.ConsultaBD();

                while (datos.Lector.Read())
                {
                    Cliente aux = new Cliente();
                    aux.IdCliente = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = datos.Lector["DNI"] != DBNull.Value ? (string)datos.Lector["DNI"] : "";
                    aux.Telefono = datos.Lector["Telefono"] != DBNull.Value ? (string)datos.Lector["Telefono"] : "";
                    aux.Email = datos.Lector["Email"] != DBNull.Value ? (string)datos.Lector["Email"] : "";

                    lista.Add(aux);
                }

                return lista;
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


        public void AgregarCliente(Cliente nuevo, string usuario, string pass)
        {
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setearprocedimiento("storedAgregarCliente");

                // Parámetros del Cliente
                datos.setParametro("@Nombre", nuevo.Nombre);
                datos.setParametro("@Apellido", nuevo.Apellido);
                datos.setParametro("@DNI", nuevo.DNI);
                datos.setParametro("@FechaNac", nuevo.fechaNac);
                datos.setParametro("@Telefono", nuevo.Telefono);
                datos.setParametro("@Email", nuevo.Email);

                // Parámetros del Usuario
                datos.setParametro("@Usuario", usuario);
                datos.setParametro("@Pass", pass);
                // TipoUsuarioId de cliente es 3 

                datos.ejecutarAccion();
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
