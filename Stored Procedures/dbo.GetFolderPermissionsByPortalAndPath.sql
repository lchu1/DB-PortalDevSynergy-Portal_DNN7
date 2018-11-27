SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetFolderPermissionsByPortalAndPath]
    @PortalId int,
    @FolderPath nvarchar(300)
AS
BEGIN
    SET @PortalId = IsNull(@PortalId, -1)

    SELECT *
    FROM   dbo.[vw_FolderPermissions]
    WHERE  PortalID = @PortalId AND (FolderPath = @FolderPath OR @FolderPath IS NULL)
END
GO
