SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SoftDeleteEntry]
 @PortalId Int,
 @EntryId Int,
 @Delete Bit
AS
EXEC dbo.DMX_UpdatePaths @PortalId, @EntryId;
DECLARE @LastVersionId INT
SELECT @LastVersionId=(SELECT LastVersionId FROM dbo.DMX_Entries WHERE EntryId=@EntryId AND PortalId=@PortalId)
DECLARE @Path VARCHAR(4000)
SELECT @Path = (SELECT [Path] FROM dbo.DMX_Entries WHERE EntryId=@LastVersionId AND PortalId=@PortalId)
UPDATE dbo.DMX_Entries
 SET Deleted=@Delete
 WHERE LastVersionId=@LastVersionId AND PortalId=@PortalId;
IF @Delete=1
 UPDATE dbo.DMX_Entries
  SET Deleted=1
  WHERE Path LIKE @Path + '%' AND PortalId=@PortalId;
GO
