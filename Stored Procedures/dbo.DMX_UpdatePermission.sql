SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdatePermission]
 @PortalId INT, 
 @Addon NVARCHAR (50), 
 @PermissionId INT, 
 @PermissionKey NVARCHAR (20), 
 @ResourceFile NVARCHAR (255)
AS
UPDATE dbo.DMX_Permissions SET
 [PortalId] = @PortalId,
 [Addon] = @Addon,
 [PermissionKey] = @PermissionKey,
 [ResourceFile] = @ResourceFile
WHERE
 [PermissionId] = @PermissionId
GO
