CREATE TABLE [dbo].[SystemMessages]
(
[MessageID] [int] NOT NULL IDENTITY(1, 1),
[PortalID] [int] NULL,
[MessageName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MessageValue] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SystemMessages] ADD CONSTRAINT [PK_SystemMessages] PRIMARY KEY CLUSTERED  ([MessageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SystemMessages] ADD CONSTRAINT [IX_SystemMessages] UNIQUE NONCLUSTERED  ([MessageName], [PortalID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SystemMessages] ADD CONSTRAINT [FK_SystemMessages_Portals] FOREIGN KEY ([PortalID]) REFERENCES [dbo].[Portals] ([PortalID]) ON DELETE CASCADE
GO
