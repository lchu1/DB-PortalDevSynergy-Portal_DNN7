SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetSubscriptionsByUser]
 @UserId Int
AS
SELECT
 *
FROM
 dbo.DMX_Subscriptions
WHERE
 UserId = @UserId
GO
