SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_GenedicUpdateSettingsRecordChangers]
	@TableName       nvarchar(100),
	@PrimaryKeyName  nvarchar(100),
	@PrimaryKeyID    int,
	@SettingName     nvarchar(50),
	@CreatedBy       int,
	@ModifiedBy      int
AS
BEGIN
    DECLARE @sqlCommand varchar(1000)

    SET @sqlCommand =
        N' UPDATE dbo.' + @TableName +
        N' SET CreatedByUserID=' + CONVERT(nvarchar, @CreatedBy) + ', LastModifiedByUserID=' + CONVERT(nvarchar, @ModifiedBy) +
        N' WHERE ' + @PrimaryKeyName + N'=' + CONVERT(nvarchar, @PrimaryKeyID) +
        N' AND SettingName=''' + @SettingName + N''';'

    --PRINT (@sqlCommand)
    EXEC (@sqlCommand)
END
GO
