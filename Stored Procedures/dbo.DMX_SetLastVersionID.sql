SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SetLastVersionID]
 @PortalId INT,
 @EntryId INT = -1
AS
UPDATE dbo.DMX_Entries 
 SET LastVersionID = EntryID 
 WHERE LastVersionId IS NULL 
  AND (EntryId=@EntryID OR @EntryId=-1) 
  AND PortalId=@PortalId;
GO
