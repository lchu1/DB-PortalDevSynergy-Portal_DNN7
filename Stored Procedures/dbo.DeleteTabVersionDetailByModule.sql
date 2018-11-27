SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteTabVersionDetailByModule]
	@ModuleId   INT
AS
DELETE FROM   dbo.TabVersionDetails
WHERE  ModuleId = @ModuleId
GO
