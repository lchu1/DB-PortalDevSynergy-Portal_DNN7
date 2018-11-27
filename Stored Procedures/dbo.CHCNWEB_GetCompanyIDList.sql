SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE       PROCEDURE [dbo].[CHCNWEB_GetCompanyIDList]

@UserID int

as


SELECT  DISTINCT dbo.CompanyList(@USERID) As CompanyList,
	dbo.CompanyIDList(@USERID) As CompanyIDList
FROM         _CHCN_COMPANY_VS
WHERE  (UserID = @USERID)

GO
