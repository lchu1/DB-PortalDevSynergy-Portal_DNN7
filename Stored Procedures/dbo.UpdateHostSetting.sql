SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[UpdateHostSetting]
	@SettingName	   nvarchar( 50),
	@SettingValue	   nvarchar(Max),
	@SettingIsSecure   bit,
	@UserID	           int
AS
BEGIN
	-- empty value: remove setting
	IF IsNull(@SettingValue, N'') = N'' AND IsNull(@SettingName, N'') != N''
		DELETE FROM dbo.[HostSettings]
		 WHERE SettingName = @SettingName;
	ELSE IF IsNull(@SettingName, N'') != N'' BEGIN -- key must be valid
		MERGE INTO dbo.[HostSettings] S
		 USING (SELECT @SettingName SN, @SettingValue SV, @SettingIsSecure Sec) Q
		    ON (S.SettingName = Q.SN)
		 WHEN MATCHED AND (IsNull(S.SettingValue, N'') != IsNull(Q.SV, N'') OR S.SettingIsSecure != Q.Sec) THEN -- update only, if value has been modified:
			UPDATE SET [SettingValue] = Q.SV, [SettingIsSecure] = Q.Sec, [LastModifiedByUserID] = @UserID, [LastModifiedOnDate] = GetDate()
		 WHEN NOT MATCHED THEN 
		    INSERT ( SettingName,  SettingValue,  SettingIsSecure, CreatedByUserID    , CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
			VALUES (@SettingName, @SettingValue, @SettingIsSecure, IsNull(@UserID, -1),     GetDate(),  IsNull(@UserID, -1),          GetDate());
	END; -- Else If
END; -- Procedure
GO
