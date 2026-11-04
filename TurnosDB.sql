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
    Usuario VARCHAR(50) NOT NULL,
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
    Email VARCHAR(150) NULL,
    UsuarioId INT NOT NULL,
    CONSTRAINT FK_Cliente_Usuario FOREIGN KEY (UsuarioId) REFERENCES Usuario(Id)
);

CREATE TABLE Profesional (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) NOT NULL,
    Telefono VARCHAR(30) NULL,
    Email VARCHAR(150) NULL,
    SucursalId INT NOT NULL,
    UsuarioId INT NOT NULL,
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
INSERT INTO Usuario (Usuario, Pass, Baja, TipoUsuarioId) VALUES
('cgonzalez', 'usu123', 0, 3),
('jperez', 'pro123', 0, 4),
('mgomez', 'pro123', 0, 4),
('admin', 'admin123', 0, 1);

-- 6. Cliente vinculado al usuario 1
INSERT INTO Cliente (Nombre, Apellido, DNI, FechaNac, Telefono, Email, UsuarioId) VALUES
('Carlos', 'González', '30123456', '1990-05-15', '1122334455', 'carlos@email.com', 1);

-- 7. Profesionales vinculados a su usuario y a una sucursal
INSERT INTO Profesional (Nombre, Apellido, DNI, Telefono, Email, SucursalId, UsuarioId) VALUES
('Juan', 'Pérez', '25111222', '1133445566', 'juan@email.com', 1, 2),
('María', 'Gómez', '27333444', '1133445577', 'maria@email.com', 2, 3);

-- 8. Servicios que realiza cada profesional
INSERT INTO ProfesionalServicio (ProfesionalId, EspecialidadId) VALUES
(1, 1),
(2, 2),
(2, 3);

-- 9. Turno de ejemplo
INSERT INTO Turno (ClienteId, FechaTurno, Precio, Observaciones, ProfesionalId, Baja, SucursalId, TurnoEstadoId) VALUES
(
    1,
    '2026-11-15 10:30:00',
    15000.00,
    'Turno de ejemplo',
    1,
    0,
    1,
    1
);

-- 10. Servicio incluido en ese turno
INSERT INTO TurnoServicio (TurnoId, EspecialidadId, PrecioUnitario) VALUES
(1, 1, 15000.00);
