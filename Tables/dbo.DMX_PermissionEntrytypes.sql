CREATE TABLE [dbo].[DMX_PermissionEntrytypes]
(
[EntryType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PermissionId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_PermissionEntrytypes] ADD CONSTRAINT [PK_DMX_PermissionEntrytypes] PRIMARY KEY CLUSTERED  ([EntryType], [PermissionId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_PermissionEntrytypes] WITH NOCHECK ADD CONSTRAINT [FK_DMX_PermissionEntrytypes_Permissions] FOREIGN KEY ([PermissionId]) REFERENCES [dbo].[DMX_Permissions] ([PermissionId]) ON DELETE CASCADE
GO
