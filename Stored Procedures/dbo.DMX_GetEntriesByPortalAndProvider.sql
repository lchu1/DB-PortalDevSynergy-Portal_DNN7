SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntriesByPortalAndProvider]
 @PortalId INT,
 @ProviderId INT
AS
SELECT
 *,
 '' AS Title,
 '' AS Remarks
FROM
 dbo.DMX_Entries
WHERE
 [PortalId] = @PortalId
 AND [StorageProviderID]=@ProviderID
GO
