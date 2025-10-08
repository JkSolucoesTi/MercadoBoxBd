-- ===============================
-- Banco de Dados: MercadoBox_teste
-- ===============================
IF DB_ID('MercadoBox') IS NULL
BEGIN
    CREATE DATABASE MercadoBox;
END
GO

USE MercadoBox_teste;
GO

-- ===============================
-- Tabela: Categorias
-- ===============================
IF OBJECT_ID('dbo.Categorias', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Categorias (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Nome NVARCHAR(100) NOT NULL
    );
END
GO

-- ===============================
-- Tabela: Produtos
-- ===============================
IF OBJECT_ID('dbo.Produtos', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Produtos (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Codigo NVARCHAR(50) NOT NULL,
        Nome NVARCHAR(200) NOT NULL,
        CategoriaId INT NOT NULL,
        Descricao NVARCHAR(500) NULL
    );
END
GO

-- ===============================
-- Tabela: Mercado
-- ===============================
IF OBJECT_ID('dbo.Mercado', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Mercado (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Nome NVARCHAR(150) NOT NULL,
        Endereco NVARCHAR(255) NULL,
        Cidade NVARCHAR(100) NULL,
        Estado NVARCHAR(50) NULL,
        Cnpj NVARCHAR(20) NULL,
        Telefone NVARCHAR(20) NULL
    );
END
GO

-- ===============================
-- Tabela: Compra
-- ===============================
IF OBJECT_ID('dbo.Compra', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Compra (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        MercadoId INT NOT NULL,
        Data DATETIME NOT NULL DEFAULT GETDATE(),
        Status INT NOT NULL,
        Guid UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID()
    );
END
GO

-- ===============================
-- Tabela: ItemCarrinho
-- ===============================
IF OBJECT_ID('dbo.ItemCarrinho', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ItemCarrinho (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        CompraId INT NOT NULL,
        ProdutoId INT NOT NULL,
        Quantidade DECIMAL(18,2) NOT NULL,
        ValorUnitario DECIMAL(18,2) NOT NULL,
        Promocao BIT NULL,
        ValorPromocional DECIMAL(18,2) NOT NULL
    );
END
GO

-- ===============================
-- Rela��es (Foreign Keys)
-- ===============================
IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_ItemCarrinho_Compra'
)
BEGIN
    ALTER TABLE dbo.ItemCarrinho
    ADD CONSTRAINT FK_ItemCarrinho_Compra FOREIGN KEY (CompraId)
    REFERENCES dbo.Compra(Id);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Produto_Categoria'
)
BEGIN
    ALTER TABLE dbo.Produtos
    ADD CONSTRAINT FK_Produto_Categoria FOREIGN KEY (CategoriaId)
    REFERENCES dbo.Categorias(Id);
END
GO

-- ======================================
-- PROCEDURES
-- ======================================

IF OBJECT_ID('dbo.MB_AddProduto', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_AddProduto;
GO

CREATE  PROCEDURE [dbo].[MB_AddProduto]
    @Codigo NVARCHAR(50),
    @Nome NVARCHAR(200),
    @CategoriaId INT,
    @Descricao NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Produtos (Codigo, Nome, CategoriaId, Descricao)
    VALUES (@Codigo, @Nome, @CategoriaId, @Descricao);

    SELECT SCOPE_IDENTITY() AS NewId;
END
GO

IF OBJECT_ID('dbo.MB_AtualizarStatusCompraPorGuid', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_AtualizarStatusCompraPorGuid;
GO

CREATE   PROCEDURE [dbo].[MB_AtualizarStatusCompraPorGuid]
    @Guid UNIQUEIDENTIFIER,
    @Status INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Compra
    SET Status = @Status
    WHERE Guid = @Guid;
END
GO

IF OBJECT_ID('dbo.MB_CategoriaGetById', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_CategoriaGetById;
GO

CREATE PROCEDURE [dbo].[MB_CategoriaGetById]
    @Id INT
AS
BEGIN
    SELECT Id, Nome
    FROM Categoria
    WHERE Id = @Id;
END
GO

IF OBJECT_ID('dbo.MB_CriarCompra', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_CriarCompra;
GO

CREATE PROCEDURE [dbo].[MB_CriarCompra]
    @MercadoId INT,
    @Data DATETIME,
    @Status INT,
	@Guid UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Compra (MercadoId, Data, Status,Guid)
    VALUES (@MercadoId, @Data, @Status,@Guid);

END
GO

IF OBJECT_ID('dbo.MB_DeleteProduto', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_DeleteProduto;
GO

CREATE   PROCEDURE [dbo].[MB_DeleteProduto]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Produtos
    WHERE Id = @Id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO

IF OBJECT_ID('dbo.MB_GetAllCategorias', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_GetAllCategorias;
GO

CREATE   PROCEDURE [dbo].[MB_GetAllCategorias]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id, Nome
    FROM Categorias
    ORDER BY Nome;
END
GO

IF OBJECT_ID('dbo.MB_GetAllProdutos', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_GetAllProdutos;
GO

CREATE   PROCEDURE [dbo].[MB_GetAllProdutos]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id, Codigo, Nome, Descricao , CategoriaId
    FROM Produtos  
    ORDER BY Nome;
END
GO

IF OBJECT_ID('dbo.MB_GetCompraPorGuid', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_GetCompraPorGuid;
GO

CREATE   PROCEDURE [dbo].[MB_GetCompraPorGuid]
    @Guid UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    -- Retorna dados da compra
    SELECT 
        c.Id,
        c.MercadoId,
        c.Data,
        c.Status,
        c.Guid
    FROM Compra c inner join Mercado m
	on c.MercadoId = m.Id
    WHERE c.Guid = @Guid;

    -- Retorna os itens da compra
    SELECT 
        ic.Id,
        P.Nome,
        ic.CompraId,
        ic.ProdutoId,
        ic.Quantidade,
        ic.ValorUnitario,
        ic.Promocao,
        ic.ValorPromocional
    FROM ItemCarrinho ic
    INNER JOIN Compra c ON ic.CompraId = c.Id
    INNER JOIN Produtos P ON P.id =  ic.ProdutoId
    WHERE c.Guid = @Guid;
END
GO

IF OBJECT_ID('dbo.MB_GetCompraS', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_GetCompraS;
GO

CREATE PROCEDURE [dbo].[MB_GetCompraS]   
AS
BEGIN
    SET NOCOUNT ON;
SELECT 
    c.Id            AS Id,
    c.Guid          AS Guid,
    c.MercadoId,
    c.Data          AS Data,
    c.Status,
    ic.Id           AS ItemId,
    ic.ProdutoId,
    p.Nome          AS NomeProduto,
    ic.Quantidade,
    ic.ValorUnitario,
    ic.Promocao,
    ic.ValorPromocional
FROM Compra c
LEFT JOIN ItemCarrinho ic ON ic.CompraId = c.Id
LEFT JOIN Produtos p ON p.Id = ic.ProdutoId
WHERE c.Status = 3;

END
GO

IF OBJECT_ID('dbo.MB_GetProdutosPorCodigo', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_GetProdutosPorCodigo;
GO

CREATE PROCEDURE [dbo].[MB_GetProdutosPorCodigo]
    @Codigo NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 20
        Id,
        Codigo,
        Nome,
        CategoriaId,
        Descricao
    FROM Produtos
    WHERE Codigo LIKE '%' + @Codigo + '%'      
    ORDER BY Nome;
END
GO

IF OBJECT_ID('dbo.MB_IncluirItemCarrinho', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_IncluirItemCarrinho;
GO

CREATE PROCEDURE [dbo].[MB_IncluirItemCarrinho]
    @CompraId INT,
    @ProdutoId INT,
    @Quantidade DECIMAL(18,2),
	@Promocao bit,
    @ValorUnitario DECIMAL(18,2),
	@ValorPromocao DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO ItemCarrinho (CompraId, ProdutoId, Quantidade, ValorUnitario, Promocao , ValorPromocional)
    VALUES     (@CompraId, @ProdutoId, @Quantidade, @ValorUnitario, @Promocao,@ValorPromocao);
END
GO

IF OBJECT_ID('dbo.MB_MercadoDelete', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_MercadoDelete;
GO


CREATE   PROCEDURE [dbo].[MB_MercadoDelete]
    @Id INT
AS
BEGIN
    DELETE FROM Mercado WHERE Id = @Id;
END
GO

IF OBJECT_ID('dbo.MB_MercadoGetAll', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_MercadoGetAll;
GO

CREATE  PROCEDURE [dbo].[MB_MercadoGetAll]
AS
BEGIN
    SELECT Id, Nome, Endereco, Cidade, Estado, Cnpj, Telefone
    FROM Mercado;
END
GO

IF OBJECT_ID('dbo.MB_MercadoGetById', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_MercadoGetById;
GO

CREATE   PROCEDURE [dbo].[MB_MercadoGetById]
    @Id INT
AS
BEGIN
    SELECT Id, Nome, Endereco, Cidade, Estado, Cnpj, Telefone
    FROM Mercado
    WHERE Id = @Id;
END
GO

IF OBJECT_ID('dbo.MB_MercadoInsert', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_MercadoInsert;
GO

CREATE   PROCEDURE [dbo].[MB_MercadoInsert]
    @Nome NVARCHAR(150),
    @Endereco NVARCHAR(255) = NULL,
    @Cidade NVARCHAR(100) = NULL,
    @Estado NVARCHAR(50) = NULL,
    @Cnpj NVARCHAR(20) = NULL,
    @Telefone NVARCHAR(20) = NULL
AS
BEGIN
    INSERT INTO Mercado (Nome, Endereco, Cidade, Estado, Cnpj, Telefone)
    VALUES (@Nome, @Endereco, @Cidade, @Estado, @Cnpj, @Telefone);

    SELECT SCOPE_IDENTITY() AS Id; -- retorna o ID inserido
END
GO

IF OBJECT_ID('dbo.MB_MercadoUpdate', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_MercadoUpdate;
GO

CREATE   PROCEDURE [dbo].[MB_MercadoUpdate]
    @Id INT,
    @Nome NVARCHAR(150),
    @Endereco NVARCHAR(255) = NULL,
    @Cidade NVARCHAR(100) = NULL,
    @Estado NVARCHAR(50) = NULL,
    @Cnpj NVARCHAR(20) = NULL,
    @Telefone NVARCHAR(20) = NULL
AS
BEGIN
    UPDATE Mercado
    SET Nome = @Nome,
        Endereco = @Endereco,
        Cidade = @Cidade,
        Estado = @Estado,
        Cnpj = @Cnpj,
        Telefone = @Telefone
    WHERE Id = @Id;
END
GO

IF OBJECT_ID('dbo.MB_ProdutoGetByCodigo', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_ProdutoGetByCodigo;
GO


CREATE   PROCEDURE [dbo].[MB_ProdutoGetByCodigo]
    @Codigo varchar(13)
AS
BEGIN
    SELECT Id,Codigo,Nome,CategoriaId,Descricao
    FROM Produtos
    WHERE Codigo = @Codigo
END
GO

IF OBJECT_ID('dbo.MB_UpdateProduto', 'P') IS NOT NULL
    DROP PROCEDURE dbo.MB_UpdateProduto;
GO

CREATE   PROCEDURE [dbo].[MB_UpdateProduto]
    @Id INT,
    @Codigo NVARCHAR(50),
    @Nome NVARCHAR(200),
    @CategoriaId INT,
    @Descricao NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Produtos
    SET Codigo = @Codigo,
        Nome = @Nome,
        CategoriaId = @CategoriaId,
        Descricao = @Descricao
    WHERE Id = @Id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
