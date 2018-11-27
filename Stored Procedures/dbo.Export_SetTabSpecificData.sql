SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_SetTabSpecificData]
	@TabId     int,
	@IsDeleted bit,
	@IsVisible bit
AS
BEGIN
    UPDATE dbo.Tabs
    SET IsDeleted = @IsDeleted,
		IsVisible = @IsVisible
    WHERE TabId = @TabId
END
GO
