SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteSubscription]
 @EntryId INT,
 @UserId INT
AS
DELETE FROM dbo.DMX_Subscriptions
WHERE
 [EntryId] = @EntryId
 AND [UserId] = @UserId
GO
