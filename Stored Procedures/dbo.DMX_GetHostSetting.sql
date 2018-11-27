SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetHostSetting]
 @SettingName nvarchar(50)
AS
SELECT *
FROM dbo.HostSettings
WHERE SettingName = @SettingName
GO
