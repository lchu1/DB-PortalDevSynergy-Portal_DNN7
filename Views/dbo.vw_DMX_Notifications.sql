SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_DMX_Notifications]
AS
SELECT
 n.LogId,
 n.PortalId,
 n.Sent,
 n.Template, 
 n.UserId AS RecipientUserId,
 l.Action,
 l.Datime,
 l.EntryId,
 l.UserId, 
 lt.ResourceFile,
 lt.AttachFile,
 lt.CustomSend, 
 lt.NotifyApprovers,
 lt.NotifyAudit,
 lt.NotifyEditors, 
 lt.NotifyOwner,
 lt.NotifySelf,
 lt.NotifySubscribers, 
 lt.LogTypeKey
FROM dbo.DMX_Log l
 INNER JOIN dbo.DMX_LogTypes lt ON l.PortalId = lt.PortalId AND l.Action=lt.LogTypeKey
 INNER JOIN dbo.DMX_Notifications n ON l.LogId = n.LogId
GO
