SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DirectAccess]
 @PortalId INT,
 @Key NVARCHAR (100)
AS
DECLARE @Result INT
SET @Result = -1
IF EXISTS (SELECT * FROM dbo.DMX_DirectAccessKeys
 WHERE PortalId=@PortalId AND [Key]=@Key AND Downloads>0 AND Expires>GETDATE())
BEGIN
 SET @Result = (SELECT EntryId
 FROM dbo.DMX_DirectAccessKeys
 WHERE [PortalId] = @PortalId
  AND [Key] = @Key);
 UPDATE dbo.DMX_DirectAccessKeys
 SET Downloads=Downloads-1
 WHERE PortalId=@PortalId AND [Key]=@Key;
 EXEC dbo.DMX_CleanUpDirectAccessKeys;
END
SELECT @Result
GO
