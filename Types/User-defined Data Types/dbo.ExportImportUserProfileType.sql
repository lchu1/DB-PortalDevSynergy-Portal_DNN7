CREATE TYPE [dbo].[ExportImportUserProfileType] AS TABLE
(
[PortalId] [int] NULL,
[UserId] [int] NULL,
[PropertyDefinitionId] [int] NULL,
[PropertyValue] [nvarchar] (3750) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Visibility] [int] NULL,
[ExtendedVisibility] [varchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsSuperUser] [bit] NULL
)
GO
