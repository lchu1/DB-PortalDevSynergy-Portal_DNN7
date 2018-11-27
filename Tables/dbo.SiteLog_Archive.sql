CREATE TABLE [dbo].[SiteLog_Archive]
(
[SiteLogId] [int] NOT NULL,
[DateTime] [smalldatetime] NOT NULL,
[PortalId] [int] NOT NULL,
[UserId] [int] NULL,
[Referrer] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Url] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserAgent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserHostAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserHostName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TabId] [int] NULL,
[AffiliateId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SiteLog_Archive] ADD CONSTRAINT [PK_SiteLog_Archive] PRIMARY KEY CLUSTERED  ([SiteLogId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SiteLog_Archive] ADD CONSTRAINT [FK_SiteLog_Archive_Portals] FOREIGN KEY ([PortalId]) REFERENCES [dbo].[Portals] ([PortalID]) ON DELETE CASCADE
GO
