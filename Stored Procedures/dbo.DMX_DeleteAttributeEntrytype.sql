SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteAttributeEntrytype]
 @AttributeId INT,
 @EntryType NVARCHAR (50)
AS
DELETE FROM dbo.DMX_AttributeEntrytypes
WHERE
 [AttributeId] = @AttributeId
 AND [EntryType] = @EntryType
GO
