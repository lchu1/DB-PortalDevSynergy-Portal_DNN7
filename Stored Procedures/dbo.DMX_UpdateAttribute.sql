SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateAttribute]
 @PortalId INT, 
 @Addon NVARCHAR (50), 
 @AttributeId INT, 
 @AttributeName NVARCHAR (200), 
 @CollectionId INT, 
 @ControlToLoad NVARCHAR (255), 
 @IsPrivate BIT, 
 @Key NVARCHAR (50), 
 @Required BIT, 
 @ResourceFile NVARCHAR (255), 
 @ShowInUI BIT, 
 @Values NVARCHAR (2000), 
 @ValueType NVARCHAR (30), 
 @ViewOrder INT
AS
UPDATE dbo.DMX_Attributes SET
 [PortalId] = @PortalId,
 [Addon] = @Addon,
 [AttributeName] = @AttributeName,
 [CollectionId] = @CollectionId,
 [ControlToLoad] = @ControlToLoad,
 [IsPrivate] = @IsPrivate,
 [Key] = @Key,
 [Required] = @Required,
 [ResourceFile] = @ResourceFile,
 [ShowInUI] = @ShowInUI,
 [Values] = @Values,
 [ValueType] = @ValueType,
 [ViewOrder] = @ViewOrder
WHERE
 [AttributeId] = @AttributeId
GO
