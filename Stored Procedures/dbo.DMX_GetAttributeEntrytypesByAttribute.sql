SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetAttributeEntrytypesByAttribute]
 @AttributeId Int
AS
SELECT
 *
FROM
 dbo.DMX_AttributeEntrytypes
WHERE
 AttributeId = @AttributeId
GO
