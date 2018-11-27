CREATE TABLE [dbo].[DMX_Extensions]
(
[AccessRights] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Addon] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ControlToLoad] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DownloadUrl] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EntryTypes] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExtensionKey] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Icon16] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Icon32] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPrivate] [bit] NULL,
[MimeType] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NodePattern] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PortalId] [int] NOT NULL,
[ResourceFile] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SettingsControl] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ViewByDefault] [bit] NULL,
[EditControl] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ViewControl] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Extensions] ADD CONSTRAINT [PK_DMX_Extensions] PRIMARY KEY CLUSTERED  ([ExtensionKey], [PortalId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Extensions] WITH NOCHECK ADD CONSTRAINT [FK_DMX_Extensions_Addons] FOREIGN KEY ([Addon]) REFERENCES [dbo].[DMX_Addons] ([AddonKey]) ON DELETE CASCADE
GO
