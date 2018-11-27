CREATE TABLE [dbo].[DMX_EntriesML]
(
[EntryId] [int] NOT NULL,
[Locale] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Remarks] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_EntriesML] ADD CONSTRAINT [PK_DMX_EntriesML] PRIMARY KEY CLUSTERED  ([EntryId], [Locale]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_EntriesML] WITH NOCHECK ADD CONSTRAINT [FK_DMX_EntriesML_Entries] FOREIGN KEY ([EntryId]) REFERENCES [dbo].[DMX_Entries] ([EntryId]) ON DELETE CASCADE
GO
