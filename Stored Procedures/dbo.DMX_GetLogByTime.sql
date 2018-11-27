SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetLogByTime]
 @PortalId Int,
 @StartTime DATETIME,
 @EndTime DATETIME
AS
SELECT
 [Action],
 MAX([Datime]) AS [Datime],
 EntryId, 
 MAX(LogId) AS LogId,
 UserId, 
 PortalId, 
 LogTypeKey, 
 ResourceFile, 
 AttachFile, 
 CustomSend, 
 NotifyApprovers, 
 NotifyAudit, 
 NotifyEditors, 
 NotifyOwner, 
 NotifySelf, 
 NotifySubscribers, 
 Username, 
 DisplayName
FROM
 (SELECT *
  FROM dbo.vw_DMX_Log
  WHERE
   PortalId = @PortalId
   AND Datime >= @StartTime
   AND Datime < @EndTime) x
GROUP BY
 [Action],
 EntryId, 
 UserId, 
 PortalId, 
 LogTypeKey, 
 ResourceFile, 
 AttachFile, 
 CustomSend, 
 NotifyApprovers, 
 NotifyAudit, 
 NotifyEditors, 
 NotifyOwner, 
 NotifySelf, 
 NotifySubscribers, 
 Username, 
 DisplayName
GO
