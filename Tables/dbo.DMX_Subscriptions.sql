CREATE TABLE [dbo].[DMX_Subscriptions]
(
[EntryId] [int] NOT NULL,
[LastAccess] [datetime] NULL,
[UserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Subscriptions] ADD CONSTRAINT [PK_DMX_Subscriptions] PRIMARY KEY CLUSTERED  ([EntryId], [UserId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Subscriptions] WITH NOCHECK ADD CONSTRAINT [FK_DMX_Subscriptions_Entries] FOREIGN KEY ([EntryId]) REFERENCES [dbo].[DMX_Entries] ([EntryId]) ON DELETE CASCADE
GO
