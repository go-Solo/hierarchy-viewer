USE [TestLab]
GO

/****** Object:  Table [dbo].[ObjectData]    Script Date: 23-04-2022 20:17:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ObjectData](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ObjectName] [varchar](200) NULL,
	[ObjectType] [int] NULL,
	[ProjectName] [varchar](200) NULL,
	[SVNDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[InsertDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[AddedDynamically] [tinyint] NULL,
 CONSTRAINT [PK_ObjectDataNew] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ObjectData] ADD  DEFAULT (getdate()) FOR [InsertDate]
GO

ALTER TABLE [dbo].[ObjectData] ADD  DEFAULT (getdate()) FOR [UpdateDate]
GO


