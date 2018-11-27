SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetFromRepository]
 @BlobId Int,
 @PortalId int
AS
SELECT
 [Blob],
 [BlobId],
 [PortalId]
FROM
 dbo.DMX_Repository
WHERE
 [BlobId] = @BlobId
 AND [PortalId] = @PortalId
GO
