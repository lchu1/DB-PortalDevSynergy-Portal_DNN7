SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddLog]
 @PortalId INT, 
 @Action NVARCHAR (20), 
 @Datime DATETIME, 
 @EntryId INT, 
 @UserId INT
AS
INSERT INTO dbo.DMX_Log (
 [PortalId],
 [Action],
 [Datime],
 [EntryId],
 [UserId]
)
 VALUES ( @PortalId, @Action, @Datime, @EntryId, @UserId)
select SCOPE_IDENTITY()
GO
