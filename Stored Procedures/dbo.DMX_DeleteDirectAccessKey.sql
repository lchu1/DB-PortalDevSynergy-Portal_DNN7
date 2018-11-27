SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteDirectAccessKey]
 @PortalId INT,
 @Key NVARCHAR (100)
AS
DELETE FROM dbo.DMX_DirectAccessKeys
WHERE
 [PortalId] = @PortalId
 AND [Key] = @Key
GO
