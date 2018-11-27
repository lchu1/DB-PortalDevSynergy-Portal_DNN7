SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[SetFileHasBeenPublished] 
    @FileId                    int,
    @HasBeenPublished        bit
AS
BEGIN

    -- Change Files.HasBeenPublished to the passed value
    UPDATE dbo.[Files]
    SET     [HasBeenPublished] = @HasBeenPublished
    FROM dbo.[Files] f
    WHERE f.FileId = @FileId
END
GO
