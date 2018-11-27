CREATE TABLE [dbo].[DMX_SearchResults]
(
[SearchId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EntryId] [int] NOT NULL,
[Rank] [real] NULL,
[Hits] [int] NOT NULL,
[Extract] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DMX_SearchResults_EntryID] ON [dbo].[DMX_SearchResults] ([EntryId]) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_DMX_SearchResults] ON [dbo].[DMX_SearchResults] ([SearchId]) ON [PRIMARY]
GO
