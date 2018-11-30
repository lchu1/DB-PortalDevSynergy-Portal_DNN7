CREATE TABLE [dbo].[EventsRecurMaster]
(
[RecurMasterID] [int] NOT NULL IDENTITY(1, 1),
[ModuleID] [int] NOT NULL,
[PortalID] [int] NOT NULL,
[RRULE] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DTSTART] [datetime] NOT NULL,
[Duration] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Until] [datetime] NOT NULL,
[EventName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EventDesc] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Importance] [int] NOT NULL,
[Reminder] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notify] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Approved] [bit] NOT NULL,
[Signups] [bit] NOT NULL,
[MaxEnrollment] [int] NOT NULL,
[EnrollRoleID] [int] NULL,
[EnrollFee] [money] NOT NULL,
[EnrollType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PayPalAccount] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ImageURL] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ImageType] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ImageWidth] [int] NULL,
[ImageHeight] [int] NULL,
[ImageDisplay] [bit] NOT NULL,
[Location] [int] NULL,
[Category] [int] NULL,
[SendReminder] [bit] NOT NULL,
[ReminderTime] [int] NOT NULL,
[ReminderTimeMeasurement] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ReminderFrom] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomField1] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomField2] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EnrollListView] [bit] NOT NULL,
[DisplayEndDate] [bit] NOT NULL,
[AllDayEvent] [bit] NOT NULL,
[OwnerID] [int] NOT NULL,
[CultureName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedByID] [int] NOT NULL,
[CreatedDate] [datetime] NOT NULL,
[UpdatedByID] [int] NOT NULL,
[UpdatedDate] [datetime] NOT NULL,
[DetailPage] [bit] NOT NULL,
[DetailURL] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DetailNewWin] [bit] NOT NULL,
[EventTimeZoneId] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AllowAnonEnroll] [bit] NOT NULL,
[ContentItemId] [int] NULL,
[SocialGroupId] [int] NULL,
[SocialUserId] [int] NULL,
[Summary] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Sequence] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsRecurMaster] ADD CONSTRAINT [PK_EventsRecurMaster] PRIMARY KEY CLUSTERED  ([RecurMasterID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsRecurMaster_1] ON [dbo].[EventsRecurMaster] ([Category]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsRecurMaster_2] ON [dbo].[EventsRecurMaster] ([Location]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsRecurMaster_3] ON [dbo].[EventsRecurMaster] ([ModuleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsRecurMaster] WITH NOCHECK ADD CONSTRAINT [FK_EventsRecurMaster_EventsCategory] FOREIGN KEY ([Category]) REFERENCES [dbo].[EventsCategory] ([Category])
GO
ALTER TABLE [dbo].[EventsRecurMaster] WITH NOCHECK ADD CONSTRAINT [FK_EventsRecurMaster_EventsLocation] FOREIGN KEY ([Location]) REFERENCES [dbo].[EventsLocation] ([Location])
GO
ALTER TABLE [dbo].[EventsRecurMaster] ADD CONSTRAINT [FK_EventsRecurMaster_Modules] FOREIGN KEY ([ModuleID]) REFERENCES [dbo].[Modules] ([ModuleID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventsRecurMaster] ADD CONSTRAINT [FK_EventsRecurMaster_Roles] FOREIGN KEY ([SocialGroupId]) REFERENCES [dbo].[Roles] ([RoleID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventsRecurMaster] ADD CONSTRAINT [FK_EventsRecurMaster_Users] FOREIGN KEY ([SocialUserId]) REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE
GO
