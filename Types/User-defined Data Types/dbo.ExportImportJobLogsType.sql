CREATE TYPE [dbo].[ExportImportJobLogsType] AS TABLE
(
[JobId] [int] NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Value] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Level] [int] NULL,
[CreatedOnDate] [datetime] NULL
)
GO
