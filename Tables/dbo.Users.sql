CREATE TABLE [dbo].[Users]
(
[UserID] [int] NOT NULL IDENTITY(1, 1),
[Username] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FirstName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsSuperUser] [bit] NOT NULL CONSTRAINT [DF_Users_IsSuperUser] DEFAULT ((0)),
[AffiliateId] [int] NULL,
[Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Users_DisplayName] DEFAULT (''),
[UpdatePassword] [bit] NOT NULL CONSTRAINT [DF_Users_UpdatePassword] DEFAULT ((0)),
[LastIPAddress] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Users_IsDeleted] DEFAULT ((0)),
[CreatedByUserID] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserID] [int] NULL,
[LastModifiedOnDate] [datetime] NULL,
[PasswordResetToken] [uniqueidentifier] NULL,
[PasswordResetExpiration] [datetime] NULL,
[LowerEmail] AS (lower([Email])) PERSISTED
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED  ([UserID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Users_DisplayName] ON [dbo].[Users] ([DisplayName], [IsSuperUser], [IsDeleted]) INCLUDE ([UserID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Users_Email] ON [dbo].[Users] ([Email]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Users_LowerEmail] ON [dbo].[Users] ([Email]) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET ARITHABORT ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE NONCLUSTERED INDEX [IX_Users_FirstName] ON [dbo].[Users] ([FirstName], [IsSuperUser], [IsDeleted]) INCLUDE ([UserID]) WHERE ([FirstName] IS NOT NULL AND [FirstName]<>N'') ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Users_IsDeleted_DisplayName] ON [dbo].[Users] ([IsDeleted], [DisplayName]) INCLUDE ([Email], [IsSuperUser], [UserID]) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET ARITHABORT ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_IsSuperuser] ON [dbo].[Users] ([IsSuperUser] DESC, [Username]) INCLUDE ([DisplayName], [Email], [FirstName], [IsDeleted], [LastModifiedOnDate], [LastName], [UserID]) WHERE ([IsSuperUser]=(1)) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Users_LastModifiedOnDate] ON [dbo].[Users] ([LastModifiedOnDate] DESC) INCLUDE ([IsSuperUser], [UserID]) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET ARITHABORT ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE NONCLUSTERED INDEX [IX_Users_LastName] ON [dbo].[Users] ([LastName], [IsSuperUser], [IsDeleted]) INCLUDE ([UserID]) WHERE ([LastName] IS NOT NULL AND [LastName]<>N'') ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [IX_Users] UNIQUE NONCLUSTERED  ([Username]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_UserName_UserID] ON [dbo].[Users] ([Username], [UserID]) INCLUDE ([AffiliateId], [CreatedByUserID], [CreatedOnDate], [DisplayName], [Email], [FirstName], [IsDeleted], [IsSuperUser], [LastIPAddress], [LastModifiedByUserID], [LastModifiedOnDate], [LastName], [PasswordResetExpiration], [PasswordResetToken], [UpdatePassword]) ON [PRIMARY]
GO
