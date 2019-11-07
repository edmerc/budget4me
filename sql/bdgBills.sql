USE [budget4me]
GO

/****** Object:  Table [dbo].[bdgBills]    Script Date: 11/7/2019 9:34:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bdgBills](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NULL,
	[bill_name] [varchar](50) NULL,
	[bill_amount] [float] NULL,
	[type_id] [int] NULL,
	[date_added] [date] NULL,
	[bill_due_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

