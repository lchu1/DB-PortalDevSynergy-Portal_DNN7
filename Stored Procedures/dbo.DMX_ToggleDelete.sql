SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_ToggleDelete]
 @PortalId INT,
 @LastVersionId INT,
 @Delete BIT
AS
UPDATE dbo.DMX_Entries
 SET Deleted=@Delete
 WHERE LastVersionId=@LastVersionId
 AND PortalId=@PortalId
GO
