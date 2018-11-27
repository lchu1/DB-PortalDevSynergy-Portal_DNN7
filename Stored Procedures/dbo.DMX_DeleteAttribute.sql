SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteAttribute]
 @AttributeId INT
AS
DELETE FROM dbo.DMX_EntryAttributes
WHERE
 [AttributeId] = @AttributeId;
DELETE FROM dbo.DMX_Attributes
WHERE
 [AttributeId] = @AttributeId
GO
