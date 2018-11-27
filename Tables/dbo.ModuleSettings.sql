CREATE TABLE [dbo].[ModuleSettings]
(
[ModuleID] [int] NOT NULL,
[SettingName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedByUserID] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserID] [int] NULL,
[LastModifiedOnDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ModuleSettings] ADD CONSTRAINT [PK_ModuleSettings] PRIMARY KEY CLUSTERED  ([ModuleID], [SettingName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ModuleSettings] ADD CONSTRAINT [FK_ModuleSettings_Modules] FOREIGN KEY ([ModuleID]) REFERENCES [dbo].[Modules] ([ModuleID]) ON DELETE CASCADE
GO
