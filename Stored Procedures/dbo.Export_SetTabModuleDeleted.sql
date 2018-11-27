SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_SetTabModuleDeleted]
	@TabModuleId int,
	@IsDeleted   bit
AS
BEGIN
    UPDATE dbo.TabModules
    SET IsDeleted = @IsDeleted
    WHERE TabModuleId = @TabModuleId
END
GO
