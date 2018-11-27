CREATE TABLE [dbo].[CHCNPortal_UserSecurityAnswers]
(
[UserID] [int] NOT NULL,
[SecurityQuestionID] [int] NOT NULL,
[SecurityAnswer] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
