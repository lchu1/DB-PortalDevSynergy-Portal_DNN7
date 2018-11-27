CREATE TABLE [dbo].[AuthCookies]
(
[CookieId] [int] NOT NULL IDENTITY(1, 1),
[CookieValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ExpiresOn] [datetime] NOT NULL,
[UserId] [int] NOT NULL,
[CreatedOn] [datetime] NULL,
[UpdatedOn] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuthCookies] ADD CONSTRAINT [PK_AuthCookies] PRIMARY KEY CLUSTERED  ([CookieId] DESC) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AuthCookies_CookieValue] ON [dbo].[AuthCookies] ([CookieValue]) ON [PRIMARY]
GO
