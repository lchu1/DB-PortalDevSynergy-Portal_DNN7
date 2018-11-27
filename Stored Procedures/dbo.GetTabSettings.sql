SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetTabSettings]
    @PortalId Int -- Null|-1 for Host Pages
AS
BEGIN
	SELECT S.TabID,
		   S.SettingName,
		   CASE WHEN Lower(S.SettingValue) LIKE N'fileid=%'
			 	THEN dbo.[FilePath](S.SettingValue)
				ELSE S.SettingValue 
		   END AS SettingValue
	 FROM  dbo.[TabSettings] S
	 JOIN  dbo.[Tabs]        T ON t.TabID = S.TabID
	 WHERE  ISNull(PortalId, -1) = isNull(@PortalId, -1)
	 ORDER BY S.TabID;
END; -- Procedure
GO
