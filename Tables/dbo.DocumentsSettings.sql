CREATE TABLE [dbo].[DocumentsSettings]
(
[ModuleID] [int] NOT NULL,
[ShowTitleLink] [bit] NULL,
[SortOrder] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayColumns] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UseCategoriesList] [bit] NULL,
[DefaultFolder] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CategoriesListName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AllowUserSort] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentsSettings] ADD CONSTRAINT [PK_DocumentsSettings] PRIMARY KEY CLUSTERED  ([ModuleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentsSettings] WITH NOCHECK ADD CONSTRAINT [FK_DocumentsSettings_Modules] FOREIGN KEY ([ModuleID]) REFERENCES [dbo].[Modules] ([ModuleID]) ON DELETE CASCADE
GO
