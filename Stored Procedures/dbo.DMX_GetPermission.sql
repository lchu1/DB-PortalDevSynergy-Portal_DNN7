SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetPermission]
 @PermissionId INT
AS
SELECT
 *
FROM
 dbo.DMX_Permissions
WHERE
 [PermissionId] = @PermissionId
GO
