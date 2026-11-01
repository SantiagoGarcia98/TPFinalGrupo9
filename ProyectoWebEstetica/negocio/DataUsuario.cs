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
                datos.setConsulta("SELECT Id, Nombre, Apellido, Email, Rol, Activo FROM Usuarios WHERE Email = @email AND Clave = @clave AND Activo = 1");
                datos.setParametro("@email", email);
                datos.setParametro("@clave", clave);
                datos.ConsultaBD();

                if (!datos.Lector.Read())
                {
                    return null;
                }

                Usuario usuario = new Usuario();
                usuario.Id = (int)datos.Lector["Id"];
                usuario.Nombre = (string)datos.Lector["Nombre"];
                usuario.Apellido = (string)datos.Lector["Apellido"];
                usuario.Email = (string)datos.Lector["Email"];
                usuario.Rol = (string)datos.Lector["Rol"];
                usuario.Activo = (bool)datos.Lector["Activo"];
                return usuario;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}