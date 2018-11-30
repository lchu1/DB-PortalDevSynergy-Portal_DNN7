CREATE TABLE [dbo].[EventsSignups]
(
[SignupID] [int] NOT NULL IDENTITY(1, 1),
[ModuleID] [int] NOT NULL,
[EventID] [int] NOT NULL,
[UserID] [int] NOT NULL,
[Approved] [bit] NOT NULL,
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
[NoEnrolees] [int] NOT NULL CONSTRAINT [DF__EventsSig__NoEnr__2902ECC1] DEFAULT ((1)),
[CreateDate] [datetime] NOT NULL CONSTRAINT [DF__EventsSig__Creat__59A6241C] DEFAULT (getutcdate()),
[AnonEmail] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnonName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnonTelephone] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnonCulture] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnonTimeZoneId] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Company] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[JobTitle] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReferenceNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Street] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PostalCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Region] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsSignups] ADD CONSTRAINT [PK_EventsSignups] PRIMARY KEY CLUSTERED  ([SignupID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsSignups_2] ON [dbo].[EventsSignups] ([EventID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsSignups] ADD CONSTRAINT [IX_EventsSignups] UNIQUE NONCLUSTERED  ([ModuleID], [EventID], [UserID], [AnonEmail]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsSignups_1] ON [dbo].[EventsSignups] ([PayPalTransID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsSignups] ADD CONSTRAINT [FK_EventsSignups_Events] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
