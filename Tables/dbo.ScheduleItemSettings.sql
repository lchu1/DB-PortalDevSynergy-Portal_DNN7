CREATE TABLE [dbo].[ScheduleItemSettings]
(
[ScheduleID] [int] NOT NULL,
[SettingName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ScheduleItemSettings] ADD CONSTRAINT [PK_ScheduleItemSettings] PRIMARY KEY CLUSTERED  ([ScheduleID], [SettingName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ScheduleItemSettings] WITH NOCHECK ADD CONSTRAINT [FK_ScheduleItemSettings_Schedule] FOREIGN KEY ([ScheduleID]) REFERENCES [dbo].[Schedule] ([ScheduleID]) ON DELETE CASCADE
GO
