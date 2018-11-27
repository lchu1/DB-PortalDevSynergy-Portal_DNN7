SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_LockEntry]
 @PortalId Int,
 @EntryId Int,
 @LockedUntil DateTime,
 @LockedBy Int,
 @LockKey UNIQUEIDENTIFIER
AS
UPDATE dbo.DMX_Entries SET
 [LockedBy] = @LockedBy,
 [LockedUntil] = @LockedUntil,
 [LockKey] = @LockKey
WHERE
 ([EntryId] = @EntryId OR LastVersionId=@EntryId)
 AND [PortalId] = @PortalId;
GO
