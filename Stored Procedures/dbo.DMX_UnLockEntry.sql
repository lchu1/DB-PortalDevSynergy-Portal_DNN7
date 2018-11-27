SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UnLockEntry]
 @PortalId Int,
 @EntryId Int
AS
UPDATE dbo.DMX_Entries SET
 [LockedBy] = -1,
 [LockedUntil] = GETDATE(),
 [LockKey] = NULL
WHERE
 ([EntryId] = @EntryId OR LastVersionId=@EntryId)
 AND [PortalId] = @PortalId;
GO
