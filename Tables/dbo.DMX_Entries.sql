CREATE TABLE [dbo].[DMX_Entries]
(
[Author] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CollectionId] [int] NULL,
[Deleted] [bit] NULL,
[Entry] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EntryId] [int] NOT NULL IDENTITY(1, 1),
[EntryType] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FileSize] [bigint] NULL,
[Created] [datetime] NULL,
[IsApproved] [bit] NULL,
[Keywords] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastModified] [datetime] NULL,
[LastVersionId] [int] NULL,
[LockedBy] [int] NULL,
[LockedUntil] [datetime] NULL,
[LockKey] [uniqueidentifier] NULL,
[MD5Hash] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OriginalFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Owner] [int] NULL,
[PortalId] [int] NULL,
[State] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Version] [int] NULL,
[VersionsToKeep] [int] NULL,
[WorkflowId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Path] [varchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PermissionsOnlyByAdmin] [bit] NULL,
[InheritAttributes] [bit] NOT NULL,
[StorageProviderID] [int] NULL,
[Thumbnail] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Hidden] [bit] NULL,
[Remarks] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[DMX_EntryTriggerDelete]
ON [dbo].[DMX_Entries]
AFTER DELETE
AS
IF TRIGGER_NESTLEVEL() < 2
BEGIN
 DECLARE @PortalId INT
 SELECT @PortalId = (SELECT TOP 1 PortalId FROM INSERTED);
-- select parents
 UPDATE e
 SET e.[FileSize] = e.[FileSize] - d.FileSize
 FROM dbo.DMX_Entries e
  INNER JOIN dbo.DMX_Entries e1 ON e1.Path LIKE e.Path+'%'
  INNER JOIN DELETED d ON d.CollectionId=e1.EntryId
  WHERE d.EntryId=d.LastVersionId AND e.EntryType LIKE 'Collection%';
 
END
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[DMX_EntryTriggerInsert]
ON [dbo].[DMX_Entries]
AFTER INSERT
AS
IF TRIGGER_NESTLEVEL() < 2
BEGIN
 -- select self (in root)
 UPDATE e
 SET e.[Path] = '0;' + CAST(i.EntryId AS NVARCHAR(20)) + ';',
  e.LastModified = ISNULL(e.LastModified, GETDATE()),
  e.LastVersionId = ISNULL(e.LastVersionId, e.EntryId)
 FROM dbo.DMX_Entries e
  INNER JOIN INSERTED i ON i.EntryId=e.EntryId
  WHERE i.CollectionId=0;
 -- select self (not in root)
 UPDATE e
 SET e.[Path] = e1.[Path] + CAST(i.EntryId AS NVARCHAR(20)) + ';',
  e.LastModified = ISNULL(e.LastModified, GETDATE()),
  e.LastVersionId = ISNULL(e.LastVersionId, e.EntryId)
 FROM dbo.DMX_Entries e
  INNER JOIN dbo.DMX_Entries e1 ON e1.EntryId LIKE e.CollectionId
  INNER JOIN INSERTED i ON i.EntryId=e.EntryId;
 
 -- select parents where new entry
 UPDATE e
 SET e.[FileSize] = e.[FileSize] + i.FileSize,
  e.LastModified = GETDATE()
 FROM dbo.DMX_Entries e
  INNER JOIN dbo.DMX_Entries e1 ON e1.Path LIKE e.Path+'%'
  INNER JOIN INSERTED i ON i.CollectionId=e1.EntryId
  WHERE e.EntryType LIKE 'Collection%' AND (i.LastVersionId IS NULL OR i.LastVersionId=i.EntryId);
 -- repair missing LastVersionId
 UPDATE dbo.DMX_Entries
 SET LastVersionId=EntryId
 WHERE LastVersionId IS NULL;
END
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[DMX_EntryTriggerUpdate]
ON [dbo].[DMX_Entries]
AFTER UPDATE
AS
IF TRIGGER_NESTLEVEL() < 2
 AND (UPDATE(Author) OR UPDATE(CollectionId) OR UPDATE([Entry]) OR UPDATE(EntryType) 
  OR UPDATE(IsApproved) OR UPDATE(Keywords) OR UPDATE(MD5Hash) OR UPDATE(OriginalFilename)
  OR UPDATE([State]) OR UPDATE(PermissionsOnlyByAdmin) OR UPDATE(InheritAttributes)
  OR UPDATE(Title) OR UPDATE(Remarks))
BEGIN
 DECLARE @PortalId INT
 SELECT @PortalId = (SELECT TOP 1 PortalId FROM INSERTED);
 DECLARE @Now DATETIME
 SET @Now = GETDATE()
-- move: select old parents
 UPDATE e
 SET e.[FileSize] = e.[FileSize] - i.FileSize
 FROM dbo.DMX_Entries e
  INNER JOIN dbo.DMX_Entries e1 ON e1.Path LIKE e.Path+'%'
  INNER JOIN DELETED d ON d.CollectionId=e1.EntryId
  INNER JOIN INSERTED i ON i.EntryId=d.EntryId AND i.CollectionId<>d.CollectionId
 WHERE e.EntryType LIKE 'Collection%';
-- move: select new parents
 UPDATE e
 SET e.[FileSize] = e.[FileSize] + i.FileSize,
  e.LastModified = @Now
 FROM dbo.DMX_Entries e
  INNER JOIN DMX_Entries e1 ON e1.Path LIKE e.Path+'%'
  INNER JOIN INSERTED i ON i.CollectionId=e1.EntryId
  INNER JOIN DELETED d ON i.EntryId=d.EntryId AND i.CollectionId<>d.CollectionId
 WHERE e.EntryType LIKE 'Collection%';
-- move: select self and children
 UPDATE e 
 SET [Path]=NULL
 FROM dbo.DMX_Entries e
  INNER JOIN DELETED d ON e.[Path] LIKE d.[Path]+'%'
  INNER JOIN INSERTED i ON i.EntryId=d.EntryId AND i.CollectionId<>d.CollectionId;
 EXEC dbo.DMX_UpdatePaths @PortalId, -1;
-- nomove/nonewversion: select parents
 UPDATE e
 SET e.LastModified = @Now
 FROM dbo.DMX_Entries e
  INNER JOIN dbo.DMX_Entries e1 ON e1.Path LIKE e.Path+'%'
  INNER JOIN INSERTED i ON i.CollectionId=e1.EntryId
  INNER JOIN DELETED d ON i.EntryId=d.EntryId AND i.CollectionId=d.CollectionId AND i.FileSize=d.FileSize
 WHERE e.EntryType LIKE 'Collection%';
-- nomove/newversion: select parents
 UPDATE e
 SET e.LastModified = @Now,
  e.FileSize = e.FileSize - d.FileSize + i.FileSize
 FROM dbo.DMX_Entries e
  INNER JOIN dbo.DMX_Entries e1 ON e1.Path LIKE e.Path+'%'
  INNER JOIN INSERTED i ON i.CollectionId=e1.EntryId
  INNER JOIN DELETED d ON i.EntryId=d.EntryId AND i.CollectionId=d.CollectionId AND i.FileSize<>d.FileSize;
-- move: select self
 UPDATE e
 SET e.LastModified = @Now
 FROM dbo.DMX_Entries e
  INNER JOIN INSERTED i ON i.EntryId=e.EntryId
  INNER JOIN DELETED d ON i.EntryId=d.EntryId AND d.LastModified=i.LastModified;
 
END
GO
ALTER TABLE [dbo].[DMX_Entries] ADD CONSTRAINT [PK_DMX_Entries] PRIMARY KEY CLUSTERED  ([EntryId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DMX_Entries_CollectionID] ON [dbo].[DMX_Entries] ([CollectionId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DMX_Entries_Data1] ON [dbo].[DMX_Entries] ([LastVersionId], [EntryId], [CollectionId], [Deleted], [IsApproved], [Owner], [Version], [EntryType]) INCLUDE ([Author], [Created], [Entry], [FileSize], [Keywords], [LastModified], [LockedBy], [LockedUntil], [LockKey], [MD5Hash], [OriginalFileName], [Path], [PermissionsOnlyByAdmin], [PortalId], [State], [VersionsToKeep], [WorkflowId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Entries] WITH NOCHECK ADD CONSTRAINT [FK_DMX_Entries_Portals] FOREIGN KEY ([PortalId]) REFERENCES [dbo].[Portals] ([PortalID]) ON DELETE CASCADE
GO
