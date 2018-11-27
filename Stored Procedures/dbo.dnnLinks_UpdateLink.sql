SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[dnnLinks_UpdateLink]

	@ItemId				 int,
	@UserId				 int,
	@CreatedDate		 DateTime,
	@Title				 nvarchar(100),
	@Url				 nvarchar(250),
	@ViewOrder			 int,
	@Description		 nvarchar(2000),
	@RefreshInterval	 int,
    @GrantRoles           nvarchar(500)
AS

UPDATE dbo.Links
SET    CreatedByUser   = @UserId,
       CreatedDate     = @CreatedDate,
       Title           = @Title,
       Url             = @Url,
       ViewOrder       = @ViewOrder,
       Description     = @Description,
       RefreshInterval = @RefreshInterval,
       GrantRoles       = @GrantRoles
WHERE  ItemId = @ItemId
GO
