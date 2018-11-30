CREATE TABLE [dbo].[ExportImportCheckpoints]
(
[CheckpointId] [int] NOT NULL IDENTITY(1, 1),
[JobId] [int] NOT NULL,
[AssemblyName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Category] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Stage] [int] NOT NULL,
[StageData] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Progress] [int] NOT NULL,
[TotalItems] [int] NOT NULL CONSTRAINT [DF__ExportImp__Total__0E8EEDA7] DEFAULT ((0)),
[ProcessedItems] [int] NOT NULL CONSTRAINT [DF__ExportImp__Proce__0F8311E0] DEFAULT ((0)),
[StartDate] [datetime] NULL,
[LastUpdateDate] [datetime] NULL,
[Completed] [bit] NULL CONSTRAINT [DF__ExportImp__Compl__10773619] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExportImportCheckpoints] ADD CONSTRAINT [PK_ExportImportCheckpoints] PRIMARY KEY CLUSTERED  ([CheckpointId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ExportImportCheckpoints_Category] ON [dbo].[ExportImportCheckpoints] ([Category]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ExportImportCheckpoints_Composite] ON [dbo].[ExportImportCheckpoints] ([Category], [AssemblyName], [JobId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ExportImportCheckpoints_JobId] ON [dbo].[ExportImportCheckpoints] ([JobId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExportImportCheckpoints] ADD CONSTRAINT [FK_ExportImportCheckpoints_JobId] FOREIGN KEY ([JobId]) REFERENCES [dbo].[ExportImportJobs] ([JobId]) ON DELETE CASCADE
GO
