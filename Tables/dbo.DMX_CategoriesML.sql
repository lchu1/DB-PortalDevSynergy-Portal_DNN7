CREATE TABLE [dbo].[DMX_CategoriesML]
(
[CategoryId] [int] NOT NULL,
[Locale] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CategoryName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_CategoriesML] ADD CONSTRAINT [PK_DMX_CategoriesML] PRIMARY KEY CLUSTERED  ([CategoryId], [Locale]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_CategoriesML] WITH NOCHECK ADD CONSTRAINT [FK_DMX_CategoriesML_Categories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[DMX_Categories] ([CategoryId]) ON DELETE CASCADE
GO
