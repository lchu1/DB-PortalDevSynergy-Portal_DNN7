SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateHostSetting]
 @SettingName nvarchar(50),
 @SettingValue nvarchar(256)
AS
UPDATE dbo.HostSettings
SET SettingValue = @SettingValue
WHERE SettingName = @SettingName
GO
