SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetPermissionEntrytypesByPermission]
 @PermissionId Int
AS
SELECT
 * 
FROM
 dbo.DMX_PermissionEntrytypes
WHERE
 PermissionId = @PermissionId
GO
