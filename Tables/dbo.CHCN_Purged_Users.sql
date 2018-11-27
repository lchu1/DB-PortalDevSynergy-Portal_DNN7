CREATE TABLE [dbo].[CHCN_Purged_Users]
(
[UserID1] [uniqueidentifier] NULL,
[UserID2] [int] NULL,
[UserName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Company] [nvarchar] (3750) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyID] [nvarchar] (3750) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NULL,
[LastLoginDate] [datetime] NULL,
[LastActivityDate] [datetime] NULL,
[Authorised] [bit] NULL,
[DatePurged] [datetime] NULL
) ON [PRIMARY]
GO
