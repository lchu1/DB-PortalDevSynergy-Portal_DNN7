SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddAttribute]
 @PortalId INT, 
 @Addon NVARCHAR (50), 
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
INSERT INTO dbo.DMX_Attributes (
 [PortalId],
 [Addon],
 [AttributeName],
 [CollectionId],
 [ControlToLoad],
 [IsPrivate],
 [Key],
 [Required],
 [ResourceFile],
 [ShowInUI],
 [Values],
 [ValueType],
 [ViewOrder]
)
 VALUES ( @PortalId, @Addon, @AttributeName, @CollectionId, @ControlToLoad, @IsPrivate, @Key, @Required, @ResourceFile, @ShowInUI, @Values, @ValueType, @ViewOrder)
select SCOPE_IDENTITY()
GO
