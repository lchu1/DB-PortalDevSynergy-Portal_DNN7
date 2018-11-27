CREATE TABLE [dbo].[DMX_Log]
(
[Action] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Datime] [datetime] NOT NULL,
[EntryId] [int] NOT NULL,
[LogId] [int] NOT NULL IDENTITY(1, 1),
[UserId] [int] NOT NULL,
[PortalId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Log] ADD CONSTRAINT [PK_DMX_Log] PRIMARY KEY CLUSTERED  ([LogId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Log] WITH NOCHECK ADD CONSTRAINT [FK_DMX_Log_Entries] FOREIGN KEY ([EntryId]) REFERENCES [dbo].[DMX_Entries] ([EntryId]) ON DELETE CASCADE
GO
