CREATE TABLE [dbo].[SearchStopWords]
(
[StopWordsID] [int] NOT NULL IDENTITY(1, 1),
[StopWords] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedByUserID] [int] NOT NULL,
[CreatedOnDate] [datetime] NOT NULL,
[LastModifiedByUserID] [int] NOT NULL,
[LastModifiedOnDate] [datetime] NOT NULL,
[PortalID] [int] NOT NULL,
[CultureCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SearchStopWords] ADD CONSTRAINT [PK_SearchStopWords] PRIMARY KEY CLUSTERED  ([StopWordsID]) ON [PRIMARY]
GO
