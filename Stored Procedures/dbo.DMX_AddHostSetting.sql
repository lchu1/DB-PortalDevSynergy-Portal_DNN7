SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddHostSetting]
 @SettingName nvarchar(50),
 @SettingValue nvarchar(256)
AS
INSERT INTO dbo.HostSettings (
 SettingName,
 SettingValue,
 SettingIsSecure
) 
VALUES (
 @SettingName,
 @SettingValue,
 0
)
GO
