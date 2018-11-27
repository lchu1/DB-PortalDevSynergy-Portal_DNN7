SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_UpdateTabUrlChangers]
	@TabId           int,
	@SeqNum          int,
	@CreatedBy       int,
	@ModifiedBy      int
AS
BEGIN
    UPDATE dbo.TabUrls
    SET CreatedByUserID = @CreatedBy, LastModifiedByUserID = @ModifiedBy
    WHERE TabId = @TabId AND SeqNum = @SeqNum
END
GO
