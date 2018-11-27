SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateLog]
 @PortalId INT, 
 @Action NVARCHAR (20), 
 @Datime DATETIME, 
 @EntryId INT, 
 @LogId INT, 
 @UserId INT
AS
UPDATE dbo.DMX_Log SET
 [PortalId] = @PortalId,
 [Action] = @Action,
 [Datime] = @Datime,
 [EntryId] = @EntryId,
 [UserId] = @UserId
WHERE
 [LogId] = @LogId
GO
