CREATE TABLE [dbo].[DMX_Settings]
(
[PortalId] [int] NOT NULL,
[SettingName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingValue] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Settings] ADD CONSTRAINT [PK_DMX_Settings] PRIMARY KEY CLUSTERED  ([PortalId], [SettingName]) ON [PRIMARY]
GO
