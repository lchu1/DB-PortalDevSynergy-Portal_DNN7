CREATE TABLE [dbo].[PurgeUsers]
(
[UserId] [uniqueidentifier] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastLoginDate] [datetime] NOT NULL,
[UserName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserID2] [int] NOT NULL
) ON [PRIMARY]
GO
