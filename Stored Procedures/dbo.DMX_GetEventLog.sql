SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEventLog]
AS
SELECT *
FROM dbo.EventLog
WHERE LogTypeKey LIKE '%_EXCEPTION'
ORDER BY LogCreateDate
GO