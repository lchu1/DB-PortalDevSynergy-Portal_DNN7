SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeletePermissionPermissions]
 @PortalId INT
AS
DELETE FROM
 dbo.DMX_PermissionPermissions
WHERE
 [PortalId] = @PortalId
GO
