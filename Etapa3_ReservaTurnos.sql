-- IMPORTANTE:
-- Antes de ejecutar, seleccionar la base de datos correcta en SSMS.

-- Agregar la columna DuracionMinutos si todavía no existe.
IF COL_LENGTH('dbo.Especialidad', 'DuracionMinutos') IS NULL
BEGIN
    ALTER TABLE dbo.Especialidad
    ADD DuracionMinutos INT NULL;
END;
GO

-- Configurar la duración de cada tratamiento.
UPDATE dbo.Especialidad
SET DuracionMinutos =
    CASE
        WHEN Descripcion = 'Manicura' THEN 90
        WHEN Descripcion = 'Perfilado' THEN 30
        WHEN Descripcion = 'Lifting' THEN 90
    END
WHERE Descripcion IN ('Manicura', 'Perfilado', 'Lifting');
GO

CREATE OR ALTER PROCEDURE storedReservarTurno
    @UsuarioId INT,
    @EspecialidadId INT,
    @ProfesionalId INT,
    @FechaTurno DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    
    IF NOT EXISTS (
        SELECT 1
        FROM Cliente
        WHERE UsuarioId = @UsuarioId
    )
    BEGIN
    RAISERROR('No se encontró el cliente asociado al usuario.', 16, 1);
    RETURN;
END;

   IF NOT EXISTS (
    SELECT 1
    FROM Especialidad E
    INNER JOIN ProfesionalServicio PS
        ON E.Id = PS.EspecialidadId
    WHERE E.Id = @EspecialidadId
      AND PS.ProfesionalId = @ProfesionalId
      AND E.DuracionMinutos > 0
)
BEGIN
    RAISERROR('El profesional no realiza este tratamiento o falta configurar su duración.', 16, 1);
    RETURN;
END;

IF @FechaTurno <= GETDATE()
BEGIN
    RAISERROR('No se pueden reservar turnos en fechas u horas pasadas.', 16, 1);
    RETURN;
    END;

    IF DATEDIFF(DAY, '19000101', CAST(@FechaTurno AS DATE)) % 7 IN (5, 6)
BEGIN
    RAISERROR('No se pueden reservar turnos los fines de semana.', 16, 1);
    RETURN;
END;


DECLARE @DuracionMinutos INT;

SELECT @DuracionMinutos = DuracionMinutos
FROM Especialidad
WHERE Id = @EspecialidadId;

IF CAST(@FechaTurno AS TIME) < '09:00'
   OR DATEADD(MINUTE, @DuracionMinutos, @FechaTurno) >
      DATEADD(HOUR, 19, CAST(CAST(@FechaTurno AS DATE) AS DATETIME))
BEGIN
    RAISERROR('El turno debe comenzar a partir de las 9:00 y finalizar antes de las 19:00.', 16, 1);
    RETURN;
END;

IF DATEPART(MINUTE, @FechaTurno) NOT IN (0, 30)
   OR DATEPART(SECOND, @FechaTurno) <> 0
   OR DATEPART(MILLISECOND, @FechaTurno) <> 0
BEGIN
    RAISERROR('Los turnos deben comenzar cada 30 minutos.', 16, 1);
    RETURN;
END;




DECLARE @ClienteId INT;
DECLARE @SucursalId INT;
DECLARE @Precio DECIMAL(10,2);
DECLARE @EstadoPendienteId INT;

SELECT @ClienteId = Id
FROM Cliente
WHERE UsuarioId = @UsuarioId;

SELECT @SucursalId = SucursalId
FROM Profesional
WHERE Id = @ProfesionalId;

SELECT @Precio = Precio
FROM Especialidad
WHERE Id = @EspecialidadId;

SELECT @EstadoPendienteId = Id
FROM TurnoEstado
WHERE Descripcion = 'Pendiente';

IF @ClienteId IS NULL
   OR @SucursalId IS NULL
   OR @Precio IS NULL
   OR @EstadoPendienteId IS NULL
BEGIN
    RAISERROR('Faltan datos para registrar el turno.', 16, 1);
    RETURN;
END;


BEGIN TRY
    BEGIN TRANSACTION;
    DECLARE @RecursoBloqueo NVARCHAR(100);
DECLARE @ResultadoBloqueo INT;

SET @RecursoBloqueo =
    'Turno_' + CAST(@ProfesionalId AS VARCHAR(20))
    + '_' + CONVERT(VARCHAR(8), @FechaTurno, 112);

EXEC @ResultadoBloqueo = sp_getapplock
    @Resource = @RecursoBloqueo,
    @LockMode = 'Exclusive',
    @LockOwner = 'Transaction',
    @LockTimeout = 10000;

IF @ResultadoBloqueo < 0
BEGIN
    RAISERROR('No se pudo reservar el horario. Intentá nuevamente.', 16, 1);
END;

IF EXISTS (
    SELECT 1
    FROM Turno T
    INNER JOIN TurnoServicio TS ON T.Id = TS.TurnoId
    INNER JOIN Especialidad E ON TS.EspecialidadId = E.Id
    INNER JOIN TurnoEstado TE ON T.TurnoEstadoId = TE.Id
    WHERE T.ProfesionalId = @ProfesionalId
      AND T.Baja = 0
      AND TE.Descripcion <> 'Cancelado'
      AND T.FechaTurno >= CAST(@FechaTurno AS DATE)
      AND T.FechaTurno < DATEADD(DAY, 1, CAST(@FechaTurno AS DATE))
    GROUP BY T.Id, T.FechaTurno
    HAVING @FechaTurno < DATEADD(MINUTE, SUM(E.DuracionMinutos), T.FechaTurno)
       AND DATEADD(MINUTE, @DuracionMinutos, @FechaTurno) > T.FechaTurno
)
BEGIN
    RAISERROR('El profesional ya tiene un turno reservado en ese horario.', 16, 1);
END;
INSERT INTO Turno (
    ClienteId,
    FechaTurno,
    Precio,
    ProfesionalId,
    SucursalId,
    TurnoEstadoId,
    Baja,
    Abonado
)
VALUES (
    @ClienteId,
    @FechaTurno,
    @Precio,
    @ProfesionalId,
    @SucursalId,
    @EstadoPendienteId,
    0,
    0
);

DECLARE @TurnoId INT;
SET @TurnoId = SCOPE_IDENTITY();

INSERT INTO TurnoServicio (
    TurnoId,
    EspecialidadId,
    PrecioUnitario
)
VALUES (
    @TurnoId,
    @EspecialidadId,
    @Precio
);


    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    DECLARE @MensajeError NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR('%s', 16, 1, @MensajeError);
END CATCH;

END;
GO