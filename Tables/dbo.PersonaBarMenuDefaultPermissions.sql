CREATE TABLE [dbo].[PersonaBarMenuDefaultPermissions]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[MenuId] [int] NOT NULL,
[RoleNames] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarMenuDefaultPermissions] ADD CONSTRAINT [PK_PersonaBarMenuDefaultPermissions] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarMenuDefaultPermissions] ADD CONSTRAINT [IX_PersonaBarMenuDefaultPermissions] UNIQUE NONCLUSTERED  ([MenuId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarMenuDefaultPermissions] ADD CONSTRAINT [FK_PersonaBarMenuDefaultPermissions_MenuId] FOREIGN KEY ([MenuId]) REFERENCES [dbo].[PersonaBarMenu] ([MenuId]) ON DELETE CASCADE
GO
