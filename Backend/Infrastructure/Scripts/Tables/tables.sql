IF OBJECT_ID('dbo.TblDetallesFactura','U') IS NOT NULL DROP TABLE dbo.TblDetallesFactura;
IF OBJECT_ID('dbo.TblFacturas','U') IS NOT NULL DROP TABLE dbo.TblFacturas;
IF OBJECT_ID('dbo.TblClientes','U') IS NOT NULL DROP TABLE dbo.TblClientes;
IF OBJECT_ID('dbo.CatProductos','U') IS NOT NULL DROP TABLE dbo.CatProductos;
IF OBJECT_ID('dbo.CatTipoCliente','U') IS NOT NULL DROP TABLE dbo.CatTipoCliente;

CREATE TABLE dbo.CatTipoCliente (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TipoCliente VARCHAR(50) NOT NULL
);

CREATE TABLE dbo.CatProductos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto VARCHAR(50) NOT NULL,
    ImagenProducto IMAGE NULL,
    PrecioUnitario DECIMAL(12,2) NOT NULL,
    ext VARCHAR(5) NULL
);

CREATE TABLE dbo.TblClientes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RazonSocial VARCHAR(200) NOT NULL,
    IdTipoCliente INT NOT NULL FOREIGN KEY REFERENCES dbo.CatTipoCliente(Id),
    FechaCreacion DATE NOT NULL,
    RFC VARCHAR(50) NOT NULL
);

CREATE TABLE dbo.TblFacturas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FechaEmisionFactura DATETIME NOT NULL,
    IdCliente INT NOT NULL FOREIGN KEY REFERENCES dbo.TblClientes(Id),
    NumeroFactura INT NOT NULL UNIQUE,
    NumeroTotalArticulos INT NOT NULL,
    SubTotalFactura DECIMAL(12,2) NOT NULL,
    TotalImpuesto DECIMAL(12,2) NOT NULL,
    TotalFactura DECIMAL(12,2) NOT NULL
);

CREATE TABLE dbo.TblDetallesFactura (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdFactura INT NOT NULL FOREIGN KEY REFERENCES dbo.TblFacturas(Id),
    IdProducto INT NOT NULL FOREIGN KEY REFERENCES dbo.CatProductos(Id),
    CantidadDelProducto INT NOT NULL,
    PrecioUnitarioProducto DECIMAL(12,2) NOT NULL,
    SubtotalProducto DECIMAL(12,2) NOT NULL,
    Notas VARCHAR(200) NULL
);

INSERT INTO dbo.CatTipoCliente (TipoCliente)
VALUES
    ('Minorista'),
    ('Mayorista');

INSERT INTO dbo.CatProductos (NombreProducto, ImagenProducto, PrecioUnitario, ext)
VALUES
    ('Laptop Lenovo', NULL, 2500.00, NULL),
    ('Monitor Samsung', NULL, 850.00, NULL);

INSERT INTO dbo.TblClientes (RazonSocial, IdTipoCliente, FechaCreacion, RFC)
VALUES
    ('Tecnologia Empresarial SAS', 1, '2026-01-15', 'TES123456A1'),
    ('Distribuciones del Norte SAS', 2, '2026-02-10', 'DNO987654B2');

INSERT INTO dbo.TblFacturas (FechaEmisionFactura, IdCliente, NumeroFactura, NumeroTotalArticulos, SubTotalFactura, TotalImpuesto, TotalFactura)
VALUES
    ('2026-03-01T10:00:00', 1, 1001, 3, 3350.00, 636.50, 3986.50),
    ('2026-03-05T15:30:00', 2, 1002, 4, 4200.00, 798.00, 4998.00);

INSERT INTO dbo.TblDetallesFactura (IdFactura, IdProducto, CantidadDelProducto, PrecioUnitarioProducto, SubtotalProducto, Notas)
VALUES
    (1, 1, 1, 2500.00, 2500.00, 'Equipo principal'),
    (1, 2, 1, 850.00, 850.00, 'Monitor adicional'),
    (2, 1, 1, 2500.00, 2500.00, 'Portatil para gerencia'),
    (2, 2, 2, 850.00, 1700.00, 'Monitores para oficina');
