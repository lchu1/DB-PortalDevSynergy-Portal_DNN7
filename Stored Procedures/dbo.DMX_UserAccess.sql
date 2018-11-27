SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UserAccess]
 @UserId INT,
 @EntryId INT
AS
UPDATE dbo.DMX_Subscriptions 
SET LastAccess=GETDATE() 
WHERE (EntryId=@EntryId)
 AND (UserID=@UserId)
GO
