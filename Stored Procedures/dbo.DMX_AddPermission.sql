SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddPermission]
 @PortalId INT, 
 @Addon NVARCHAR (50), 
 @PermissionKey NVARCHAR (20), 
 @ResourceFile NVARCHAR (255)
AS
INSERT INTO dbo.DMX_Permissions (
 [PortalId],
 [Addon],
 [PermissionKey],
 [ResourceFile]
)
 VALUES ( @PortalId, @Addon, @PermissionKey, @ResourceFile)
select SCOPE_IDENTITY()
GO
