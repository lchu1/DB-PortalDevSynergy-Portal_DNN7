SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddPermissionEntrytype]
 @EntryType NVARCHAR (100), 
 @PermissionId INT
AS
INSERT INTO dbo.DMX_PermissionEntrytypes (
 [EntryType],
 [PermissionId])
VALUES (
 @EntryType,
 @PermissionId)
GO
