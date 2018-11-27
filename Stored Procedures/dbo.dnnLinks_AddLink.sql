SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[dnnLinks_AddLink]

	@ModuleId    int,
	@UserId      int,
	@CreatedDate datetime,
	@Title       nvarchar(100),
	@Url         nvarchar(250),
	@ViewOrder   int,
	@Description nvarchar(2000),
	@RefreshInterval int,
	@GrantRoles nvarchar(500)

AS

INSERT INTO dbo.Links (
	ModuleId,
	CreatedByUser,
	CreatedDate,
	Title,
	Url,
	ViewOrder,
	Description,
	RefreshInterval,
	GrantRoles
)
VALUES (
	@ModuleId,
	@UserId,
	@CreatedDate,
	@Title,
	@Url,
	@ViewOrder,
	@Description,
	@RefreshInterval,
	@GrantRoles
)

SELECT SCOPE_IDENTITY()
GO
