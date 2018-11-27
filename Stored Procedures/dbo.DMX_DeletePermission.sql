SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeletePermission]
 @PermissionId INT
AS
DELETE FROM dbo.DMX_Permissions
WHERE
 [PermissionId] = @PermissionId
GO
