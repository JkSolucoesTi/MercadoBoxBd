USE [MercadoBox]
GO

/****** Object:  Table [dbo].[ItemCarrinho]    Script Date: 07/10/2025 07:15:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ItemCarrinho](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompraId] [int] NOT NULL,
	[ProdutoId] [int] NOT NULL,
	[Quantidade] [decimal](18, 2) NOT NULL,
	[ValorUnitario] [decimal](18, 2) NOT NULL,
	[Promocao] [bit] NULL,
	[ValorPromocional] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ItemCarrinho]  WITH CHECK ADD FOREIGN KEY([CompraId])
REFERENCES [dbo].[Compra] ([Id])
GO


