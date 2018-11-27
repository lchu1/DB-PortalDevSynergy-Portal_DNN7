SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetExtensionsByPortal]
 @PortalId Int
AS
SELECT
 *
FROM
 dbo.DMX_Extensions
WHERE
 PortalId = @PortalId
GO
