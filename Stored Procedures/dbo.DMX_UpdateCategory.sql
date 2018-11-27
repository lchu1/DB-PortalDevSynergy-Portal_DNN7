SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateCategory]
 @PortalId INT, 
 @CategoryId INT, 
 @CategoryName NVARCHAR (200), 
 @ParentId INT, 
 @ViewOrder INT
AS
UPDATE dbo.DMX_Categories SET
 [PortalId] = @PortalId,
 [CategoryName] = @CategoryName,
 [ParentId] = @ParentId,
 [ViewOrder] = @ViewOrder
WHERE
 [CategoryId] = @CategoryId
GO
