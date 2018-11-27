CREATE TABLE [dbo].[CKE_Settings]
(
[SettingName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingValue] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CKE_Settings] ADD CONSTRAINT [PK_CKE_Settings] PRIMARY KEY CLUSTERED  ([SettingName]) ON [PRIMARY]
GO
