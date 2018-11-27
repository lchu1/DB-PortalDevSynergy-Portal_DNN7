SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetAttributeEntrytype]
 @AttributeId INT,
 @EntryType NVARCHAR (50)
AS
SELECT
 *
FROM
 dbo.DMX_AttributeEntrytypes
WHERE
 [AttributeId] = @AttributeId
 AND [EntryType] = @EntryType
GO
