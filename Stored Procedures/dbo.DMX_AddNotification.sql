SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddNotification]
 @PortalId INT, 
 @LogId INT, 
 @Sent DATETIME, 
 @Template NVARCHAR (100), 
 @UserId INT
AS
INSERT INTO dbo.DMX_Notifications (
 [PortalId],
 [LogId],
 [Sent],
 [Template],
 [UserId])
VALUES (
 @PortalId,
 @LogId,
 @Sent,
 @Template,
 @UserId)
GO
