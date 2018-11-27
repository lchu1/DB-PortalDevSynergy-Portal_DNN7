SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE  function [dbo].[CHCNWEBGetUserFax]( @UserID int)

RETURNS VARCHAR(12)
AS
BEGIN

DECLARE

@Fax varchar(12)

SELECT   @Fax = PropertyValue
from UserProfile
where userid = @UserID and PropertyDefinitionID = '30'

RETURN @Fax

END

GO
