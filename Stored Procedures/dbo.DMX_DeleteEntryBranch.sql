SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteEntryBranch]
 @PortalId INT,
 @EntryId INT,
 @IncludeSelf BIT
AS
EXEC dbo.DMX_UpdatePaths @PortalId, @EntryId;
DECLARE @Path VARCHAR(4000)
SELECT @Path=[Path] FROM dbo.DMX_Entries WHERE EntryId=@EntryID AND PortalId=@PortalID;
DELETE FROM dbo.DMX_EntryAttributes
 FROM dbo.DMX_EntryAttributes ea
 INNER JOIN dbo.DMX_Entries e ON ea.EntryId=e.EntryId
 WHERE ((e.[Path] LIKE @Path+'%') OR (@IncludeSelf=1 AND e.LastVersionId=@EntryId))
 AND (@IncludeSelf=1 OR (NOT [Path]=@Path));
DELETE FROM dbo.DMX_Attributes
 FROM dbo.DMX_Attributes a
 INNER JOIN dbo.DMX_Entries e ON a.CollectionId=e.EntryId
 WHERE ((e.[Path] LIKE @Path+'%') OR (@IncludeSelf=1 AND e.LastVersionId=@EntryId))
 AND (@IncludeSelf=1 OR (NOT [Path]=@Path));
DELETE FROM dbo.DMX_Entries
 WHERE (([Path] LIKE @Path+'%') OR (@IncludeSelf=1 AND LastVersionId=@EntryId))
 AND (@IncludeSelf=1 OR (NOT [Path]=@Path));
GO
