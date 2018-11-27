SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_UpdateRoleSettingChangers]
	@RoleID      int,
	@SettingName nvarchar(50),
	@CreatedBy   int,
	@ModifiedBy  int
AS
	UPDATE
		dbo.RoleSettings
	SET
		CreatedByUserID = @CreatedBy,
		LastModifiedByUserID = @ModifiedBy
	WHERE
		RoleID = @RoleID
      AND
        SettingName = @SettingName
GO
