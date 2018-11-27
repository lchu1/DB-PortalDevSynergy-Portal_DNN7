SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_RemoveOldUserNotifications]
AS
DELETE FROM dbo.DMX_Notifications
FROM dbo.DMX_Notifications n
 INNER JOIN dbo.DMX_Log l ON l.LogId=n.LogId
 INNER JOIN dbo.DMX_Entries e ON e.EntryId=l.EntryId
 LEFT JOIN dbo.UserPortals up ON up.UserId=n.UserId AND up.PortalId=e.PortalId
WHERE n.Sent IS NULL AND
 up.UserPortalId IS NULL
GO
