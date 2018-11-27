CREATE TABLE [dbo].[ExtensionUrlProviderSetting]
(
[ExtensionUrlProviderID] [int] NOT NULL,
[PortalID] [int] NOT NULL,
[SettingName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingValue] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExtensionUrlProviderSetting] ADD CONSTRAINT [PK_ExtensionUrlProviderSetting] PRIMARY KEY CLUSTERED  ([ExtensionUrlProviderID], [PortalID], [SettingName]) ON [PRIMARY]
GO
