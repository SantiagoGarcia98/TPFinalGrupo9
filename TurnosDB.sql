CREATE DATABASE TurnosDB;
GO
USE TurnosDB;
GO

-- =============================================
-- 1. CREACIÓN DE TABLAS (CATÁLOGOS Y ENTIDADES)
-- =============================================

CREATE TABLE Especialidad (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL, -- Precio base sugerido al dar de alta el turno
    DuracionMinutos INT NULL,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Sucursal (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    Telefono VARCHAR(30) NULL,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE TurnoEstado (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL -- Ej: Pendiente, Confirmado, Cancelado, Atendido
);

CREATE TABLE TipoUsuario (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL -- Administrador, Recepcionista, Cliente, Profesional
);

-- Cuenta de acceso. Administrador y Recepcionista viven solo acá.
CREATE TABLE Usuario (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    users VARCHAR(50) NOT NULL,
    Email VARCHAR(150) NOT NULL,
    Pass VARCHAR(255) NOT NULL,
    Baja BIT NOT NULL DEFAULT 0,
    TipoUsuarioId INT NOT NULL,
    CONSTRAINT FK_Usuario_TipoUsuario FOREIGN KEY (TipoUsuarioId) REFERENCES TipoUsuario(Id)
);

CREATE TABLE Cliente (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) NOT NULL,
    FechaNac DATE NULL,
    Telefono VARCHAR(30) NULL,
    UsuarioId INT NOT NULL,
    CONSTRAINT FK_Cliente_Usuario FOREIGN KEY (UsuarioId) REFERENCES Usuario(Id)
);

CREATE TABLE Profesional (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) NOT NULL,
    Matricula VARCHAR(30) NOT NULL,
    Telefono VARCHAR(30) NULL,
    SucursalId INT NOT NULL,
    UsuarioId INT NOT NULL,
    CONSTRAINT UQ_Profesional_Matricula UNIQUE (Matricula),
    CONSTRAINT FK_Profesional_Sucursal FOREIGN KEY (SucursalId) REFERENCES Sucursal(Id),
    CONSTRAINT FK_Profesional_Usuario FOREIGN KEY (UsuarioId) REFERENCES Usuario(Id)
);

-- Servicios que puede realizar cada profesional
CREATE TABLE ProfesionalServicio (
    ProfesionalId INT NOT NULL,
    EspecialidadId INT NOT NULL,
    CONSTRAINT PK_ProfesionalServicio PRIMARY KEY (ProfesionalId, EspecialidadId),
    CONSTRAINT FK_ProfesionalServicio_Profesional FOREIGN KEY (ProfesionalId) REFERENCES Profesional(Id),
    CONSTRAINT FK_ProfesionalServicio_Especialidad FOREIGN KEY (EspecialidadId) REFERENCES Especialidad(Id)
);

CREATE TABLE Turno (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ClienteId INT NOT NULL,
    FechaTurno DATETIME NOT NULL,
    Precio DECIMAL(10,2) NOT NULL, -- Total congelado al reservar
    Observaciones VARCHAR(500) NULL,
    ProfesionalId INT NOT NULL,
    Baja BIT NOT NULL DEFAULT 0,
    Abonado BIT NOT NULL DEFAULT 0,
    SucursalId INT NOT NULL,
    TurnoEstadoId INT NOT NULL,
    CONSTRAINT FK_Turno_Cliente FOREIGN KEY (ClienteId) REFERENCES Cliente(Id),
    CONSTRAINT FK_Turno_Profesional FOREIGN KEY (ProfesionalId) REFERENCES Profesional(Id),
    CONSTRAINT FK_Turno_Sucursal FOREIGN KEY (SucursalId) REFERENCES Sucursal(Id),
    CONSTRAINT FK_Turno_TurnoEstado FOREIGN KEY (TurnoEstadoId) REFERENCES TurnoEstado(Id)
);

-- Servicios incluidos en un turno, con el precio de ese momento
CREATE TABLE TurnoServicio (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TurnoId INT NOT NULL,
    EspecialidadId INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_TurnoServicio_Turno FOREIGN KEY (TurnoId) REFERENCES Turno(Id),
    CONSTRAINT FK_TurnoServicio_Especialidad FOREIGN KEY (EspecialidadId) REFERENCES Especialidad(Id)
);

-- Cobros de un turno. Puede haber más de uno (seña y saldo).
CREATE TABLE Pago (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TurnoId INT NOT NULL,
    Fecha DATETIME NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    Medio VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Pago_Turno FOREIGN KEY (TurnoId) REFERENCES Turno(Id)
);
GO

-- =============================================
-- 2. DATOS INICIALES (SEED DATA)
-- =============================================

-- Tipos de Usuario
INSERT INTO TipoUsuario (Descripcion) VALUES
('Administrador'),
('Recepcionista'),
('Cliente'),
('Profesional');

-- Estados del Turno
INSERT INTO TurnoEstado (Descripcion) VALUES
('Pendiente'),
('Confirmado'),
('Cancelado'),
('Atendido');

-- Especialidades (con precio, duración y estado activo)
INSERT INTO Especialidad (Descripcion, Precio, DuracionMinutos, Activo) VALUES
('Manicura', 15000.00, 90, 1),
('Perfilado', 30000.00, 30, 1),
('Lifting', 25000.00, 90, 1);

-- Sucursales
INSERT INTO Sucursal (Nombre, Direccion, Telefono, Activo) VALUES
('Casa Central', 'Tigre 2828', '1144556677', 1),
('Sucursal Norte', 'Ruta 8 Km 40', '1144556688', 1);

-- Usuarios: 1 Cliente, 2 y 3 Profesionales, 4 Admin, 5 Recepcionista
INSERT INTO Usuario (users, Email, Pass, Baja, TipoUsuarioId) VALUES
('cgonzalez', 'cgonzalez@estetica.com', 'usu123', 0, 3),
('jperez', 'jperez@estetica.com', 'pro123', 0, 4),
('mgomez', 'mgomez@estetica.com', 'pro123', 0, 4),
('admin', 'admin@estetica.com', 'admin123', 0, 1),
('recepionista', 'recep@estetica.com', 'recep123', 0, 2);

-- Cliente vinculado al usuario 1
INSERT INTO Cliente (Nombre, Apellido, DNI, FechaNac, Telefono, UsuarioId) VALUES
('Carlos', 'González', '30123456', '1990-05-15', '1122334455', 1);

-- Profesionales vinculados a su usuario y a una sucursal
INSERT INTO Profesional (Nombre, Apellido, DNI, Matricula, Telefono, SucursalId, UsuarioId) VALUES
('Juan', 'Pérez', '25111222', 'MP-1001', '1133445566', 1, 2),
('María', 'Gómez', '27333444', 'MP-1002', '1133445577', 2, 3);

-- Servicios que realiza cada profesional
INSERT INTO ProfesionalServicio (ProfesionalId, EspecialidadId) VALUES
(1, 1),
(2, 2),
(2, 3);

-- Turno de ejemplo
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId) VALUES
(1, '2026-11-15 10:30:00', 15000.00, 'Turno de ejemplo', 1, 0, 0, 1, 1);

-- Servicio incluido en ese turno
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES
(1, 1, 15000.00);

-- Seña del turno (el saldo sigue impago, por eso Abonado quedó en 0)
INSERT INTO Pago (TurnoId, Fecha, Monto, Medio) VALUES
(1, '2026-11-10 18:00:00', 5000.00, 'Efectivo');
GO

-- =============================================
-- 3. PROCEDIMIENTOS ALMACENADOS
-- =============================================

-- Listar Clientes
CREATE OR ALTER PROCEDURE storedListarClientes
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.Id,
        c.Nombre,
        c.Apellido,
        c.DNI,
        c.FechaNac,
        c.Telefono,
        u.email,
        c.UsuarioId
    FROM Cliente c
    INNER JOIN Usuario u ON c.UsuarioId = u.Id
    ORDER BY c.Apellido ASC, c.Nombre ASC;
END;
GO

-- Agregar Cliente (Alta simple)
CREATE OR ALTER PROCEDURE storedAgregarCliente
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @DNI VARCHAR(20),
    @FechaNac DATE,
    @Telefono VARCHAR(20),
    @Email VARCHAR(100),
    @Usuario VARCHAR(50),
    @Pass VARCHAR(100),
    @TipoUsuarioId INT = 3 -- ID por defecto para Cliente
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO Usuario (users, Email, Pass, Baja, TipoUsuarioId)
        VALUES (@Usuario, @Email, @Pass, 0, @TipoUsuarioId);

        DECLARE @NuevoUsuarioId INT = SCOPE_IDENTITY();

        INSERT INTO Cliente (Nombre, Apellido, DNI, FechaNac, Telefono, UsuarioId)
        VALUES (@Nombre, @Apellido, @DNI, @FechaNac, @Telefono, @NuevoUsuarioId);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- Agregar Usuario (Alta general por rol: Cliente, Profesional, Admin, Recepcionista)
CREATE OR ALTER PROCEDURE storedAgregarUsuario
    @Usuario VARCHAR(50),
    @Email VARCHAR(150),
    @Pass VARCHAR(255),
    @TipoUsuarioId INT,
    @Nombre VARCHAR(100) = NULL,
    @Apellido VARCHAR(100) = NULL,
    @DNI VARCHAR(20) = NULL,
    @Telefono VARCHAR(30) = NULL,
    @FechaNac DATE = NULL,
    @Matricula VARCHAR(30) = NULL,
    @SucursalId INT = NULL,
    @Especialidades VARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Rol VARCHAR(50);

    SELECT @Rol = Descripcion
    FROM TipoUsuario
    WHERE Id = @TipoUsuarioId;

    IF @Rol IS NULL
        THROW 50001, 'El rol no existe.', 1;

    IF @Usuario IS NULL OR LTRIM(RTRIM(@Usuario)) = ''
        OR @Email IS NULL OR LTRIM(RTRIM(@Email)) = ''
        OR @Pass IS NULL OR LTRIM(RTRIM(@Pass)) = ''
        THROW 50002, 'Usuario, email y contraseña son obligatorios.', 1;

    IF EXISTS (SELECT 1 FROM Usuario WHERE Email = @Email)
        THROW 50003, 'El email ya está registrado.', 1;

    IF @Rol IN ('Cliente', 'Profesional')
    BEGIN
        IF @Nombre IS NULL OR LTRIM(RTRIM(@Nombre)) = ''
            OR @Apellido IS NULL OR LTRIM(RTRIM(@Apellido)) = ''
            OR @DNI IS NULL OR LTRIM(RTRIM(@DNI)) = ''
            OR @Telefono IS NULL OR LTRIM(RTRIM(@Telefono)) = ''
            THROW 50004, 'Nombre, apellido, DNI y teléfono son obligatorios.', 1;
    END

    IF @Rol = 'Cliente' AND @FechaNac IS NULL
        THROW 50005, 'La fecha de nacimiento es obligatoria.', 1;

    IF @Rol = 'Profesional'
    BEGIN
        IF @Matricula IS NULL OR LTRIM(RTRIM(@Matricula)) = ''
            THROW 50006, 'La matrícula es obligatoria.', 1;

        IF EXISTS (SELECT 1 FROM Profesional WHERE Matricula = @Matricula)
            THROW 50007, 'La matrícula ya está registrada.', 1;

        IF @SucursalId IS NULL
            OR NOT EXISTS (SELECT 1 FROM Sucursal WHERE Id = @SucursalId AND Activo = 1)
            THROW 50008, 'La sucursal no existe.', 1;

        IF @Especialidades IS NULL OR LTRIM(RTRIM(@Especialidades)) = ''
            THROW 50009, 'Tiene que elegir al menos una especialidad.', 1;

        IF EXISTS (
            SELECT 1
            FROM STRING_SPLIT(@Especialidades, ',') AS parte
            WHERE TRY_CAST(LTRIM(RTRIM(parte.[value])) AS INT) IS NULL
               OR NOT EXISTS (
                    SELECT 1
                    FROM Especialidad
                    WHERE Id = TRY_CAST(LTRIM(RTRIM(parte.[value])) AS INT)
               )
        )
            THROW 50010, 'Hay una especialidad que no existe.', 1;
    END

    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO Usuario (users, Email, Pass, Baja, TipoUsuarioId)
        VALUES (@Usuario, @Email, @Pass, 0, @TipoUsuarioId);

        DECLARE @NuevoUsuarioId INT = SCOPE_IDENTITY();

        IF @Rol = 'Cliente'
        BEGIN
            INSERT INTO Cliente (Nombre, Apellido, DNI, FechaNac, Telefono, UsuarioId)
            VALUES (@Nombre, @Apellido, @DNI, @FechaNac, @Telefono, @NuevoUsuarioId);
        END
        ELSE IF @Rol = 'Profesional'
        BEGIN
            INSERT INTO Profesional (Nombre, Apellido, DNI, Matricula, Telefono, SucursalId, UsuarioId)
            VALUES (@Nombre, @Apellido, @DNI, @Matricula, @Telefono, @SucursalId, @NuevoUsuarioId);

            DECLARE @NuevoProfesionalId INT = SCOPE_IDENTITY();

            INSERT INTO ProfesionalServicio (ProfesionalId, EspecialidadId)
            SELECT DISTINCT @NuevoProfesionalId, CAST(LTRIM(RTRIM(parte.[value])) AS INT)
            FROM STRING_SPLIT(@Especialidades, ',') AS parte;

            IF @@ROWCOUNT = 0
                THROW 50009, 'Tiene que elegir al menos una especialidad.', 1;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- Modificar Cliente
CREATE OR ALTER PROCEDURE storedModificarCliente
    @Id INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @FechaNac DATE,
    @Telefono VARCHAR(30),
    @Email VARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Cliente
    SET 
        Nombre = @Nombre,
        Apellido = @Apellido,
        DNI = @DNI,
        FechaNac = @FechaNac,
        Telefono = @Telefono
    WHERE Id = @Id;

    UPDATE Usuario
    SET 
        email = @Email
    WHERE Id = (SELECT UsuarioId FROM Cliente WHERE Id = @Id);
END;
GO

-- Listar todos los Turnos activos
CREATE OR ALTER PROCEDURE storedListarTurnos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        T.Id,
        T.FechaTurno,
        T.Precio,
        T.Observaciones,
        C.Nombre + ' ' + C.Apellido AS Cliente,
        P.Nombre + ' ' + P.Apellido AS Profesional,
        S.Nombre AS Sucursal,
        TE.Descripcion AS Estado
    FROM Turno T
    INNER JOIN Cliente C ON T.ClienteId = C.Id
    INNER JOIN Profesional P ON T.ProfesionalId = P.Id
    INNER JOIN Sucursal S ON T.SucursalId = S.Id
    INNER JOIN TurnoEstado TE ON T.TurnoEstadoId = TE.Id
    WHERE T.Baja = 0
    ORDER BY T.FechaTurno DESC;
END;
GO

-- Listar Turnos por Cliente conectado
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

-- Reservar Turno (con validación de horarios, solapamientos y bloqueo transaccional)
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

SELECT * 
FROM turno

CREATE PROCEDURE storedModificarTurno
    @Id INT,
    @ClienteId INT,
    @FechaTurno DATETIME,
    @Precio DECIMAL(10,2),
    @Observaciones VARCHAR(500) = NULL,
    @ProfesionalId INT,
    @Baja BIT,
    @Abonado BIT,
    @SucursalId INT,
    @TurnoEstadoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Turno
    SET 
        ClienteId = @ClienteId,
        FechaTurno = @FechaTurno,
        Precio = @Precio,
        Observaciones = @Observaciones,
        ProfesionalId = @ProfesionalId,
        Baja = @Baja,
        Abonado = @Abonado,
        SucursalId = @SucursalId,
        TurnoEstadoId = @TurnoEstadoId
    WHERE Id = @Id;
END;
GO

CREATE  PROCEDURE storedObtenerTurnoPorId
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        T.Id,
        T.ClienteId,
        T.FechaTurno,
        T.Precio,
        T.Observaciones,
        T.ProfesionalId,
        T.Baja,
        T.Abonado,
        T.SucursalId,
        T.TurnoEstadoId,
        TS.EspecialidadId
    FROM Turno T
    LEFT JOIN TurnoServicio TS ON T.Id = TS.TurnoId
    WHERE T.Id = @Id;
END;
GO

 ALTER PROCEDURE storedModificarTurno
    @Id INT,
    @ClienteId INT,
    @FechaTurno DATETIME,
    @Precio DECIMAL(10,2),
    @Observaciones VARCHAR(500) = NULL,
    @ProfesionalId INT,
    @Baja BIT,
    @Abonado BIT,
    @SucursalId INT,
    @TurnoEstadoId INT,
    @EspecialidadId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Turno
    SET 
        ClienteId = @ClienteId,
        FechaTurno = @FechaTurno,
        Precio = @Precio,
        Observaciones = @Observaciones,
        ProfesionalId = @ProfesionalId,
        Baja = @Baja,
        Abonado = @Abonado,
        SucursalId = @SucursalId,
        TurnoEstadoId = @TurnoEstadoId
    WHERE Id = @Id;

    IF EXISTS (SELECT 1 FROM TurnoServicio WHERE TurnoId = @Id)
    BEGIN
        UPDATE TurnoServicio
        SET EspecialidadId = @EspecialidadId,
            PrecioUnitario = @Precio
        WHERE TurnoId = @Id;
    END
    ELSE
    BEGIN
        INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario)
        VALUES (@Id, @EspecialidadId, @Precio);
    END
END;
GO


USE TurnosDB;
GO

INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES
    (1, '2026-11-20 10:00:00', 15000.00, 'Manicura semipermanente', 1, 0, 1, 1, 2),
    (2, '2026-11-21 11:30:00', 25000.00, 'Perfilado y laminado de cejas', 2, 0, 0, 2, 1),
    (3, '2026-11-22 15:00:00', 30000.00, 'Lifting de pestañas', 2, 0, 1, 1, 2),
    (4, '2026-11-23 17:00:00', 35000.00, 'Sesión Babylips hidratación', 1, 0, 0, 2, 1);

-- 5. Asociar cada turno con su tratamiento en TurnoServicio
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario)
VALUES
    (1, 3, 15000.00),
    (2, 4, 25000.00),
    (3, 2, 30000.00),
    (4, 1, 35000.00);

SELECT *
FROM usuario

SELECT *
FROM Especialidad

SELECT *
FROM ProfesionalServicio , Profesional


-- 1. Asegurar las 6 especialidades del inicio en Especialidad (singular)
UPDATE Especialidad
SET Descripcion = 'Limpieza facial', Precio = 28000.00, DuracionMinutos = 60, Activo = 1
WHERE Id = 2;

UPDATE Especialidad
SET Descripcion = 'MicroPigmentacion', Precio = 45000.00, DuracionMinutos = 90, Activo = 1
WHERE Id = 4;

IF NOT EXISTS (SELECT 1 FROM Especialidad WHERE Descripcion = 'Depilacion laser')
    INSERT INTO Especialidad (Descripcion, Precio, DuracionMinutos, Activo)
    VALUES ('Depilacion laser', 35000.00, 45, 1);

IF NOT EXISTS (SELECT 1 FROM Especialidad WHERE Descripcion = 'Electrodos')
    INSERT INTO Especialidad (Descripcion, Precio, DuracionMinutos, Activo)
    VALUES ('Electrodos', 22000.00, 45, 1);

-- 2. Crear los 6 usuarios para los profesionales nuevos (TipoUsuarioId = 4)
INSERT INTO Usuario (users, Email, Pass, Baja, TipoUsuarioId)
VALUES 
    ('cfernandez', 'cfernandez@estetica.com', 'pro123', 0, 4),
    ('vrossi',     'vrossi@estetica.com',     'pro123', 0, 4),
    ('lbenitez',   'lbenitez@estetica.com',   'pro123', 0, 4),
    ('fdiaz',      'fdiaz@estetica.com',      'pro123', 0, 4),
    ('macosta',    'macosta@estetica.com',    'pro123', 0, 4),
    ('jsosa',      'jsosa@estetica.com',      'pro123', 0, 4);

-- 3. Insertar los 6 profesionales nuevos buscando su UsuarioId recién creado
INSERT INTO Profesional (Nombre, Apellido, DNI, Matricula, Telefono, SucursalId, UsuarioId)
VALUES 
    ('Camila',    'Fernández', '34555666', 'MP-1003', '1144556677', 1, (SELECT Id FROM Usuario WHERE users = 'cfernandez')),
    ('Valentina', 'Rossi',     '36777888', 'MP-1004', '1155667788', 2, (SELECT Id FROM Usuario WHERE users = 'vrossi')),
    ('Lucía',     'Benítez',   '32888999', 'MP-1005', '1166778899', 1, (SELECT Id FROM Usuario WHERE users = 'lbenitez')),
    ('Florencia', 'Díaz',      '35999000', 'MP-1006', '1177889900', 2, (SELECT Id FROM Usuario WHERE users = 'fdiaz')),
    ('Martín',    'Acosta',    '31222333', 'MP-1007', '1188990011', 1, (SELECT Id FROM Usuario WHERE users = 'macosta')),
    ('Julieta',   'Sosa',      '38444555', 'MP-1008', '1199001122', 2, (SELECT Id FROM Usuario WHERE users = 'jsosa'));

-- 4. Vincular cada profesional con su especialidad en ProfesionalServicio
INSERT INTO ProfesionalServicio (ProfesionalId, EspecialidadId)
VALUES
    ((SELECT Id FROM Profesional WHERE Matricula = 'MP-1003'), (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Manicura')),
    ((SELECT Id FROM Profesional WHERE Matricula = 'MP-1004'), (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Lifting')),
    ((SELECT Id FROM Profesional WHERE Matricula = 'MP-1005'), (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Limpieza facial')),
    ((SELECT Id FROM Profesional WHERE Matricula = 'MP-1006'), (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Depilacion laser')),
    ((SELECT Id FROM Profesional WHERE Matricula = 'MP-1007'), (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Electrodos')),
    ((SELECT Id FROM Profesional WHERE Matricula = 'MP-1008'), (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'MicroPigmentacion'));

-- 5. Verificar que quedaron todos asociados correctamente
SELECT p.Id, p.Nombre, p.Apellido, p.Matricula, e.Descripcion AS Especialidad
FROM Profesional p
INNER JOIN ProfesionalServicio ps ON p.Id = ps.ProfesionalId
INNER JOIN Especialidad e ON ps.EspecialidadId = e.Id
ORDER BY e.Id, p.Id;


-- =========================================================
-- 1. CREAR 6 USUARIOS Y 6 CLIENTES NUEVOS (10 en total)
-- =========================================================
INSERT INTO Usuario (users, Email, Pass, Baja, TipoUsuarioId)
VALUES 
    ('valentina.paz',  'valentina.paz@gmail.com',  '1234', 0, 4),
    ('diego.torres',   'diego.torres@gmail.com',   '1234', 0, 4),
    ('carla.gimenez',  'carla.gimenez@gmail.com',  '1234', 0, 4),
    ('nicolas.vega',   'nicolas.vega@gmail.com',   '1234', 0, 4),
    ('agustina.silva', 'agustina.silva@gmail.com', '1234', 0, 4),
    ('facundo.ruiz',   'facundo.ruiz@gmail.com',   '1234', 0, 4);

INSERT INTO Cliente (Nombre, Apellido, DNI, FechaNac, Telefono, UsuarioId)
VALUES
    ('Valentina', 'Paz',     '37112233', '1994-06-15', '1145678901', (SELECT Id FROM Usuario WHERE users = 'valentina.paz')),
    ('Diego',     'Torres',  '39445566', '1990-02-28', '1156789012', (SELECT Id FROM Usuario WHERE users = 'diego.torres')),
    ('Carla',     'Giménez', '34778899', '1996-08-10', '1167890123', (SELECT Id FROM Usuario WHERE users = 'carla.gimenez')),
    ('Nicolás',   'Vega',    '40123456', '1999-12-03', '1178901234', (SELECT Id FROM Usuario WHERE users = 'nicolas.vega')),
    ('Agustina',  'Silva',   '36987654', '1993-05-19', '1189012345', (SELECT Id FROM Usuario WHERE users = 'agustina.silva')),
    ('Facundo',   'Ruiz',    '32654321', '1987-10-30', '1190123456', (SELECT Id FROM Usuario WHERE users = 'facundo.ruiz'));




    -- =========================================================
-- 2. INSERTAR 20 TURNOS + SU REGISTRO EN TurnoServicio
-- =========================================================
DECLARE @TurnoId INT;

-- Turno 1
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '38451290'), '2026-11-24 10:00:00', 28000.00, 'Limpieza profunda piel mixta', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1005'), 0, 1, 1, 4);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Limpieza facial'), 28000.00);

-- Turno 2
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '37112233'), '2026-11-25 11:30:00', 35000.00, 'Primera sesión pierna entera', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1006'), 0, 1, 2, 4);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Depilacion laser'), 35000.00);

-- Turno 3
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '39445566'), '2026-11-25 16:00:00', 22000.00, 'Sesión abdomen y glúteos', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1007'), 0, 0, 1, 3);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Electrodos'), 22000.00);

-- Turno 4
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '34778899'), '2026-11-26 14:30:00', 45000.00, 'Retoque de cejas pelo a pelo', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1008'), 0, 1, 2, 2);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'MicroPigmentacion'), 45000.00);

-- Turno 5
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '40123456'), '2026-11-27 09:30:00', 15000.00, 'Esmaltado semipermanente', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1003'), 0, 0, 1, 2);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Manicura'), 15000.00);

-- Turno 6
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '36987654'), '2026-11-27 15:00:00', 25000.00, 'Lifting con tinte de pestañas', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1004'), 0, 1, 2, 2);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Lifting'), 25000.00);

-- Turno 7
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '32654321'), '2026-11-28 10:30:00', 28000.00, NULL, (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1005'), 0, 0, 1, 1);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Limpieza facial'), 28000.00);

-- Turno 8
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '41209876'), '2026-11-30 17:00:00', 35000.00, 'Axilas y cavado', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1006'), 0, 1, 2, 2);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Depilacion laser'), 35000.00);

-- Turno 9
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '35982144'), '2026-12-01 11:00:00', 22000.00, 'Pack 1 de 4 sesiones', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1007'), 0, 1, 1, 1);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Electrodos'), 22000.00);

-- Turno 10
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '33765412'), '2026-12-02 16:30:00', 45000.00, 'Micropigmentación labial', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1008'), 0, 0, 2, 1);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'MicroPigmentacion'), 45000.00);

-- Turno 11
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '37112233'), '2026-12-03 10:00:00', 15000.00, 'Kapping gel', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1001'), 0, 1, 1, 2);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Manicura'), 15000.00);

-- Turno 12
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '34778899'), '2026-12-04 14:00:00', 25000.00, NULL, (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1002'), 0, 0, 2, 1);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Lifting'), 25000.00);

-- Turno 13
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '39445566'), '2026-12-05 11:30:00', 28000.00, 'Extracción e hidratación', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1005'), 0, 1, 1, 2);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Limpieza facial'), 28000.00);

-- Turno 14
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '36987654'), '2026-12-07 18:00:00', 35000.00, 'Segunda sesión rostro completo', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1006'), 0, 0, 2, 1);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Depilacion laser'), 35000.00);

-- Turno 15
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '40123456'), '2026-12-09 09:30:00', 22000.00, 'Tonificación piernas', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1007'), 0, 1, 1, 2);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Electrodos'), 22000.00);

-- Turno 16
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '38451290'), '2026-12-10 15:30:00', 45000.00, 'Evaluación previa incluida', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1008'), 0, 0, 2, 3);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'MicroPigmentacion'), 45000.00);

-- Turno 17
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '32654321'), '2026-12-11 12:00:00', 15000.00, 'Manicura clásica', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1003'), 0, 1, 1, 1);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Manicura'), 15000.00);

-- Turno 18
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '41209876'), '2026-12-14 16:00:00', 25000.00, 'Nutrición con keratina', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1004'), 0, 1, 2, 2);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Lifting'), 25000.00);

-- Turno 19
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '35982144'), '2026-12-15 10:30:00', 28000.00, 'Peeling enzimático suave', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1005'), 0, 0, 1, 1);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Limpieza facial'), 28000.00);

-- Turno 20
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId)
VALUES ((SELECT TOP 1 Id FROM Cliente WHERE DNI = '33765412'), '2026-12-17 17:30:00', 35000.00, 'Repaso zona espalda', (SELECT TOP 1 Id FROM Profesional WHERE Matricula = 'MP-1006'), 0, 1, 2, 1);
SET @TurnoId = SCOPE_IDENTITY();
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES (@TurnoId, (SELECT TOP 1 Id FROM Especialidad WHERE Descripcion = 'Depilacion laser'), 35000.00);

-- =========================================================
-- 3. COMPROBAR EL LISTADO RESULTANTE
-- =========================================================
EXEC storedListarTurnos;