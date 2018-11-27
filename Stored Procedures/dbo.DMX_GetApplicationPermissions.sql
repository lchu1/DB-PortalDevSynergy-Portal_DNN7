SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetApplicationPermissions]
 @PortalId INT
AS
SELECT
 *
FROM
 dbo.vw_DMX_ApplicationPermissions
WHERE
 [PortalId] = @PortalId
GO
