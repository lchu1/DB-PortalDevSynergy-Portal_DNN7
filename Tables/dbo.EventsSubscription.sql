CREATE TABLE [dbo].[EventsSubscription]
(
[SubscriptionID] [int] NOT NULL IDENTITY(1, 1),
[ModuleID] [int] NOT NULL,
[PortalID] [int] NOT NULL,
[UserID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsSubscription] ADD CONSTRAINT [PK_EventsSubscription] PRIMARY KEY CLUSTERED  ([SubscriptionID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsSubscription_1] ON [dbo].[EventsSubscription] ([ModuleID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsSubscription_2] ON [dbo].[EventsSubscription] ([UserID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsSubscription] ADD CONSTRAINT [FK_EventsSubscription_Modules] FOREIGN KEY ([ModuleID]) REFERENCES [dbo].[Modules] ([ModuleID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventsSubscription] ADD CONSTRAINT [FK_EventsSubscription_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE
GO
