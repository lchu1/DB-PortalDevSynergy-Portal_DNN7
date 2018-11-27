CREATE TABLE [dbo].[DMX_AttributesML]
(
[AttributeId] [int] NOT NULL,
[Locale] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AttributeName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_AttributesML] ADD CONSTRAINT [PK_DMX_AttributesML] PRIMARY KEY CLUSTERED  ([AttributeId], [Locale]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_AttributesML] WITH NOCHECK ADD CONSTRAINT [FK_DMX_AttributesML_Attributes] FOREIGN KEY ([AttributeId]) REFERENCES [dbo].[DMX_Attributes] ([AttributeId]) ON DELETE CASCADE
GO
