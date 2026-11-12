using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System;
using dominio;

namespace negocio
{
    public class DataUsuario
    {
        public Usuario Loguear(string email, string clave)
        {
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setConsulta("SELECT U.Id, U.users, U.Email,T.Descripcion AS Rol " + "FROM Usuario U " + "INNER JOIN TipoUsuario T ON T.Id = U.TipoUsuarioId " + "WHERE U.Email = @usuario AND U.Pass = @pass AND U.Baja = 0");
                datos.setParametro("@usuario", email);
                datos.setParametro("@pass", clave);
                datos.ConsultaBD();

                if (!datos.Lector.Read())
                {
                    return null;
                }

                Usuario usuario = new Usuario();
                usuario.Id = (int)datos.Lector["Id"];
                usuario.Email = (string)datos.Lector["Email"];
                usuario.Rol = (string)datos.Lector["Rol"];
                return usuario;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Usuario> Listar(string filtro)
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoSQL datos = new AccesoSQL();


            try
            {
                string consulta = "SELECT U.Id, U.users, U.Email, T.Descripcion AS Rol FROM Usuario U INNER JOIN TipoUsuario T ON T.Id = U.TipoUsuarioId";
                if (!string.IsNullOrWhiteSpace(filtro))
                {
                    consulta += " WHERE U.users LIKE @filtro OR U.Email LIKE @filtro OR T.Descripcion LIKE @filtro";
                }
                datos.setConsulta(consulta);
                if (!string.IsNullOrWhiteSpace(filtro))
                {
                    datos.setParametro("@filtro", "%" + filtro.Trim() + "%");
                }
                datos.ConsultaBD();

                while (datos.Lector.Read())
                {
                    Usuario usuario = new Usuario();
                    usuario.Id = (int)datos.Lector["Id"];
                    usuario.User = (string)datos.Lector["users"];
                    usuario.Email = (string)datos.Lector["Email"];
                    usuario.Rol = (string)datos.Lector["Rol"];
                    lista.Add(usuario);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }
        public List<Usuario> ListarUsrElegido(string id)
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setConsulta("SELECT U.Id, U.users, U.Email, U.Pass, U.Baja, U.TipoUsuarioId FROM Usuario U  WHERE U.Id = @id");
                datos.setParametro("@id", int.Parse(id));
                datos.ConsultaBD();

                if (datos.Lector.Read())
                {
                    Usuario usuario = new Usuario();
                    usuario.Id = (int)datos.Lector["Id"];
                    usuario.User = (string)datos.Lector["users"];
                    usuario.Email = (string)datos.Lector["Email"];
                    usuario.Pass = (string)datos.Lector["Pass"];
                    usuario.Baja = (bool)datos.Lector["Baja"];
                    usuario.TipoUsuarioId = (int)datos.Lector["TipoUsuarioId"];

                    lista.Add(usuario);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void Agregar(int tipoUsuarioId, string usuario, string email, string pass, string nombre, string apellido, string dni, string telefono, DateTime? fechaNac, string matricula, int? sucursalId, string especialidades)
        {
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setearprocedimiento("storedAgregarUsuario");
                datos.setParametro("@Usuario", usuario);
                datos.setParametro("@Email", email);
                datos.setParametro("@Pass", pass);
                datos.setParametro("@TipoUsuarioId", tipoUsuarioId);

                if (tipoUsuarioId == 3 || tipoUsuarioId == 4)
                {
                    datos.setParametro("@Nombre", nombre);
                    datos.setParametro("@Apellido", apellido);
                    datos.setParametro("@DNI", dni);
                    datos.setParametro("@Telefono", telefono);
                }

                if (tipoUsuarioId == 3)
                    datos.setParametro("@FechaNac", fechaNac);

                if (tipoUsuarioId == 4)
                {
                    datos.setParametro("@Matricula", matricula);
                    datos.setParametro("@SucursalId", sucursalId);
                    datos.setParametro("@Especialidades", especialidades);
                }

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}