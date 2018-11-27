SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_RemoveOldUserSubscriptions]
AS
-- DNN 5+
BEGIN TRY
 EXEC('DELETE FROM dbo.DMX_Subscriptions
FROM dbo.DMX_Subscriptions s
 INNER JOIN dbo.DMX_Entries e ON s.EntryId=e.EntryId
WHERE
 NOT EXISTS (SELECT up.UserId FROM dbo.UserPortals up WHERE up.PortalId=e.PortalId AND up.UserId=s.UserId AND up.Authorised=1 AND up.IsDeleted=0)
 OR NOT EXISTS (SELECT u.UserId FROM dbo.Users u WHERE u.UserId=s.UserId)');
END TRY
BEGIN CATCH
END CATCH;
GO
