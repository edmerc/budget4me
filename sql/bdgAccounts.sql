USE [budget4me]
GO

/****** Object:  Table [dbo].[bdgAccounts]    Script Date: 11/7/2019 9:32:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bdgAccounts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[account_name] [varchar](50) NULL,
	[account_num] [varchar](50) NULL,
	[account_amount] [float] NULL,
	[account_alias] [varchar](50) NULL,
	[account_date_added] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[bdgAccounts] ADD  CONSTRAINT [DF_bdgAccounts_date_added]  DEFAULT (getdate()) FOR [account_date_added]
GO

