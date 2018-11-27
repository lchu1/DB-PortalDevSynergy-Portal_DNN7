CREATE TABLE [dbo].[CoreMessaging_SubscriptionTypes]
(
[SubscriptionTypeId] [int] NOT NULL IDENTITY(1, 1),
[SubscriptionName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FriendlyName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DesktopModuleId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CoreMessaging_SubscriptionTypes] ADD CONSTRAINT [PK_CoreMessaging_SubscriptionTypes] PRIMARY KEY CLUSTERED  ([SubscriptionTypeId]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CoreMessaging_SubscriptionTypes_SubscriptionName] ON [dbo].[CoreMessaging_SubscriptionTypes] ([SubscriptionName]) ON [PRIMARY]
GO
