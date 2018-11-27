SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetUnsentNotifications]
 @PortalId int,
 @UserId Int
AS
SELECT
 *
FROM
 dbo.vw_DMX_Notifications
WHERE
 [RecipientUserId] = @UserId
 AND [PortalId] = @PortalId
 AND [Sent] IS NULL
GO
