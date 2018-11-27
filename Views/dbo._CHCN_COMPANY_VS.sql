SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[_CHCN_COMPANY_VS]
AS
SELECT     TOP 100 PERCENT dbo._CHCN_CompanyID_V.UserID, dbo._CHCN_Company_V.PropertyValue AS Company, 
                      dbo._CHCN_CompanyID_V.PropertyValue AS CompanyID
FROM         dbo._CHCN_Company_V INNER JOIN
                      dbo._CHCN_CompanyID_V ON dbo._CHCN_Company_V.UserID = dbo._CHCN_CompanyID_V.UserID AND 
                      dbo._CHCN_Company_V.Seq = dbo._CHCN_CompanyID_V.Seq
ORDER BY dbo._CHCN_CompanyID_V.UserID, dbo._CHCN_CompanyID_V.Seq



GO
