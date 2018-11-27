SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteSetting]
 @PortalId INT,
 @SettingName NVARCHAR (50)
AS
DELETE FROM dbo.DMX_Settings
WHERE
 [PortalId] = @PortalId
 AND [SettingName] = @SettingName
GO
