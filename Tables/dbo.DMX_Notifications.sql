CREATE TABLE [dbo].[DMX_Notifications]
(
[LogId] [int] NOT NULL,
[PortalId] [int] NOT NULL,
[Sent] [datetime] NULL,
[Template] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Notifications] ADD CONSTRAINT [PK_DMX_Notifications] PRIMARY KEY CLUSTERED  ([LogId], [UserId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Notifications] WITH NOCHECK ADD CONSTRAINT [FK_DMX_Notifications_Log] FOREIGN KEY ([LogId]) REFERENCES [dbo].[DMX_Log] ([LogId]) ON DELETE CASCADE
GO
