SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryPermissionsByEntry]
 @EntryId Int
AS
SELECT
 *
FROM
 dbo.vw_DMX_EntryPermissions
WHERE
 EntryId = @EntryId
GO
