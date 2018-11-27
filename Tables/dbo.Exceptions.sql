CREATE TABLE [dbo].[Exceptions]
(
[ExceptionHash] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Message] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StackTrace] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InnerMessage] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InnerStackTrace] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Source] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Exceptions] ADD CONSTRAINT [PK_Exceptions] PRIMARY KEY CLUSTERED  ([ExceptionHash]) ON [PRIMARY]
GO
