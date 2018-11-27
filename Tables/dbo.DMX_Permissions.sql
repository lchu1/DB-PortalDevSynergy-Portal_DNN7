CREATE TABLE [dbo].[DMX_Permissions]
(
[Addon] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PermissionId] [int] NOT NULL IDENTITY(1, 1),
[PermissionKey] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PortalId] [int] NULL,
[ResourceFile] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Permissions] ADD CONSTRAINT [PK_DMX_Permissions] PRIMARY KEY CLUSTERED  ([PermissionId]) ON [PRIMARY]
GO
