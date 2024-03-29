USE [budget4me]
GO

/****** Object:  Table [dbo].[bdgTypes]    Script Date: 11/7/2019 9:34:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bdgTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[type_name] [varchar](50) NULL,
 CONSTRAINT [PK_bdgType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

