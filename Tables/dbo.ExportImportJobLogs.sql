CREATE TABLE [dbo].[ExportImportJobLogs]
(
[JobLogId] [int] NOT NULL IDENTITY(1, 1),
[JobId] [int] NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Value] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Level] [int] NOT NULL CONSTRAINT [DF__ExportImp__Level__1447C6FD] DEFAULT ((0)),
[CreatedOnDate] [datetime] NOT NULL CONSTRAINT [DF__ExportImp__Creat__153BEB36] DEFAULT (getutcdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExportImportJobLogs] ADD CONSTRAINT [PK_ExportImportJobLogs] PRIMARY KEY CLUSTERED  ([JobLogId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ExportImportJobLogs_JobId] ON [dbo].[ExportImportJobLogs] ([JobId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExportImportJobLogs] ADD CONSTRAINT [FK_ExportImportJobLogs_JobId] FOREIGN KEY ([JobId]) REFERENCES [dbo].[ExportImportJobs] ([JobId]) ON DELETE CASCADE
GO
