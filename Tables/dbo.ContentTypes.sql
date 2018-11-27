CREATE TABLE [dbo].[ContentTypes]
(
[ContentTypeID] [int] NOT NULL IDENTITY(1, 1),
[ContentType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContentTypes] ADD CONSTRAINT [PK_ContentTypes] PRIMARY KEY CLUSTERED  ([ContentTypeID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ContentTypes_ContentType] ON [dbo].[ContentTypes] ([ContentType]) ON [PRIMARY]
GO
