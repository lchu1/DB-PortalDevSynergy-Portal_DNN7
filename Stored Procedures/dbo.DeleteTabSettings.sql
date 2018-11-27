SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteTabSettings]
	@TabID  Int -- Not Null!
AS
BEGIN
	DELETE	
	 FROM  dbo.[TabSettings]
	 WHERE TabID = @TabID;
END; -- Procedure
GO
