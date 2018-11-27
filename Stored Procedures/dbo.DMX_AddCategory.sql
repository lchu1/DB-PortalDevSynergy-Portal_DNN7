SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddCategory]
 @PortalId INT, 
 @CategoryName NVARCHAR (200), 
 @ParentId INT, 
 @ViewOrder INT
AS
INSERT INTO dbo.DMX_Categories (
 [PortalId],
 [CategoryName],
 [ParentId],
 [ViewOrder]
)
 VALUES ( @PortalId, @CategoryName, @ParentId, @ViewOrder)
select SCOPE_IDENTITY()
GO
