CREATE TABLE [dbo].[DMX_PermissionPermissions]
(
[PermissionId] [int] NOT NULL,
[RoleId] [int] NOT NULL,
[PortalId] [int] NOT NULL,
[AllowAccess] [bit] NULL,
[Expires] [datetime] NULL,
[UserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_PermissionPermissions] ADD CONSTRAINT [PK_DMX_PermissionPermissions] PRIMARY KEY CLUSTERED  ([PortalId], [PermissionId], [RoleId], [UserId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DMX_PermissionPermissions_RoleId] ON [dbo].[DMX_PermissionPermissions] ([RoleId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_PermissionPermissions] WITH NOCHECK ADD CONSTRAINT [FK_DMX_PermissionPermissions_Permissions] FOREIGN KEY ([PermissionId]) REFERENCES [dbo].[DMX_Permissions] ([PermissionId]) ON DELETE CASCADE
GO
