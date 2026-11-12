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

        public System.Data.DataTable ListarHorariosOcupados(int profesionalId, DateTime fecha)
        {
            AccesoSQL datos = new AccesoSQL();
            System.Data.DataTable tabla = new System.Data.DataTable();

            try
            {
                datos.setConsulta(
                    "SELECT T.FechaTurno, " +
                    "SUM(E.DuracionMinutos) AS DuracionMinutos " +
                    "FROM Turno T " +
                    "INNER JOIN TurnoServicio TS ON T.Id = TS.TurnoId " +
                    "INNER JOIN Especialidad E ON TS.EspecialidadId = E.Id " +
                    "INNER JOIN TurnoEstado TE ON T.TurnoEstadoId = TE.Id " +
                    "WHERE T.ProfesionalId = @ProfesionalId " +
                    "AND T.FechaTurno >= @InicioDia " +
                    "AND T.FechaTurno < @FinDia " +
                    "AND T.Baja = 0 " +
                    "AND TE.Descripcion <> 'Cancelado' " +
                    "GROUP BY T.Id, T.FechaTurno " +
                    "ORDER BY T.FechaTurno"
                );

                datos.setParametro("@ProfesionalId", profesionalId);
                datos.setParametro("@InicioDia", fecha.Date);
                datos.setParametro("@FinDia", fecha.Date.AddDays(1));

                datos.ConsultaBD();

                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void ReservarTurno(int usuarioId, int especialidadId, int profesionalId, DateTime fechaTurno)
        {
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setearprocedimiento("storedReservarTurno");

                datos.setParametro("@UsuarioId", usuarioId);
                datos.setParametro("@EspecialidadId", especialidadId);
                datos.setParametro("@ProfesionalId", profesionalId);
                datos.setParametro("@FechaTurno", fechaTurno);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
