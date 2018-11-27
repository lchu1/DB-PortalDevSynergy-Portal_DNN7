SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateAddon]
 @AddonKey NVARCHAR (50), 
 @Availability NVARCHAR (255), 
 @Controller NVARCHAR (255), 
 @Description NVARCHAR (255), 
 @Features INT, 
 @Installed DATETIME, 
 @Name NVARCHAR (50)
AS
UPDATE dbo.DMX_Addons SET
 [Availability] = @Availability,
 [Controller] = @Controller,
 [Description] = @Description,
 [Features] = @Features,
 [Installed] = @Installed,
 [Name] = @Name
WHERE
 [AddonKey] = @AddonKey
GO
