CREATE TABLE [dbo].[SearchIndexer]
(
[SearchIndexerID] [int] NOT NULL IDENTITY(1, 1),
[SearchIndexerAssemblyQualifiedName] [char] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SearchIndexer] ADD CONSTRAINT [PK_SearchIndexer] PRIMARY KEY CLUSTERED  ([SearchIndexerID]) ON [PRIMARY]
GO
