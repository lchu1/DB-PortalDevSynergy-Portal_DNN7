SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddAddon]
 @AddonKey NVARCHAR (50), 
 @Availability NVARCHAR (255), 
 @Controller NVARCHAR (255), 
 @Description NVARCHAR (255), 
 @Features INT, 
 @Installed DATETIME, 
 @Name NVARCHAR (50)
AS
INSERT INTO dbo.DMX_Addons (
 [AddonKey],
 [Availability],
 [Controller],
 [Description],
 [Features],
 [Installed],
 [Name]
)
 VALUES ( @AddonKey, @Availability, @Controller, @Description, @Features, @Installed, @Name)
GO
