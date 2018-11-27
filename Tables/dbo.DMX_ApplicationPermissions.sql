CREATE TABLE [dbo].[DMX_ApplicationPermissions]
(
[PortalId] [int] NOT NULL,
[AllowAccess] [bit] NULL,
[Expires] [datetime] NULL,
[PermissionId] [int] NOT NULL,
[RoleId] [int] NOT NULL,
[UserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_ApplicationPermissions] ADD CONSTRAINT [PK_DMX_ApplicationPermissions] PRIMARY KEY CLUSTERED  ([PortalId], [PermissionId], [RoleId], [UserId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_ApplicationPermissions] WITH NOCHECK ADD CONSTRAINT [FK_DMX_ApplicationPermissions_Portals] FOREIGN KEY ([PortalId]) REFERENCES [dbo].[Portals] ([PortalID]) ON DELETE CASCADE
GO
