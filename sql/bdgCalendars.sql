USE [budget4me]
GO

/****** Object:  Table [dbo].[bdgCalendars]    Script Date: 11/7/2019 9:34:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bdgCalendars](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[bill_id] [int] NULL,
	[cal_event_date] [varchar](5) NULL,
	[cal_date_created] [date] NULL,
	[cal_event_name] [varchar](50) NULL,
	[cal_payment_amount] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[bdgCalendars] ADD  CONSTRAINT [DF_bdgCalendars_cal_date_created]  DEFAULT (getdate()) FOR [cal_date_created]
GO

