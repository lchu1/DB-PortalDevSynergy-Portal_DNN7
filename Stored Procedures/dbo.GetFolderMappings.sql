SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetFolderMappings]
	@PortalID int
AS
BEGIN
	SELECT *
	FROM dbo.[FolderMappings]
	WHERE ISNULL(PortalID, -1) = ISNULL(@PortalID, -1)
	ORDER BY Priority
END
GO
