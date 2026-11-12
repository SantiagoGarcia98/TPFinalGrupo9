CREATE DATABASE TurnosDB
GO
USE TurnosDB;
GO

-- 1. Catálogos
CREATE TABLE Especialidad (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL -- Precio base sugerido al dar de alta el turno
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

-- 2. Cuenta de acceso. Administrador y Recepcionista viven solo acá.
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

-- 1. Tipos de Usuario
INSERT INTO TipoUsuario (Descripcion) VALUES
('Administrador'),
('Recepcionista'),
('Cliente'),
('Profesional');

-- 2. Estados del Turno
INSERT INTO TurnoEstado (Descripcion) VALUES
('Pendiente'),
('Confirmado'),
('Cancelado'),
('Atendido');

-- 3. Especialidades
INSERT INTO Especialidad (Descripcion, Precio) VALUES
('Manicura', 15000.00),
('Perfilado', 30000.00),
('Lifting', 25000.00);

-- 4. Sucursales
INSERT INTO Sucursal (Nombre, Direccion, Telefono, Activo) VALUES
('Casa Central', 'Tigre 2828', '1144556677', 1),
('Sucursal Norte', 'Ruta 8 Km 40', '1144556688', 1);

-- 5. Usuarios: 1 Cliente, 2 y 3 Profesionales
INSERT INTO Usuario (users,Email, Pass, Baja, TipoUsuarioId) VALUES
('cgonzalez','cgonzalez@estetica.com', 'usu123', 0, 3),
('jperez', 'jperez@estetica.com','pro123', 0, 4),
('mgomez','mgomez@estetica.com' ,'pro123', 0, 4),
('admin', 'admin@estetica.com','admin123', 0, 1),
('recepionista', 'recep@estetica.com','recep123', 0, 2);

-- 6. Cliente vinculado al usuario 1
INSERT INTO Cliente (Nombre, Apellido, DNI, FechaNac, Telefono, UsuarioId) VALUES
('Carlos', 'González', '30123456', '1990-05-15', '1122334455', 1);

-- 7. Profesionales vinculados a su usuario y a una sucursal
INSERT INTO Profesional (Nombre, Apellido, DNI, Matricula, Telefono, SucursalId, UsuarioId) VALUES
('Juan', 'Pérez', '25111222', 'MP-1001', '1133445566', 1, 2),
('María', 'Gómez', '27333444', 'MP-1002', '1133445577', 2, 3);

-- 8. Servicios que realiza cada profesional
INSERT INTO ProfesionalServicio (ProfesionalId, EspecialidadId) VALUES
(1, 1),
(2, 2),
(2, 3);

-- 9. Turno de ejemplo
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, Abonado, SucursalId, TurnoEstadoId) VALUES
(
    1,
    '2026-11-15 10:30:00',
    15000.00,
    'Turno de ejemplo',
    1,
    0,
    0,
    1,
    1
);

-- 10. Servicio incluido en ese turno
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES
(1, 1, 15000.00);

-- 11. Seña del turno. El saldo sigue impago, por eso Abonado quedó en 0.
INSERT INTO Pago (TurnoId, Fecha, Monto, Medio) VALUES
(1, '2026-11-10 18:00:00', 5000.00, 'Efectivo');

-- 12 stored procedure

USE [TurnosDB]
GO
/****** Objeto: StoredProcedure [dbo].[storedListarClientes] Fecha de script: 12/11/2026 00:42:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[storedListarClientes]
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
    inner join Usuario u
    on c.UsuarioId = u.Id
    where u.TipoUsuarioId = 3
    ORDER BY Apellido ASC, Nombre ASC;
END


-- 13 storedAgregarCliente
CREATE OR ALTER PROCEDURE storedAgregarCliente
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @DNI VARCHAR(20),
    @FechaNac DATE,
    @Telefono VARCHAR(20),
    @Email VARCHAR(100),
    @Usuario VARCHAR(50),
    @Pass VARCHAR(100),
    @TipoUsuarioId INT = 3 -- ID por defecto para Cliente en la tabla Usuario
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION;
    BEGIN TRY
        -- 1. Insertar el Usuario
        INSERT INTO Usuario (users, Email, Pass, Baja, TipoUsuarioId)
        VALUES (@Usuario, @Email, @Pass, 0, @TipoUsuarioId);

        -- Obtener el ID del Usuario recién insertado
        DECLARE @NuevoUsuarioId INT = SCOPE_IDENTITY();

        -- 2. Insertar el Cliente vinculado al Usuario
        INSERT INTO Cliente (Nombre, Apellido, DNI, FechaNac, Telefono, UsuarioId)
        VALUES (@Nombre, @Apellido, @DNI, @FechaNac, @Telefono, @NuevoUsuarioId);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

-- 14 storedAgregarUsuario
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
END
GO