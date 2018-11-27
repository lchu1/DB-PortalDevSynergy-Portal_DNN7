SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_ClearEntryPermissions]
 @PortalId INT,
 @EntryId INT
AS
DELETE FROM dbo.DMX_EntryPermissions 
 WHERE (PortalId=@PortalId) AND (EntryId=@EntryId)
GO
