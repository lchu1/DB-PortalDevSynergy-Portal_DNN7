CREATE TABLE [dbo].[PersonaBarPermission]
(
[PermissionId] [int] NOT NULL IDENTITY(1, 1),
[MenuId] [int] NULL,
[PermissionKey] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PermissionName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ViewOrder] [int] NOT NULL CONSTRAINT [DF__PersonaBa__ViewO__6B45B16A] DEFAULT ((9999)),
[CreatedByUserID] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserID] [int] NULL,
[LastModifiedOnDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarPermission] ADD CONSTRAINT [PK_PersonaBarPermission] PRIMARY KEY CLUSTERED  ([PermissionId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarPermission] ADD CONSTRAINT [IX_PersonaBarPermissionScope] UNIQUE NONCLUSTERED  ([MenuId], [PermissionKey]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarPermission] ADD CONSTRAINT [FK_PersonaBarPermission_MenuId] FOREIGN KEY ([MenuId]) REFERENCES [dbo].[PersonaBarMenu] ([MenuId])
GO
