CREATE TABLE [dbo].[_CHCNWEB_PendingInactiveUserEmailLog]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[UserID] [int] NULL,
[UserName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserEmail] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserCreateDate] [datetime] NULL,
[UserLastLoginDate] [datetime] NULL,
[UserAuthorized] [bit] NULL,
[LocalAdminID] [int] NULL,
[LocalAdminName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LocalAdminEmail] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailSentDate] [datetime] NULL
) ON [PRIMARY]
GO
