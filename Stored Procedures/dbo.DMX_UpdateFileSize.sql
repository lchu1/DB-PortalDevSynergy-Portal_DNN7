SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateFileSize]
 @PortalId INT,
 @EntryId INT,
 @FileSize BIGINT
AS
UPDATE dbo.DMX_Entries
SET [FileSize]=@FileSize
WHERE
 [EntryId]=@EntryId
 AND [PortalId]=@PortalId
GO
