CREATE TABLE [dbo].[SearchCommonWords]
(
[CommonWordID] [int] NOT NULL IDENTITY(1, 1),
[CommonWord] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Locale] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SearchCommonWords] ADD CONSTRAINT [PK_SearchCommonWords] PRIMARY KEY CLUSTERED  ([CommonWordID]) ON [PRIMARY]
GO
