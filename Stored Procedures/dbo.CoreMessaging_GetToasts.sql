SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[CoreMessaging_GetToasts] 
 	@UserId INT
	,@PortalId INT
AS
BEGIN
	SELECT DISTINCT m.*
	FROM dbo.[CoreMessaging_MessageRecipients] mr
		INNER JOIN dbo.[CoreMessaging_Messages] m 
			ON (mr.MessageID = m.MessageID)
	WHERE mr.UserID = @UserID
		AND m.PortalID = @PortalID
		--Added to allow a single index to cover both this and the other two messaging procs:
		--dbo.[CoreMessaging_CountNotifications]
		--CoreMessaging_CountNewThreads
		AND mr.[Read] in (0,1)
		AND mr.SendToast = 1
END
GO
