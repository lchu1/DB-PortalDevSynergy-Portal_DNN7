SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImport_CheckTabUniqueIdExists]
	@UniqueId uniqueidentifier
AS
BEGIN
SELECT TOP 1 TabId FROM dbo.[Tabs] 
	WHERE UniqueId = @UniqueId 
END
GO
