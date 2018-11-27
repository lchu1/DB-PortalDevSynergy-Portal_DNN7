SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteNotification]
 @LogId INT,
 @UserId INT
AS
DELETE FROM dbo.DMX_Notifications
WHERE
 [LogId] = @LogId
 AND [UserId] = @UserId
GO
