using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
                datos.setConsulta(
                    "SELECT U.Id, U.users, U.Email, U.TipoUsuarioId " +
                    "FROM Usuario U " +
                    "INNER JOIN TipoUsuario T ON T.Id = U.TipoUsuarioId " +
                    "WHERE U.Email = @usuario " +
                    "AND U.Pass = @pass " +
                    "AND U.Baja = 0"
                );

                datos.setParametro("@usuario", email);
                datos.setParametro("@pass", clave);

                datos.ConsultaBD();

                if (!datos.Lector.Read())
                {
                    return null;
                }

                Usuario usuario = new Usuario();

                usuario.Id = (int)datos.Lector["Id"];
                usuario.User = (string)datos.Lector["users"];
                usuario.Email = (string)datos.Lector["Email"];
                usuario.TipoUsuarioId = (int)datos.Lector["TipoUsuarioId"];
                usuario.Baja = false;

                return usuario;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}