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
                datos.setConsulta("SELECT U.Id, U.Usuario, T.Descripcion AS Rol " + "FROM Usuario U " + "INNER JOIN TipoUsuario T ON T.Id = U.TipoUsuarioId " + "WHERE U.Usuario = @usuario AND U.Pass = @pass AND U.Baja = 0");
                datos.setParametro("@usuario", email);
                datos.setParametro("@pass", clave);
                datos.ConsultaBD();

                if (!datos.Lector.Read())
                {
                    return null;
                }

                Usuario usuario = new Usuario();
                usuario.Id = (int)datos.Lector["Id"];
                usuario.Email = (string)datos.Lector["Usuario"];
                usuario.Rol = (string)datos.Lector["Rol"];
                return usuario;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}