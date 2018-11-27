SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE  function [dbo].[CHCNWEBGetUserPhone]( @UserID int)

RETURNS VARCHAR(12)
AS
BEGIN

DECLARE

@Phone varchar(12)

SELECT   @Phone = PropertyValue
from UserProfile
where userid = @UserID and PropertyDefinitionID = '28'

RETURN @Phone

END

GO
