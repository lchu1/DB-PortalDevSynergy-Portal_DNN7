SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteSchedule]
@ScheduleID int
AS
DELETE FROM dbo.Schedule
WHERE ScheduleID = @ScheduleID
GO
