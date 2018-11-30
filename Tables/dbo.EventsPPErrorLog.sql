CREATE TABLE [dbo].[EventsPPErrorLog]
(
[PayPalID] [int] NOT NULL IDENTITY(1, 1),
[SignupID] [int] NOT NULL,
[PayPalStatus] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalReason] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalTransID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalPayerID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalPayerStatus] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalRecieverEmail] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalUserEmail] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalPayerEmail] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalFirstName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalLastName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalAddress] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalCity] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalState] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalZip] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalCountry] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalCurrency] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayPalPaymentDate] [datetime] NULL,
[PayPalAmount] [money] NULL,
[PayPalFee] [money] NULL,
[CreateDate] [datetime] NOT NULL CONSTRAINT [DF__EventsPPE__Creat__58B1FFE3] DEFAULT (getutcdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsPPErrorLog] ADD CONSTRAINT [PK_EventsPPErrorLog] PRIMARY KEY CLUSTERED  ([PayPalID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsPPErrorLog] ON [dbo].[EventsPPErrorLog] ([CreateDate] DESC) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsPPErrorLog_2] ON [dbo].[EventsPPErrorLog] ([SignupID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsPPErrorLog] WITH NOCHECK ADD CONSTRAINT [FK_EventsPPErrorLog_EventsSignups] FOREIGN KEY ([SignupID]) REFERENCES [dbo].[EventsSignups] ([SignupID]) ON DELETE CASCADE
GO
