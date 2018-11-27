CREATE TABLE [dbo].[SearchTypes]
(
[SearchTypeId] [int] NOT NULL IDENTITY(1, 1),
[SearchTypeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SearchResultClass] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsPrivate] [bit] NULL CONSTRAINT [DF_SearchTypes_IsPrivate] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SearchTypes] ADD CONSTRAINT [PK_SearchTypes] PRIMARY KEY CLUSTERED  ([SearchTypeId]) ON [PRIMARY]
GO
