SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteEntryAttribute]
 @AttributeId INT,
 @EntryId INT
AS
DELETE FROM dbo.DMX_EntryAttributes
WHERE
 [AttributeId] = @AttributeId
 AND [EntryId] = @EntryId
GO
