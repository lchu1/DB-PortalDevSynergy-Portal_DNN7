SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddEntry]
 @PortalId INT, 
 @Author NVARCHAR (500), 
 @CollectionId INT, 
 @Created DATETIME, 
 @Deleted BIT, 
 @Entry NVARCHAR (2000), 
 @EntryType NVARCHAR (150), 
 @FileSize BIGINT, 
 @Hidden BIT, 
 @InheritAttributes BIT, 
 @IsApproved BIT, 
 @Keywords NVARCHAR (255), 
 @LastVersionId INT, 
 @LockedBy INT, 
 @LockedUntil DATETIME, 
 @LockKey UNIQUEIDENTIFIER, 
 @MD5Hash NVARCHAR (50), 
 @OriginalFileName NVARCHAR (255), 
 @Owner INT, 
 @PermissionsOnlyByAdmin BIT, 
 @Remarks NVARCHAR (MAX), 
 @State NVARCHAR (50), 
 @StorageProviderID INT, 
 @Thumbnail VARCHAR (200), 
 @Title NVARCHAR (1000), 
 @Version INT, 
 @VersionsToKeep INT, 
 @WorkflowId NVARCHAR (50)
AS
INSERT INTO dbo.DMX_Entries (
 [PortalId],
 [Author],
 [CollectionId],
 [Created],
 [Deleted],
 [Entry],
 [EntryType],
 [FileSize],
 [Hidden],
 [InheritAttributes],
 [IsApproved],
 [Keywords],
 [LastVersionId],
 [LockedBy],
 [LockedUntil],
 [LockKey],
 [MD5Hash],
 [OriginalFileName],
 [Owner],
 [PermissionsOnlyByAdmin],
 [Remarks],
 [State],
 [StorageProviderID],
 [Thumbnail],
 [Title],
 [Version],
 [VersionsToKeep],
 [WorkflowId]
)
 VALUES ( @PortalId, @Author, @CollectionId, @Created, @Deleted, @Entry, @EntryType, @FileSize, @Hidden, @InheritAttributes, @IsApproved, @Keywords, @LastVersionId, @LockedBy, @LockedUntil, @LockKey, @MD5Hash, @OriginalFileName, @Owner, @PermissionsOnlyByAdmin, @Remarks, @State, @StorageProviderID, @Thumbnail, @Title, @Version, @VersionsToKeep, @WorkflowId)
select SCOPE_IDENTITY()
GO
