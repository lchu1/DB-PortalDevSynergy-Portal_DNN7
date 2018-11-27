CREATE TABLE [dbo].[DMX_EntryAttributes]
(
[AttributeId] [int] NOT NULL,
[EntryId] [int] NOT NULL,
[Value] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_EntryAttributes] ADD CONSTRAINT [PK_DMX_EntryAttributes] PRIMARY KEY CLUSTERED  ([AttributeId], [EntryId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DMX_EntryAttributes_EntryId] ON [dbo].[DMX_EntryAttributes] ([EntryId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_EntryAttributes] WITH NOCHECK ADD CONSTRAINT [FK_DMX_EntryAttributes_Attributes] FOREIGN KEY ([AttributeId]) REFERENCES [dbo].[DMX_Attributes] ([AttributeId])
GO
ALTER TABLE [dbo].[DMX_EntryAttributes] WITH NOCHECK ADD CONSTRAINT [FK_DMX_EntryAttributes_Entries] FOREIGN KEY ([EntryId]) REFERENCES [dbo].[DMX_Entries] ([EntryId]) ON DELETE CASCADE
GO
