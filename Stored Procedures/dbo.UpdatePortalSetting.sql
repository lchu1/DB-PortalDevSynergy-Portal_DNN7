SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[UpdatePortalSetting]
--  covers delete, add and update scenarios:
	@PortalID       Int,		   -- Key, Not Null (unless for delete)
	@SettingName    nVarChar( 50), -- Key, not Null or Empty
	@SettingValue   nVarChar(Max), -- Not Null
	@UserID			Int,		   -- Not Null (editing user)
	@CultureCode    nVarChar( 10), -- Key, Null|'' for neutral language
	@IsSecure       Bit = 0        -- NotNUll default 0
AS
BEGIN
	-- empty value: remove setting
	IF IsNull(@SettingValue, N'') = N'' AND IsNull(@SettingName, N'') != N''
		DELETE FROM dbo.[PortalSettings]
		 WHERE IsNull(PortalID, -1) = IsNull(@PortalID, -1)
		   AND (CultureCode = @CultureCode OR IsNull(@CultureCode, N'') = N'')
		   AND SettingName = @SettingName;
	ELSE IF IsNull(@SettingName, N'') != N'' AND IsNull(@PortalID, -1) != -1 BEGIN -- key must be valid
		MERGE INTO dbo.[PortalSettings] S
		 USING (SELECT @PortalID PID, @CultureCode CC, @SettingName SN, @SettingValue SV, @IsSecure Sec) Q
		    ON (S.PortalID = Q.PID AND IsNull(S.CultureCode, N'') = IsNull(Q.CC, N'') AND S.SettingName = Q.SN)
		 WHEN MATCHED AND IsNull(S.SettingValue, N'') != IsNull(Q.SV, N'') THEN -- update only, if value has been modified:
			UPDATE SET [SettingValue] = Q.SV, [LastModifiedByUserID] = @UserID, [LastModifiedOnDate] = GetDate()
		 WHEN NOT MATCHED THEN
		    INSERT ( PortalID,  SettingName,  SettingValue, CultureCode,               CreatedByUserID    , CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
			VALUES (@PortalID, @SettingName, @SettingValue, NULLIF(@CultureCode, N''), IsNull(@UserID, -1),     GetDate(),  IsNull(@UserID, -1),          GetDate());
		-- Saving a neutral setting overwrites all localized settings with same name (for current portal):
		IF IsNull(@CultureCode, N'') = N''
			DELETE FROM dbo.[PortalSettings]
			 WHERE PortalID = @PortalID AND SettingName = @SettingName AND CultureCode IS Not Null;
	END; -- Else If
END; -- Procedure
GO
