SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddDirectAccessKey]
 @PortalId INT, 
 @Downloads INT, 
 @Email NVARCHAR (100), 
 @EntryId INT, 
 @Expires DATETIME, 
 @Key NVARCHAR (100), 
 @UserId INT
AS
IF EXISTS (SELECT * FROM dbo.DMX_DirectAccessKeys
   WHERE PortalId=@PortalId AND [Key]=@Key)
 SELECT 0
ELSE
INSERT INTO dbo.DMX_DirectAccessKeys (
 [PortalId],
 [Downloads],
 [Email],
 [EntryId],
 [Expires],
 [Key],
 [UserId])
VALUES (
 @PortalId,
 @Downloads,
 @Email,
 @EntryId,
 @Expires,
 @Key,
 @UserId);
 SELECT 1;
GO
