CREATE TABLE [dbo].[OutputCache]
(
[CacheKey] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ItemId] [int] NOT NULL,
[Data] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Expiration] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OutputCache] ADD CONSTRAINT [PK_OutputCache] PRIMARY KEY CLUSTERED  ([CacheKey]) ON [PRIMARY]
GO
