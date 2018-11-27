SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetSubscriptionsByEntry]
 @EntryId Int
AS
SELECT
 s.*,
 u.DisplayName
FROM
 dbo.Users u INNER JOIN dbo.DMX_Subscriptions s 
  ON u.UserID = s.UserId
WHERE
 s.EntryId = @EntryId
GO
