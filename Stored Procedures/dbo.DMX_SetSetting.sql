SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SetSetting]
 @PortalId INT,
 @SettingName NVARCHAR (50),
 @SettingValue NVARCHAR (2000)
AS
IF EXISTS (SELECT * FROM dbo.DMX_Settings WHERE [PortalId] = @PortalId AND [SettingName] = @SettingName)
 UPDATE dbo.DMX_Settings SET
  [SettingValue] = @SettingValue
 WHERE
  [PortalId] = @PortalId
  AND [SettingName] = @SettingName
ELSE
 INSERT INTO dbo.DMX_Settings (
  [PortalId],
  [SettingName],
  SettingValue
 ) VALUES (
  @PortalId,
  @SettingName,
  @SettingValue
 )
GO
