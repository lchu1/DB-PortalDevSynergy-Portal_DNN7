CREATE TABLE [dbo].[DMX_EntryCategories]
(
[CategoryId] [int] NOT NULL,
[EntryId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_EntryCategories] ADD CONSTRAINT [PK_DMX_EntryCategories] PRIMARY KEY CLUSTERED  ([CategoryId], [EntryId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DMX_EntryCategories_EntryId] ON [dbo].[DMX_EntryCategories] ([EntryId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_EntryCategories] WITH NOCHECK ADD CONSTRAINT [FK_DMX_EntryCategories_Entries] FOREIGN KEY ([EntryId]) REFERENCES [dbo].[DMX_Entries] ([EntryId]) ON DELETE CASCADE
GO
