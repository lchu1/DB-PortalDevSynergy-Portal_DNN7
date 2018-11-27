SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateEntryAttribute]
 @AttributeId INT, 
 @EntryId INT, 
 @Value NVARCHAR (2000)
AS
UPDATE dbo.DMX_EntryAttributes SET
 [Value] = @Value
WHERE
 [AttributeId] = @AttributeId
 AND [EntryId] = @EntryId
GO
