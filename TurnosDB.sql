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
('Atendido'),
('No Asistio');

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




