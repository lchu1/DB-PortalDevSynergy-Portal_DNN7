SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetDefaultLanguageByModule]
(
	@ModuleList NVARCHAR(4000)
)
AS
BEGIN
	SET NOCOUNT ON

SELECT DISTINCT m.ModuleID, p.DefaultLanguage
FROM            dbo.[Modules]  m
INNER JOIN      dbo.[Portals] p ON p.PortalID = m.PortalID
Inner Join		dbo.[SplitStrings_CTE](@ModuleList,',') ML ON M.ModuleID = ML.item
ORDER BY        m.ModuleID	
		
END
GO
