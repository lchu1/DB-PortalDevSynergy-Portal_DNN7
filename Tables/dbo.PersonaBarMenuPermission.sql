CREATE TABLE [dbo].[PersonaBarMenuPermission]
(
[MenuPermissionId] [int] NOT NULL IDENTITY(1, 1),
[PortalId] [int] NULL,
[MenuId] [int] NOT NULL,
[PermissionId] [int] NOT NULL,
[AllowAccess] [bit] NOT NULL,
[RoleId] [int] NULL,
[UserId] [int] NULL,
[CreatedByUserId] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserId] [int] NULL,
[LastModifiedOnDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarMenuPermission] ADD CONSTRAINT [PK_PersonaBarMenuPermission] PRIMARY KEY CLUSTERED  ([MenuPermissionId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarMenuPermission] ADD CONSTRAINT [IX_PersonaBarMenuPermission] UNIQUE NONCLUSTERED  ([PortalId], [MenuId], [PermissionId], [UserId], [RoleId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarMenuPermission] ADD CONSTRAINT [FK_PersonaBarMenuPermission_MenuId] FOREIGN KEY ([MenuId]) REFERENCES [dbo].[PersonaBarMenu] ([MenuId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonaBarMenuPermission] ADD CONSTRAINT [FK_PersonaBarMenuPermission_Permission] FOREIGN KEY ([PermissionId]) REFERENCES [dbo].[PersonaBarPermission] ([PermissionId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonaBarMenuPermission] ADD CONSTRAINT [FK_PersonaBarMenuPermission_Portals] FOREIGN KEY ([PortalId]) REFERENCES [dbo].[Portals] ([PortalID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonaBarMenuPermission] ADD CONSTRAINT [FK_PersonaBarMenuPermission_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[PersonaBarMenuPermission] ADD CONSTRAINT [FK_PersonaBarMenuPermission_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE
GO
