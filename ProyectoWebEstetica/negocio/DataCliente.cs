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

        public List<Cliente> ListarClientes(string id = "")
        {
            List<Cliente> lista = new List<Cliente>();
            AccesoSQL datos = new AccesoSQL();

            try
            {
                string consulta = "SELECT Id, Nombre, Apellido, DNI, FechaNac, Telefono, Email, UsuarioId FROM Cliente";
                //if (id!="")
                //{
                //    consulta += "WHERE id = " + id;
                //}
                if (!string.IsNullOrWhiteSpace(id))
                {
                    consulta += " WHERE Id = @id";
                    datos.setParametro("@id", int.Parse(id));
                }
                datos.setConsulta(consulta);
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

                    if (!(datos.Lector["FechaNac"] is DBNull))
                        aux.fechaNac = (DateTime)datos.Lector["FechaNac"];

                    if (!(datos.Lector["UsuarioId"] is DBNull))
                        aux.UsuarioId = (int)datos.Lector["UsuarioId"];

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
        public void modificarCliente(Cliente mod)
        {
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setearprocedimiento("storedModificarCliente");

                // Parámetros del Cliente
                datos.setParametro("@Id", mod.IdCliente);
                datos.setParametro("@Nombre", mod.Nombre);
                datos.setParametro("@Apellido", mod.Apellido);
                datos.setParametro("@DNI", mod.DNI);
                datos.setParametro("@FechaNac", mod.fechaNac);
                datos.setParametro("@Telefono", mod.Telefono);
                datos.setParametro("@Email", mod.Email);
          
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
