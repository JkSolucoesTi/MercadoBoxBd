USE [MercadoBox]
GO

/****** Object:  Table [dbo].[Compra]    Script Date: 07/10/2025 07:14:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Compra](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MercadoId] [int] NOT NULL,
	[Data] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[Guid] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Compra] ADD  CONSTRAINT [DF_Compra_Guid]  DEFAULT (newid()) FOR [Guid]
GO


