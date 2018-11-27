SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_RemoveDeadPermissions]
AS
DELETE FROM
 dbo.DMX_EntryPermissions
WHERE
 (NOT EXISTS(SELECT * FROM dbo.Roles r WHERE r.RoleId=dbo.DMX_EntryPermissions.RoleId) AND RoleId>-1 AND UserId=-10)
OR
 (NOT EXISTS(SELECT * FROM dbo.Users s WHERE s.UserId=dbo.DMX_EntryPermissions.UserId) AND UserId>-1 AND RoleId=-1)
GO
