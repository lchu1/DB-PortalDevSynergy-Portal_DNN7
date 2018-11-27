SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SetAttributeLocalization]
 @AttributeId INT,
 @Locale VARCHAR(10),
 @AttributeName NVARCHAR(200)
AS
IF @AttributeName=''
 DELETE FROM dbo.DMX_AttributesML
 WHERE [AttributeId] = @AttributeId AND [Locale] = @Locale
ELSE BEGIN
 IF EXISTS (SELECT AttributeName FROM dbo.DMX_AttributesML WHERE [AttributeId] = @AttributeId AND [Locale] = @Locale)
  UPDATE dbo.DMX_AttributesML
   SET [AttributeName] = @AttributeName
   WHERE [AttributeId] = @AttributeId AND [Locale] = @Locale
 ELSE
  INSERT INTO dbo.DMX_AttributesML
   ([AttributeId], [Locale], [AttributeName])
   VALUES (@AttributeId, @Locale, @AttributeName)
END
GO
