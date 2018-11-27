CREATE TABLE [dbo].[DMX_DirectAccessKeys]
(
[PortalId] [int] NOT NULL,
[Downloads] [int] NULL,
[Email] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EntryId] [int] NULL,
[Expires] [datetime] NULL,
[Key] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_DirectAccessKeys] ADD CONSTRAINT [PK_DMX_DirectAccessKeys] PRIMARY KEY CLUSTERED  ([PortalId], [Key]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_DirectAccessKeys] WITH NOCHECK ADD CONSTRAINT [FK_DMX_DirectAccessKeys_Entries] FOREIGN KEY ([EntryId]) REFERENCES [dbo].[DMX_Entries] ([EntryId]) ON DELETE CASCADE
GO
