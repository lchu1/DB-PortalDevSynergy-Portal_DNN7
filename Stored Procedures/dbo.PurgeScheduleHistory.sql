SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PurgeScheduleHistory]
AS
BEGIN
	DELETE FROM dbo.ScheduleHistory
	WHERE ScheduleHistoryID IN (
		SELECT TOP 5000 ScheduleHistoryID FROM dbo.ScheduleHistory sh
			INNER JOIN dbo.Schedule s ON s.ScheduleID = sh.ScheduleID
		WHERE (
			  SELECT COUNT(*)
			  FROM dbo.ScheduleHistory sh2
			  WHERE sh2.ScheduleID = sh.ScheduleID
			  AND sh2.StartDate >= sh.StartDate
			  ) > s.RetainHistoryNum
		  AND s.Enabled = 1
		  AND s.RetainHistoryNum <> -1
		ORDER BY ScheduleHistoryID
	)
END
GO
