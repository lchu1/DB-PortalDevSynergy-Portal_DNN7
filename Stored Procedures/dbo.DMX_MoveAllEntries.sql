SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_MoveAllEntries]
 @PortalId Int,
 @OldCollectionId Int,
 @NewCollectionId Int
AS
UPDATE dbo.DMX_Entries SET
 [CollectionId] = @NewCollectionId
WHERE
 [CollectionId] = @OldCollectionId
 AND [PortalId] = @PortalId
GO
