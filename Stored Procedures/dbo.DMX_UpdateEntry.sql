SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateEntry]
 @PortalId INT, 
 @Author NVARCHAR (500), 
 @CollectionId INT, 
 @Created DATETIME, 
 @Deleted BIT, 
 @Entry NVARCHAR (2000), 
 @EntryId INT, 
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
UPDATE dbo.DMX_Entries SET
 [PortalId] = @PortalId,
 [Author] = @Author,
 [CollectionId] = @CollectionId,
 [Created] = @Created,
 [Deleted] = @Deleted,
 [Entry] = @Entry,
 [EntryType] = @EntryType,
 [FileSize] = @FileSize,
 [Hidden] = @Hidden,
 [InheritAttributes] = @InheritAttributes,
 [IsApproved] = @IsApproved,
 [Keywords] = @Keywords,
 [LastVersionId] = @LastVersionId,
 [LockedBy] = @LockedBy,
 [LockedUntil] = @LockedUntil,
 [LockKey] = @LockKey,
 [MD5Hash] = @MD5Hash,
 [OriginalFileName] = @OriginalFileName,
 [Owner] = @Owner,
 [PermissionsOnlyByAdmin] = @PermissionsOnlyByAdmin,
 [Remarks] = @Remarks,
 [State] = @State,
 [StorageProviderID] = @StorageProviderID,
 [Thumbnail] = @Thumbnail,
 [Title] = @Title,
 [Version] = @Version,
 [VersionsToKeep] = @VersionsToKeep,
 [WorkflowId] = @WorkflowId
WHERE
 [EntryId] = @EntryId
GO
