SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_IsEntryPermissionByAdmin]
 @PortalId Int,
 @EntryId Int
AS
 IF EXISTS(SELECT PermissionsOnlyByAdmin FROM dbo.DMX_Entries WHERE EntryId=@EntryId AND PermissionsOnlyByAdmin=1)
  SELECT 1
 ELSE
  DECLARE @Path VARCHAR(2000)
  SELECT @Path = ';'+(SELECT Path FROM dbo.DMX_Entries WHERE EntryId=@EntryId)+';'
  IF EXISTS(SELECT PermissionsOnlyByAdmin FROM dbo.DMX_Entries WHERE PermissionsOnlyByAdmin=1 AND @Path LIKE '%;'+CAST(EntryId AS VARCHAR(10))+';%')
   SELECT 1
  ELSE
   SELECT 0
GO
