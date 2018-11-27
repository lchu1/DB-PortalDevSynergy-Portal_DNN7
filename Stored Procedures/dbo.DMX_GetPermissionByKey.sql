SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetPermissionByKey]
 @PermissionKey NVARCHAR(20),
 @PortalId INT
AS
SELECT p.* 
 FROM dbo.DMX_Permissions p 
 WHERE (p.PermissionKey=@PermissionKey) AND (p.PortalId=@PortalId)
GO
