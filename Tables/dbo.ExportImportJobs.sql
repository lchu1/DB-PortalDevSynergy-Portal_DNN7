CREATE TABLE [dbo].[ExportImportJobs]
(
[JobId] [int] NOT NULL IDENTITY(1, 1),
[PortalId] [int] NOT NULL,
[JobType] [int] NOT NULL,
[JobStatus] [int] NOT NULL CONSTRAINT [DF__ExportImp__JobSt__031D3AFB] DEFAULT ((0)),
[IsCancelled] [bit] NOT NULL CONSTRAINT [DF__ExportImp__IsCan__04115F34] DEFAULT ((0)),
[Name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedByUserID] [int] NOT NULL,
[CreatedOnDate] [datetime] NOT NULL CONSTRAINT [DF__ExportImp__Creat__0505836D] DEFAULT (getutcdate()),
[LastModifiedOnDate] [datetime] NOT NULL CONSTRAINT [DF__ExportImp__LastM__05F9A7A6] DEFAULT (getutcdate()),
[CompletedOnDate] [datetime] NULL,
[Directory] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[JobObject] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExportImportJobs] ADD CONSTRAINT [PK_ExportImportJobs] PRIMARY KEY CLUSTERED  ([JobId] DESC) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ExportImportJobs_CreatedOn] ON [dbo].[ExportImportJobs] ([CreatedOnDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ExportImportJobs_JobStatus] ON [dbo].[ExportImportJobs] ([JobStatus]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ExportImportJobs_JobType] ON [dbo].[ExportImportJobs] ([JobType]) ON [PRIMARY]
GO
