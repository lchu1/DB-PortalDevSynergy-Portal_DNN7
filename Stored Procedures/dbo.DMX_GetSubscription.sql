SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetSubscription]
 @EntryId INT,
 @UserId INT
AS
SELECT
 *
FROM
 dbo.DMX_Subscriptions
WHERE
 [EntryId] = @EntryId
 AND [UserId] = @UserId
GO
