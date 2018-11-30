CREATE TABLE [dbo].[EventsNotification]
(
[NotificationID] [int] NOT NULL IDENTITY(1, 1),
[EventID] [int] NOT NULL,
[PortalAliasID] [int] NOT NULL,
[UserEmail] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NotificationSent] [bit] NOT NULL,
[NotifyByDateTime] [datetime] NOT NULL,
[EventTimeBegin] [datetime] NOT NULL,
[NotifyLanguage] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModuleID] [int] NOT NULL,
[TabID] [int] NOT NULL CONSTRAINT [DF__EventsNot__TabID__234A136B] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsNotification] ADD CONSTRAINT [PK_EventsNotification] PRIMARY KEY CLUSTERED  ([NotificationID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsNotification_3] ON [dbo].[EventsNotification] ([EventID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsNotification] ON [dbo].[EventsNotification] ([EventID], [NotifyByDateTime]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsNotification] ADD CONSTRAINT [IX_EventsNotification_2] UNIQUE NONCLUSTERED  ([EventID], [UserEmail], [EventTimeBegin]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsNotification_1] ON [dbo].[EventsNotification] ([NotifyByDateTime]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsNotification] WITH NOCHECK ADD CONSTRAINT [FK_EventsNotification_Events] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID]) ON DELETE CASCADE
GO
