SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetAttributeLocalizations]
 @AttributeId INT
AS
SELECT *
FROM dbo.DMX_AttributesML
WHERE [AttributeId] = @AttributeId
GO
