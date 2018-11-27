SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetPortalRoles]
    @PortalId     Int -- Null: Host Roles
AS
BEGIN
    SELECT R.*,
          (SELECT COUNT(*) FROM dbo.[UserRoles] U 
				WHERE U.RoleID = R.RoleID 
					AND U.Status = 1 
					AND (U.EffectiveDate < GETDATE() OR U.EffectiveDate IS NULL)
                    AND (U.ExpiryDate > GETDATE() OR U.ExpiryDate IS NULL)) AS UserCount
     FROM dbo.[Roles] R
    WHERE (R.PortalId = @PortalId OR R.PortalId is null)
      AND (R.RoleId >= 0) -- DNN-4288: hide system role atm to prevent duplicates. Might be removed, after API has been adopt
    ORDER BY R.RoleName
	OPTION (OPTIMIZE FOR (@PortalId UNKNOWN))
END
GO
