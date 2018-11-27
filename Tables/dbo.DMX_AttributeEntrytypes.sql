CREATE TABLE [dbo].[DMX_AttributeEntrytypes]
(
[AttributeId] [int] NOT NULL,
[EntryType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_AttributeEntrytypes] ADD CONSTRAINT [PK_DMX_AttributeEntrytypes] PRIMARY KEY CLUSTERED  ([AttributeId], [EntryType]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_AttributeEntrytypes] WITH NOCHECK ADD CONSTRAINT [FK_DMX_AttributeEntrytypes_Attributes] FOREIGN KEY ([AttributeId]) REFERENCES [dbo].[DMX_Attributes] ([AttributeId]) ON DELETE CASCADE
GO
