SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetUsersByRoleId]
 @RoleId INT
AS
SELECT u.*
FROM dbo.Users u
 INNER JOIN dbo.vw_DMX_ActiveUserRoles aur ON u.UserId=aur.UserId
WHERE aur.RoleId=@RoleId
GO
