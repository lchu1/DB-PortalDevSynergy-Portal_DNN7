CREATE TABLE [dbo].[TabModuleSettings]
(
[TabModuleID] [int] NOT NULL,
[SettingName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedByUserID] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserID] [int] NULL,
[LastModifiedOnDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TabModuleSettings] ADD CONSTRAINT [PK_TabModuleSettings] PRIMARY KEY CLUSTERED  ([TabModuleID], [SettingName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TabModuleSettings] ADD CONSTRAINT [FK_TabModuleSettings_TabModules] FOREIGN KEY ([TabModuleID]) REFERENCES [dbo].[TabModules] ([TabModuleID]) ON DELETE CASCADE
GO
