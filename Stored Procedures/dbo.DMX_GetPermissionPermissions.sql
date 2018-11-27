SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetPermissionPermissions]
 @PortalId INT
AS
SELECT
 *
FROM
 dbo.vw_DMX_PermissionPermissions
WHERE
 [PortalId] = @PortalId
GO
