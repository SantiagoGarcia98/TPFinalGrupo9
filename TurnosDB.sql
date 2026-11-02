CREATE DATABASE TurnosDB
GO
USE TurnosDB;
GO

-- 1. Tablas de catálogos y entidades independientes
CREATE TABLE Especialidad (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL -- Precio base sugerido al dar de alta el turno
);

CREATE TABLE Profesional (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NombreApellido VARCHAR(150) NOT NULL -- Solo informativo, sin acceso a sistema por ahora
);
CREATE TABLE Recepcionista (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NombreApellido VARCHAR(150) NOT NULL -- Solo informativo, sin acceso a sistema por ahora
);

CREATE TABLE Sucursal (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200) NOT NULL
);

CREATE TABLE TurnoEstado (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL -- Ej: Pendiente, Confirmado, Cancelado, Atendido
);

CREATE TABLE TipoUsuario (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL -- Ej: Administrador, Cliente
);

-- 2. Tablas dependientes de nivel 1
CREATE TABLE Usuario (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Usuario VARCHAR(50) NOT NULL,
    Pass VARCHAR(255) NOT NULL, -- Soporte para hashes seguros (ej. BCrypt)
    Baja BIT NOT NULL DEFAULT 0,
    TipoUsuarioId INT NOT NULL,
    CONSTRAINT FK_Usuario_TipoUsuario FOREIGN KEY (TipoUsuarioId) REFERENCES TipoUsuario(Id)
);

CREATE TABLE Cliente (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    FechaNac DATE NULL,
    Telefono VARCHAR(30) NULL,
    Email VARCHAR(150) NULL,
    UsuarioId INT NULL, -- Permite iniciar sesión si el cliente se registra
    CONSTRAINT FK_Cliente_Usuario FOREIGN KEY (UsuarioId) REFERENCES Usuario(Id)
);

-- 3. Tabla transaccional principal (Turno)
CREATE TABLE Turno (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ClienteId INT NOT NULL,
    FechaTurno DATETIME NOT NULL,
    Precio DECIMAL(10,2) NOT NULL, -- Precio histórico congelado al momento de reservar
    EspecialidadId INT NOT NULL,
    ProfesionalId INT NOT NULL,
    Baja BIT NOT NULL DEFAULT 0,
    SucursalId INT NOT NULL,
    TurnoEstadoId INT NOT NULL,
    CONSTRAINT FK_Turno_Cliente FOREIGN KEY (ClienteId) REFERENCES Cliente(Id),
    CONSTRAINT FK_Turno_Especialidad FOREIGN KEY (EspecialidadId) REFERENCES Especialidad(Id),
    CONSTRAINT FK_Turno_Profesional FOREIGN KEY (ProfesionalId) REFERENCES Profesional(Id),
    CONSTRAINT FK_Turno_Sucursal FOREIGN KEY (SucursalId) REFERENCES Sucursal(Id),
    CONSTRAINT FK_Turno_TurnoEstado FOREIGN KEY (TurnoEstadoId) REFERENCES TurnoEstado(Id)
);

USE TurnosDB;
GO

-- 1. Tipos de Usuario
INSERT INTO TipoUsuario (Descripcion) VALUES 
('Administrador'), 
('Recepcionista'),
('Cliente');

-- 2. Estados del Turno
INSERT INTO TurnoEstado (Descripcion) VALUES 
('Pendiente'), 
('Confirmado'), 
('Cancelado'), 
('Atendido');

-- 3. Especialidades (con su precio base sugerido)
INSERT INTO Especialidad (Descripcion, Precio) VALUES 
('Manicura', 15000.00),
('Perfilado' , 30000.0),
('Lifting', 25000.00);

-- 4. Profesionales (solo informativo)
INSERT INTO Profesional (NombreApellido) VALUES 
('Dra. Juan Pérez'),
('Dra. María Gómez');
--5. Recepcionista (solo informativo)
INSERT INTO Recepcionista(NombreApellido) VALUES 
('Priscila Garcia'),
('Laura Fernandez');

-- 6. Sucursales
INSERT INTO Sucursal (Nombre, Direccion) VALUES 
('Casa Central', 'Tigre 2828'),
('Sucursal Norte', 'Ruta 8 Km 40');

-- 7. Usuarios (Ej: Un usuario con rol de Cliente, TipoUsuarioId = 2)
INSERT INTO Usuario (Usuario, Pass, Baja, TipoUsuarioId) VALUES 
('cgonzalez', 'usu123', 0, 3);

-- 8. Clientes (Vinculado al usuario creado recién con Id = 1)
INSERT INTO Cliente (Nombre, Apellido, FechaNac, Telefono, Email, UsuarioId) VALUES 
('Carlos', 'González', '1990-05-15', '1122334455', 'carlos@email.com', 1);

-- 9. Turnos (Un turno reservado de ejemplo)
INSERT INTO Turno (ClienteId, FechaTurno, Precio, EspecialidadId, ProfesionalId, Baja, SucursalId, TurnoEstadoId) VALUES 
(
    1,                        -- ClienteId (Carlos González)
    '2026-11-15 10:30:00',    -- FechaTurno
    15000.00,                 -- Precio congelado al reservar
    1,                        -- EspecialidadId (Consulta General)
    1,                        -- ProfesionalId (Dr. Juan Pérez)
    0,                        -- Baja (Activo)
    1,                        -- SucursalId (Casa Central)
    1                         -- TurnoEstadoId (Pendiente)
);


