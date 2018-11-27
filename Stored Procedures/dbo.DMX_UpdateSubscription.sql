SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateSubscription]
 @EntryId INT, 
 @LastAccess DATETIME, 
 @UserId INT
AS
UPDATE dbo.DMX_Subscriptions SET
 [LastAccess] = @LastAccess
WHERE
 [EntryId] = @EntryId
 AND [UserId] = @UserId
GO
