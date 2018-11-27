SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[CoreMessaging_CreateMessageRecipientsForRole]
    @MessageID int,         -- message id
    @RoleIDs nvarchar(max), -- comma separated list of RoleIds
	@CreateUpdateUserID INT -- create / update user id
AS
BEGIN    

    INSERT dbo.[CoreMessaging_MessageRecipients](
			[MessageID],
			[UserID],
			[Read],
			[Archived],
            [CreatedByUserID],
            [CreatedOnDate],
            [LastModifiedByUserID],
            [LastModifiedOnDate]
            )
			SELECT distinct 
			  @MessageID,
			  UserID,
			  0,
			  0,
              @CreateUpdateUserID , -- CreatedBy - int
              GETDATE(), -- CreatedOn - datetime
              @CreateUpdateUserID , -- LastModifiedBy - int
              GETDATE() -- LastModifiedOn - datetime
           FROM dbo.[vw_UserRoles] ur
			INNER JOIN dbo.[SplitStrings_CTE](@RoleIDs,',') m on ur.RoleID = m.Item
			WHERE ur.ExpiryDate >= getdate() OR ur.ExpiryDate IS NULL
END
GO
