SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetNotification]
 @LogId INT,
 @UserId INT
AS
SELECT
 *
FROM
 dbo.vw_DMX_Notifications
WHERE
 [LogId] = @LogId
 AND [RecipientUserId] = @UserId
GO
