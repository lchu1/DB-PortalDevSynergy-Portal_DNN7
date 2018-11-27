SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetUserRoles]
 @PortalId INT,
 @UserId INT,
 @Roles VARCHAR(50)
AS
SELECT r.*
FROM dbo.Roles r
 INNER JOIN dbo.vw_DMX_ActiveUserRoles aur ON r.RoleId=aur.RoleId
WHERE aur.UserId=@UserId
 AND @Roles LIKE '%;'+CAST(aur.RoleId AS VARCHAR)+';%'
GO
