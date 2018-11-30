CREATE TABLE [dbo].[ExportImportSettings]
(
[SettingName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingIsSecure] [bit] NOT NULL CONSTRAINT [DF__ExportImp__Setti__022916C2] DEFAULT ((0)),
[CreatedByUserID] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserID] [int] NULL,
[LastModifiedOnDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExportImportSettings] ADD CONSTRAINT [PK_ExportImportSettings] PRIMARY KEY CLUSTERED  ([SettingName]) ON [PRIMARY]
GO
