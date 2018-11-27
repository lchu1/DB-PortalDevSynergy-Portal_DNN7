CREATE ROLE [aspnet_Membership_ReportingAccess]
AUTHORIZATION [DNN_USER_OLD]
GO
EXEC sp_addrolemember N'aspnet_Membership_ReportingAccess', N'aspnet_Membership_FullAccess'
GO
