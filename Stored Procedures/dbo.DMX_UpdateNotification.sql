SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateNotification]
 @PortalId INT, 
 @LogId INT, 
 @Sent DATETIME, 
 @Template NVARCHAR (100), 
 @UserId INT
AS
UPDATE dbo.DMX_Notifications SET
 [PortalId] = @PortalId,
 [Sent] = @Sent,
 [Template] = @Template
WHERE
 [LogId] = @LogId
 AND [UserId] = @UserId
GO
