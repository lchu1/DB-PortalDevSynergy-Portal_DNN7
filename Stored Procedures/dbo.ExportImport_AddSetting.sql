SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImport_AddSetting]
    @SettingName        [nvarchar](50),
    @SettingValue        [nvarchar](MAX),
    @SettingIsSecure    [bit] = 0,
    @CreatedByUserID    [int]
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM dbo.[ExportImportSettings] WHERE [SettingName] = @SettingName)
    BEGIN
        INSERT INTO dbo.[ExportImportSettings] ([SettingName],[SettingValue],[SettingIsSecure],[CreatedByUserID],[CreatedOnDate],[LastModifiedByUserID],[LastModifiedOnDate])
            VALUES (@SettingName, @SettingValue, @SettingIsSecure, @CreatedByUserID, GETDATE(), @CreatedByUserID, GETDATE())
    END
    ELSE
    BEGIN
        UPDATE dbo.[ExportImportSettings] SET [SettingValue]=@SettingValue,[LastModifiedByUserID]=@CreatedByUserID,[LastModifiedOnDate]=GETDATE() WHERE [SettingName] = @SettingName
    END
END
GO
