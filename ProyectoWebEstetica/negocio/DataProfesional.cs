using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class DataProfesional
    {
        public List<Profesional> ListarPorEspecialidad(int  especialidadId)
        {
            List<Profesional> lista = new List<Profesional>();
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setConsulta(
                    "SELECT P.Id, P.Nombre, P.Apellido " +
                    "FROM Profesional P " +
                    "INNER JOIN ProfesionalServicio PS ON P.Id = PS.ProfesionalId " +
                    "WHERE PS.EspecialidadId = @EspecialidadId " +
                    "ORDER BY P.Apellido, P.Nombre"

                    );

                datos.setParametro("@EspecialidadId", especialidadId);
                datos.ConsultaBD();

                while (datos.Lector.Read())
                {
                    Profesional profesional = new Profesional();

                    profesional.IdProfesional = (int)datos.Lector["Id"];
                    profesional.Nombre = (string)datos.Lector["Nombre"];
                    profesional.Apellido = (string)datos.Lector["Apellido"];

                    lista.Add(profesional);

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
