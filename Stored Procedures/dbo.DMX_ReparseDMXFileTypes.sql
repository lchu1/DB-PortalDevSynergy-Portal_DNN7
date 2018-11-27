SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_ReparseDMXFileTypes]
 @PortalId INT,
 @ExtensionKey NVARCHAR (50),
 @Extension VARCHAR (10)
AS
DISABLE TRIGGER dbo.DMX_EntryTriggerUpdate ON dbo.DMX_Entries;
UPDATE dbo.DMX_Entries
 SET EntryType=@ExtensionKey
 WHERE OriginalFilename LIKE '%.'+@Extension
  AND PortalId=@PortalId;
ENABLE TRIGGER dbo.DMX_EntryTriggerUpdate ON dbo.DMX_Entries;
GO
