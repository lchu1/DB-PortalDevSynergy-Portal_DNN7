SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeletePermissionEntrytype]
 @EntryType NVARCHAR (100),
 @PermissionId INT
AS
DELETE FROM dbo.DMX_PermissionEntrytypes
WHERE
 [EntryType] = @EntryType
 AND [PermissionId] = @PermissionId
GO
