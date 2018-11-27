CREATE TABLE [dbo].[Files]
(
[FileId] [int] NOT NULL IDENTITY(1, 1),
[PortalId] [int] NULL,
[FileName] [nvarchar] (246) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Extension] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Size] [int] NOT NULL,
[Width] [int] NULL,
[Height] [int] NULL,
[ContentType] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FolderID] [int] NOT NULL,
[Content] [image] NULL,
[CreatedByUserID] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserID] [int] NULL,
[LastModifiedOnDate] [datetime] NULL,
[UniqueId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Files_UniqueId] DEFAULT (newid()),
[VersionGuid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Files_VersionGuid] DEFAULT (newid()),
[SHA1Hash] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastModificationTime] [datetime] NOT NULL CONSTRAINT [DF__Files__LastM__629A9179] DEFAULT (getdate()),
[Folder] AS ([dbo].[GetFileFolderFunc]([FolderID])),
[Title] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartDate] [date] NOT NULL CONSTRAINT [DF__Files__StartDate__7795AE5F] DEFAULT (getdate()),
[EnablePublishPeriod] [bit] NOT NULL CONSTRAINT [DF__Files__EnablePub__7889D298] DEFAULT ((0)),
[EndDate] [date] NULL,
[PublishedVersion] [int] NOT NULL CONSTRAINT [DF__Files__Published__7A721B0A] DEFAULT ((1)),
[ContentItemID] [int] NULL,
[HasBeenPublished] [bit] NOT NULL CONSTRAINT [DF__Files__HasBeenPu__7ABCFF24] DEFAULT ((1)),
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Files] ADD CONSTRAINT [PK_File] PRIMARY KEY CLUSTERED  ([FileId]) ON [PRIMARY]
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
CREATE NONCLUSTERED INDEX [IX_Files_ContentID] ON [dbo].[Files] ([ContentItemID]) INCLUDE ([FileId], [FileName], [FolderID], [PublishedVersion]) WHERE ([ContentItemId] IS NOT NULL) ON [PRIMARY]
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
CREATE NONCLUSTERED INDEX [IX_Files_FileID] ON [dbo].[Files] ([FileId]) INCLUDE ([FileName], [FolderID], [PortalId], [PublishedVersion]) WHERE ([ContentItemId] IS NOT NULL) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Files_PortalID] ON [dbo].[Files] ([PortalId], [FolderID], [FileName]) INCLUDE ([FileId], [PublishedVersion]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Files] ADD CONSTRAINT [IX_Files_UniqueId] UNIQUE NONCLUSTERED  ([UniqueId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Files] ADD CONSTRAINT [FK_Files_ContentItems] FOREIGN KEY ([ContentItemID]) REFERENCES [dbo].[ContentItems] ([ContentItemID])
GO
ALTER TABLE [dbo].[Files] ADD CONSTRAINT [FK_Files_Folders] FOREIGN KEY ([FolderID]) REFERENCES [dbo].[Folders] ([FolderID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Files] ADD CONSTRAINT [FK_Files_Portals] FOREIGN KEY ([PortalId]) REFERENCES [dbo].[Portals] ([PortalID])
GO
