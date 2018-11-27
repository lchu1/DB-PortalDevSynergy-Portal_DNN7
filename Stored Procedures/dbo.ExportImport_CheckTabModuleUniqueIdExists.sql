SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImport_CheckTabModuleUniqueIdExists]
	@UniqueId uniqueidentifier
AS
BEGIN
SELECT TOP 1 TabModuleId FROM dbo.[TabModules] 
	WHERE UniqueId = @UniqueId 
END
GO
