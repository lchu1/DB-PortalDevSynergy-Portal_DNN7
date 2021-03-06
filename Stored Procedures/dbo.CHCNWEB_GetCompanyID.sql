SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO


CREATE PROCEDURE [dbo].[CHCNWEB_GetCompanyID]

@UserID int

as

SELECT     Company, CompanyID
FROM         _CHCN_COMPANY_VS
WHERE     (UserID = @USERID) AND NULLIF(Company,' ') IS NOT NULL AND NULLIF(CompanyID,' ') IS NOT NULL


GO
