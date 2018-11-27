SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_DMX_Log]
AS
SELECT
 l.Action,
 l.Datime,
 l.EntryId,
 l.LogId,
 l.UserId, 
 l.PortalId,
 lt.LogTypeKey,
 lt.ResourceFile,
 lt.AttachFile,
 lt.CustomSend, 
 lt.NotifyApprovers,
 lt.NotifyAudit,
 lt.NotifyEditors, 
 lt.NotifyOwner,
 lt.NotifySelf,
 lt.NotifySubscribers, 
 ISNULL(u.Username, N'') AS Username,
 ISNULL(u.DisplayName, N'') AS DisplayName
FROM dbo.DMX_Log l
 INNER JOIN dbo.DMX_LogTypes lt ON l.PortalId = lt.PortalId AND l.Action = lt.LogTypeKey
 LEFT OUTER JOIN dbo.Users u ON l.UserId = u.UserID
GO
