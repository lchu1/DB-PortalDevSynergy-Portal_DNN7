SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddSubscription]
 @EntryId INT, 
 @LastAccess DATETIME, 
 @UserId INT
AS
INSERT INTO dbo.DMX_Subscriptions (
 [EntryId],
 [LastAccess],
 [UserId])
VALUES (
 @EntryId,
 @LastAccess,
 @UserId)
GO
