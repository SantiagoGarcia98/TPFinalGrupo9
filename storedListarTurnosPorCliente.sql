-- EstetiMed - Etapa 2
-- Procedimiento para consultar los turnos del cliente conectado.
-- Ejecutar sobre la base de datos del proyecto.

CREATE OR ALTER PROCEDURE storedListarTurnosPorCliente
    @UsuarioId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        T.Id,
        CAST(T.FechaTurno AS DATE) AS Fecha,
        CONVERT(VARCHAR(5), T.FechaTurno, 108) AS Horario,
        E.Descripcion AS Tratamiento,
        P.Nombre + ' ' + P.Apellido AS Profesional,
        TE.Descripcion AS Estado
    FROM Turno T
    INNER JOIN Cliente C ON T.ClienteId = C.Id
    INNER JOIN Profesional P ON T.ProfesionalId = P.Id
    INNER JOIN TurnoEstado TE ON T.TurnoEstadoId = TE.Id
    INNER JOIN TurnoServicio TS ON TS.TurnoId = T.Id
    INNER JOIN Especialidad E ON TS.EspecialidadId = E.Id
    WHERE C.UsuarioId = @UsuarioId
      AND T.Baja = 0
    ORDER BY T.FechaTurno DESC;
END;
GO