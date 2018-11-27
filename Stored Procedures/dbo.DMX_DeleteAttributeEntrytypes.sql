SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteAttributeEntrytypes]
 @AttributeId Int
AS
DELETE FROM dbo.DMX_AttributeEntrytypes
WHERE
 [AttributeId] = @AttributeId
GO
