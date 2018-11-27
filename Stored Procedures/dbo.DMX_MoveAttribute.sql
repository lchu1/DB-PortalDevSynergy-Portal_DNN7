SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_MoveAttribute]
 @PortalId INT,
 @AttributeId INT,
 @Displacement INT
AS
BEGIN
DECLARE @CollectionId INT
SET @CollectionId = (SELECT CollectionId FROM dbo.DMX_Attributes WHERE PortalId=@PortalId AND AttributeId=@AttributeId)
DECLARE @LastIndex INT
SET @LastIndex = (SELECT COUNT(*) FROM dbo.DMX_Attributes WHERE PortalId=@PortalId AND CollectionId=@CollectionId)
DECLARE @OldIndex INT
SET @OldIndex = (SELECT ViewOrder FROM dbo.DMX_Attributes WHERE PortalId=@PortalId AND AttributeId=@AttributeId)
DECLARE @NewIndex INT
SET @NewIndex = @OldIndex + @Displacement
IF @NewIndex > -1 AND @NewIndex < @LastIndex
 BEGIN
  DECLARE @ReplacedAttribute INT
  SET @ReplacedAttribute = (SELECT AttributeId FROM dbo.DMX_Attributes WHERE PortalId=@PortalId AND CollectionId=@CollectionId AND ViewOrder=@NewIndex)
  UPDATE dbo.DMX_Attributes
   SET ViewOrder = @NewIndex
   WHERE PortalId=@PortalId AND AttributeId=@AttributeId;
  UPDATE dbo.DMX_Attributes
   SET ViewOrder = @OldIndex
   WHERE PortalId=@PortalId AND AttributeId=@ReplacedAttribute;
 END
END
GO
