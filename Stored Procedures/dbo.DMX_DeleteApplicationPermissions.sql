SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteApplicationPermissions]
 @PortalId INT
AS
DELETE FROM
 dbo.DMX_ApplicationPermissions
WHERE
 [PortalId] = @PortalId
GO
