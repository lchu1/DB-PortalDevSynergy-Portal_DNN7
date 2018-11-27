SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetSetting]
 @PortalId INT,
 @SettingName NVARCHAR (50)
AS
SELECT
 *
FROM
 dbo.DMX_Settings
WHERE
 [PortalId] = @PortalId
 AND [SettingName] = @SettingName
GO
