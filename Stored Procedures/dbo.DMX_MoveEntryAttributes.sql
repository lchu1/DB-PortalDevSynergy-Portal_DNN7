SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_MoveEntryAttributes]
 @Path VARCHAR(4000),
 @OldAttributeId INT,
 @NewAttributeId INT
AS
UPDATE dbo.DMX_EntryAttributes
SET AttributeId=@NewAttributeId
WHERE AttributeId=@OldAttributeId
 AND EntryId IN 
 (SELECT EntryId FROM dbo.DMX_Entries 
 WHERE Path LIKE @Path+'%')
GO
