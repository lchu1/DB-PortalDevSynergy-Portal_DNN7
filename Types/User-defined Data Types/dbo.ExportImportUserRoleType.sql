CREATE TYPE [dbo].[ExportImportUserRoleType] AS TABLE
(
[PortalId] [int] NULL,
[UserId] [int] NULL,
[RoleId] [int] NULL,
[ExpiryDate] [datetime] NULL,
[IsTrialUsed] [bit] NULL,
[EffectiveDate] [datetime] NULL,
[CreatedByUserId] [int] NULL,
[LastModifiedByUserId] [int] NULL,
[Status] [int] NULL,
[IsOwner] [bit] NULL,
[IsSuperUser] [bit] NULL
)
GO
