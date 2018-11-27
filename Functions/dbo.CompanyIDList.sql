SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE function [dbo].[CompanyIDList]( @USERID int)

RETURNS VARCHAR(500)
AS
BEGIN
DECLARE @CompanyIDList varchar(5000)

SELECT @CompanyIDList = COALESCE(@CompanyIDList + ', ', '') + 
   --CAST(CompanyID AS varchar(20)) 
   CAST(REPLACE(CompanyID,'-','') AS varchar(20)) -- Updated to strip out hyphens for matching, CTA, 05/17/2016
FROM  _CHCN_COMPANY_VS
WHERE USERID = @USERID

RETURN @CompanyIDList

END



GO
