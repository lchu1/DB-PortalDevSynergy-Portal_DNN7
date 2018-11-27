CREATE TABLE [dbo].[DMX_EntryPermissions]
(
[AllowAccess] [bit] NULL,
[EntryId] [int] NOT NULL,
[Expires] [datetime] NULL,
[PermissionId] [int] NOT NULL,
[PortalId] [int] NOT NULL,
[RoleId] [int] NOT NULL,
[UserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_EntryPermissions] ADD CONSTRAINT [PK_DMX_EntryPermissions] PRIMARY KEY CLUSTERED  ([EntryId], [PermissionId], [RoleId], [UserId]) ON [PRIMARY]
GO
