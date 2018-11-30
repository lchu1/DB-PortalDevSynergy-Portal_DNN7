CREATE TABLE [dbo].[Events]
(
[EventID] [int] NOT NULL IDENTITY(1, 1),
[ModuleID] [int] NOT NULL,
[EventDateBegin] [datetime] NULL,
[EventDateEnd] [datetime] NULL,
[EventTimeBegin] [datetime] NOT NULL,
[Duration] [int] NOT NULL,
[EventName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EventDesc] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Importance] [int] NOT NULL,
[RepeatType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Every] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Period] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Reminder] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notify] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedByID] [int] NOT NULL,
[Approved] [bit] NOT NULL,
[PortalID] [int] NOT NULL,
[Signups] [bit] NOT NULL,
[MaxEnrollment] [int] NOT NULL,
[EnrollRoleID] [int] NULL,
[EnrollFee] [money] NOT NULL,
[EnrollType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PayPalAccount] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Cancelled] [bit] NOT NULL,
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
[SearchSubmitted] [bit] NOT NULL,
[CustomField1] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomField2] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastUpdatedAt] [datetime] NOT NULL,
[OriginalDateBegin] [datetime] NOT NULL,
[LastUpdatedID] [int] NOT NULL,
[OwnerID] [int] NOT NULL,
[EnrollListView] [bit] NOT NULL,
[NewEventEmailSent] [bit] NOT NULL,
[DisplayEndDate] [bit] NOT NULL,
[AllDayEvent] [bit] NOT NULL,
[RecurMasterID] [int] NOT NULL,
[DetailPage] [bit] NOT NULL,
[DetailURL] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DetailNewWin] [bit] NOT NULL,
[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Events__CreatedD__57BDDBAA] DEFAULT (getutcdate()),
[AllowAnonEnroll] [bit] NOT NULL,
[ContentItemId] [int] NULL,
[JournalItem] [bit] NOT NULL,
[Summary] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Sequence] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Events] ADD CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED  ([EventID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Events_6] ON [dbo].[Events] ([Category]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Events_1] ON [dbo].[Events] ([EventDateBegin]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Events_3] ON [dbo].[Events] ([EventDateEnd]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Events_5] ON [dbo].[Events] ([EventTimeBegin]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Events_7] ON [dbo].[Events] ([Location]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Events_2] ON [dbo].[Events] ([ModuleID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Events_4] ON [dbo].[Events] ([ModuleID], [RecurMasterID], [EventID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Events_8] ON [dbo].[Events] ([RecurMasterID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Events] WITH NOCHECK ADD CONSTRAINT [FK_Events_EventsCategory] FOREIGN KEY ([Category]) REFERENCES [dbo].[EventsCategory] ([Category])
GO
ALTER TABLE [dbo].[Events] WITH NOCHECK ADD CONSTRAINT [FK_Events_EventsLocation] FOREIGN KEY ([Location]) REFERENCES [dbo].[EventsLocation] ([Location])
GO
ALTER TABLE [dbo].[Events] WITH NOCHECK ADD CONSTRAINT [FK_Events_EventsRecurMaster] FOREIGN KEY ([RecurMasterID]) REFERENCES [dbo].[EventsRecurMaster] ([RecurMasterID]) ON DELETE CASCADE
GO
