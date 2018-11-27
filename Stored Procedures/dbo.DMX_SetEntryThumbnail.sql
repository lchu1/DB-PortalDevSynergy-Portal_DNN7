SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SetEntryThumbnail]
 @PortalId INT,
 @EntryId INT,
 @Thumbnail VARCHAR(200)
AS
UPDATE dbo.DMX_Entries
SET Thumbnail = @Thumbnail
WHERE PortalId = @PortalId
 AND EntryId = @EntryId
GO
