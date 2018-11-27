SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetUsersToNotify]
 @PortalId int
AS
SELECT 
 u.*
FROM
 dbo.Users u
WHERE
 (SELECT COUNT(*) FROM dbo.DMX_Notifications n WHERE n.[UserId] = u.UserId AND n.[PortalId] = @PortalId AND n.[Sent] IS NULL)>0
GO
