SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO


CREATE        procedure [dbo].[CHCNWEB_GetUserRoles]
	@UserId int
AS
SELECT     DISTINCT U.UserID, U.RoleID, R.RoleName
FROM    UserRoles U join Roles R on U.RoleID=R.RoleID 
WHERE   UserID = @UserID


GO
