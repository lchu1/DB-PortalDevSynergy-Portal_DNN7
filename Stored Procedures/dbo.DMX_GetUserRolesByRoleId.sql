SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetUserRolesByRoleId]
 @PortalId INT,
 @RoleId INT
AS
SELECT ur.*
 FROM dbo.vw_DMX_ActiveUserRoles ur
 INNER JOIN dbo.Roles r ON r.RoleId=ur.RoleID
 WHERE r.PortalID=@PortalId
 AND NOT ur.RoleID IS NULL
GO
