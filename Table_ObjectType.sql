USE [TestLab]
GO

/****** Object:  Table [dbo].[ObjectType]    Script Date: 23-04-2022 20:18:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ObjectType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](10) NULL,
	[IsActive] [bit] NULL,
	[InsertDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ObjectType] ADD  DEFAULT (getdate()) FOR [InsertDate]
GO

ALTER TABLE [dbo].[ObjectType] ADD  DEFAULT (getdate()) FOR [UpdateDate]
GO


