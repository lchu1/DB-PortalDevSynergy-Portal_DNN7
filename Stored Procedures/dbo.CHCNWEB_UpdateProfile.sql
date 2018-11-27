SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO


CREATE procedure [dbo].[CHCNWEB_UpdateProfile]

@UserId        int, 
@FirstName nvarchar(25),
@LastName nvarchar(25),
@Phone nvarchar(12),
@Fax nvarchar(12)

as

update UserProfile
set    PropertyValue = @FirstName, LastUpdatedDate = getdate()
where  UserId = @UserId and PropertyDefinitionId ='23' 

update UserProfile
set    PropertyValue = @LastName, LastUpdatedDate = getdate()
where  UserId = @UserId and PropertyDefinitionId ='25'

update UserProfile
set    PropertyValue = @Phone, LastUpdatedDate = getdate()
where  UserId = @UserId and PropertyDefinitionId ='28'

update UserProfile
set    PropertyValue = @Fax, LastUpdatedDate = getdate()
where  UserId = @UserId and PropertyDefinitionId ='30'	


GO
