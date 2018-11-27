SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_UpdateUniqueId]
	@TableName			nvarchar(100),
	@PrimaryKeyName		nvarchar(100),
	@PrimaryKeyID		int,
	@UniqueId			uniqueidentifier
AS
BEGIN
	DECLARE @sqlCommand varchar(1000)

    SET @sqlCommand =
        N' UPDATE dbo.' + @TableName +
        N' SET UniqueId=''' + CONVERT(NVARCHAR(50), @UniqueId) + '''' +
        N' WHERE ' + @PrimaryKeyName + N'=' + CONVERT(nvarchar, @PrimaryKeyID) + N';'

    --PRINT (@sqlCommand)
    EXEC (@sqlCommand)
END
GO
