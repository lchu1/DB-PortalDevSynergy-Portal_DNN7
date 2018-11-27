SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







create function [dbo].[CompanyList]( @USERID int)

RETURNS VARCHAR(500)
AS
BEGIN
DECLARE @CompanyList varchar(5000)

SELECT @CompanyList = COALESCE(@CompanyList + ', ', '') + 
   CAST(Company AS varchar(40)) 
FROM  _CHCN_COMPANY_VS
WHERE USERID = @USERID

RETURN @CompanyList

END
GO
