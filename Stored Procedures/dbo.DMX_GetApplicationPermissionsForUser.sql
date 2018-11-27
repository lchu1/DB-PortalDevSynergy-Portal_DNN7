SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetApplicationPermissionsForUser]
 @PortalId INT,
 @UserId INT
AS
SELECT
 *
FROM
 dbo.vw_DMX_ApplicationPermissions ap
 LEFT JOIN dbo.vw_DMX_ActiveUserRoles aur ON ap.RoleId=aur.RoleId
WHERE
 ap.PortalId = @PortalId
 AND ISNULL(aur.UserId, ap.UserId) = @UserId
 AND ap.AllowAccess = 1
GO
